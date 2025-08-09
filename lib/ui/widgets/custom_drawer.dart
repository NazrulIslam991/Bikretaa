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
          DrawerHeader(
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
