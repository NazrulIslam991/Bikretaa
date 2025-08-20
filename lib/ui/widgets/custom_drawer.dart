import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior_2.dart';
import 'package:bikretaa/ui/widgets/confirm_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Drawer(
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
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 10.h,
                        ),
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
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.edit, size: 20.h),
                title: Text(
                  ' Edit Profile',
                  style: TextStyle(color: Colors.black, fontSize: 12.h),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.logout, size: 20.h),
                title: Text(
                  'LogOut',
                  style: TextStyle(color: Colors.black, fontSize: 12.h),
                ),
                onTap: () async {
                  final confirm = await showConfirmDialog(
                    context: context,
                    title: "Logout",
                    content: "Are you sure you want to logout?",
                    confirmText: "Logout",
                    confirmColor: Colors.red,
                  );

                  if (confirm) {
                    setState(() => _loading = true);
                    await Future.delayed(Duration(milliseconds: 300));
                    await _logout(context);
                    if (mounted) setState(() => _loading = false);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, size: 20.h),
                title: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.black, fontSize: 12.h),
                ),
                onTap: () async {
                  final confirm = await showConfirmDialog(
                    context: context,
                    title: "Delete Account",
                    content: "Are you sure you want to delete your account?",
                    confirmText: "Delete",
                    confirmColor: Colors.red,
                  );

                  if (confirm) {
                    setState(() => _loading = true);
                    await Future.delayed(Duration(milliseconds: 300));
                    await deleteAccount(context);
                    if (mounted) setState(() => _loading = false);
                  }
                },
              ),
            ],
          ),
        ),
        if (_loading) const CircularProgressIndicator2(),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (route) => false,
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;

        await FirebaseFirestore.instance.collection('users').doc(uid).delete();

        final productsSnapshot = await FirebaseFirestore.instance
            .collection("Products")
            .doc(uid)
            .collection("products_list")
            .get();
        for (var doc in productsSnapshot.docs) await doc.reference.delete();

        final salesSnapshot = await FirebaseFirestore.instance
            .collection("Sales")
            .doc(uid)
            .collection("sales_list")
            .get();
        for (var doc in salesSnapshot.docs) await doc.reference.delete();

        final paidSnapshot = await FirebaseFirestore.instance
            .collection("Paid")
            .doc(uid)
            .collection("paid_list")
            .get();
        for (var doc in paidSnapshot.docs) await doc.reference.delete();

        final dueSnapshot = await FirebaseFirestore.instance
            .collection("Due")
            .doc(uid)
            .collection("due_list")
            .get();
        for (var doc in dueSnapshot.docs) await doc.reference.delete();

        final revenueSnapshot = await FirebaseFirestore.instance
            .collection("Revenue")
            .doc(uid)
            .collection("revenue_list")
            .get();
        for (var doc in revenueSnapshot.docs) await doc.reference.delete();

        try {
          await user.delete();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'requires-recent-login') {
            await FirebaseAuth.instance.signOut();
            await showConfirmDialog(
              context: context,
              title: "Re-login Required",
              content:
                  "Please log in again to delete your account from Firebase Auth.",
              confirmText: "Ok",
              confirmColor: Colors.blue,
            );
            return;
          } else {
            rethrow;
          }
        }

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninScreen.name,
            (route) => false,
          );
        }
      }
    } catch (e) {
      print("Unexpected error: $e");
    }
  }
}
