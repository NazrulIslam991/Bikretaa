import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = SharedPreferencesHelper.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr, style: TextStyle(fontSize: 24.sp)),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "error_loading_user".tr,
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text("no_user_data".tr, style: TextStyle(fontSize: 16.sp)),
            );
          }

          // Data loaded successfully
          final _user = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: theme.cardColor,
                elevation: 4, // shadow effect
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(
                          _user.shopName.isNotEmpty ? _user.shopName[0] : "S",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user.shopName,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _user.shopType ?? "Shop Type not set",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _user.email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Contact Info Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                color: theme.cardColor,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "contact_information".tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Divider(color: Colors.grey.shade500),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.blue),
                          SizedBox(width: 12.w),
                          Text(
                            _user.email,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, color: Colors.green),
                          SizedBox(width: 12.w),
                          Text(
                            _user.phone,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      if (_user.createdAt != null) ...[
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Joined: ${_user.createdAt!.toLocal().toString().split(' ')[0]}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Actions Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 4,
                color: theme.cardColor,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit_outlined),
                      title: Text(
                        "edit_profile".tr,
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigate to edit profile screen
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.shade500),
                    ListTile(
                      leading: Icon(Icons.lock_outline),
                      title: Text(
                        "change_password".tr,
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Call change password functionality
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
