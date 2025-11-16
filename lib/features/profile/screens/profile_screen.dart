import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:bikretaa/features/profile/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/presentation/share_preferences_helper/shared_preferences_helper.dart';

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
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: r.height(0.055),
        title: Text('profile'.tr, style: TextStyle(fontSize: r.fontXL())),
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
                style: TextStyle(fontSize: r.fontMedium(), color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                "no_user_data".tr,
                style: TextStyle(fontSize: r.fontMedium()),
              ),
            );
          }

          final _user = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(r.width(0.02)),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                color: theme.cardColor,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(r.width(0.04)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: r.width(0.075),
                        backgroundColor: theme.colorScheme.secondary,
                        child: Text(
                          _user.shopName.isNotEmpty ? _user.shopName[0] : "S",
                          style: TextStyle(
                            fontSize: r.fontXXL(),
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: r.width(0.04)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user.shopName,
                              style: TextStyle(
                                fontSize: r.fontXL(),
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: r.height(0.005)),
                            Text(
                              _user.shopType ?? "Shop Type not set",
                              style: TextStyle(
                                fontSize: r.fontMedium(),
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: r.height(0.005)),
                            Text(
                              _user.email,
                              style: TextStyle(
                                fontSize: r.fontMedium(),
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
              SizedBox(height: r.height(0.01)),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                color: theme.cardColor,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(r.width(0.04)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "contact_information".tr,
                        style: TextStyle(
                          fontSize: r.fontLarge(),
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Divider(color: Colors.grey.shade500),
                      SizedBox(height: r.height(0.01)),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                            size: r.iconMedium(),
                          ),
                          SizedBox(width: r.width(0.03)),
                          Text(
                            _user.email,
                            style: TextStyle(
                              fontSize: r.fontMedium(),
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: r.height(0.015)),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: Colors.green,
                            size: r.iconMedium(),
                          ),
                          SizedBox(width: r.width(0.03)),
                          Text(
                            _user.phone,
                            style: TextStyle(
                              fontSize: r.fontMedium(),
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      if (_user.createdAt != null) ...[
                        SizedBox(height: r.height(0.015)),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.orange,
                              size: r.iconMedium(),
                            ),
                            SizedBox(width: r.width(0.03)),
                            Text(
                              "Joined: ${_user.createdAt!.toLocal().toString().split(' ')[0]}",
                              style: TextStyle(
                                fontSize: r.fontMedium(),
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

              SizedBox(height: r.height(0.01)),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                elevation: 4,
                color: theme.cardColor,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit_outlined, size: r.iconLarge()),
                      title: Text(
                        "edit_profile".tr,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: r.fontMedium(),
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right, size: r.iconMedium()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.shade500),
                    ListTile(
                      leading: Icon(Icons.lock_outline, size: r.iconLarge()),
                      title: Text(
                        "change_password".tr,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: r.fontMedium(),
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right, size: r.iconMedium()),
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
