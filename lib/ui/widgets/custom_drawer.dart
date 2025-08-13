import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 160.h,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.h,
                    backgroundImage: AssetImage('assets/images/messi.webp'),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Md Nazrul Islam Nayon",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "nazrulislamnayon991@gmail.com",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 10.h),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home, size: 20.h),
            title: Text(
              ' Home',
              style: TextStyle(color: Colors.black, fontSize: 12.h),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit, size: 20.h),
            title: Text(
              ' Edit Profile',
              style: TextStyle(color: Colors.black, fontSize: 12.h),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, size: 20.h),
            title: Text(
              'LogOut',
              style: TextStyle(color: Colors.black, fontSize: 12.h),
            ),
            onTap: () => _logout(context),
          ),
          ListTile(
            leading: Icon(Icons.delete, size: 20.h),
            title: Text(
              'Delete Acoount',
              style: TextStyle(color: Colors.black, fontSize: 12.h),
            ),
            onTap: () => showDeleteAccountDialog(context),
          ),
        ],
      ),
    );
  }

  // logout section
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (route) => false,
    );
  }

  // pop up messege show for confirm delete account
  Future<void> showDeleteAccountDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      await deleteAcoount(context);
    }
  }

  // delete account section
  Future<void> deleteAcoount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;

        await FirebaseFirestore.instance.collection('users').doc(uid).delete();

        await user.delete();

        print("User account and Firestore document deleted successfully.");

        Navigator.pushNamedAndRemoveUntil(
          context,
          SigninScreen.name,
          (route) => false,
        );
      } else {
        print("No user is currently signed in.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print("Re-authentication required: ${e.message}");
      } else {
        print("Error deleting user account: ${e.message}");
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }
}
