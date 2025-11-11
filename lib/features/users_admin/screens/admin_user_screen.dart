import 'package:bikretaa/features/shared/presentation/widgets/search_bar/search_bar.dart';
import 'package:bikretaa/features/users_admin/widgets/user_card_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> users = [
    {
      "name": "Ahmed Hassan",
      "email": "ahmed@techparadise.com",
      "shop": "Tech Paradise",
      "status": "Active",
      "joined": "2024-01-15",
      "lastLogin": "2 hours ago",
    },
    {
      "name": "Fatima Ali",
      "email": "fatima@fashionhub.com",
      "shop": "Fashion Hub",
      "status": "Active",
      "joined": "2024-02-20",
      "lastLogin": "1 day ago",
    },
    {
      "name": "Omar Mahmoud",
      "email": "omar@electronicsworld.com",
      "shop": "Electronics World",
      "status": "Deactivated",
      "joined": "2024-01-08",
      "lastLogin": "5 days ago",
    },
    {
      "name": "Layla Ibrahim",
      "email": "layla@bookcorner.com",
      "shop": "Book Corner",
      "status": "Active",
      "joined": "2024-03-10",
      "lastLogin": "3 hours ago",
    },
    {
      "name": "Ahmed Hassan",
      "email": "ahmed@techparadise.com",
      "shop": "Tech Paradise",
      "status": "Active",
      "joined": "2024-01-15",
      "lastLogin": "2 hours ago",
    },
    {
      "name": "Fatima Ali",
      "email": "fatima@fashionhub.com",
      "shop": "Fashion Hub",
      "status": "Active",
      "joined": "2024-02-20",
      "lastLogin": "1 day ago",
    },
    {
      "name": "Omar Mahmoud",
      "email": "omar@electronicsworld.com",
      "shop": "Electronics World",
      "status": "Deactivated",
      "joined": "2024-01-08",
      "lastLogin": "5 days ago",
    },
    {
      "name": "Layla Ibrahim",
      "email": "layla@bookcorner.com",
      "shop": "Book Corner",
      "status": "Active",
      "joined": "2024-03-10",
      "lastLogin": "3 hours ago",
    },
  ];

  String searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final appBarBg =
        theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface;
    final appBarFore =
        theme.appBarTheme.foregroundColor ??
        theme.textTheme.titleLarge?.color ??
        (isDark ? Colors.white : Colors.black);
    final indicatorColor = theme.colorScheme.primary;
    final labelColor = theme.colorScheme.primary;
    final unselectedLabelColor =
        theme.textTheme.bodyMedium?.color ?? Colors.grey;
    final noDataColor = theme.hintColor;

    List<Map<String, dynamic>> activeUsers = users
        .where((u) => u['status'] == "Active")
        .toList();
    List<Map<String, dynamic>> inactiveUsers = users
        .where((u) => u['status'] != "Active")
        .toList();

    List<Map<String, dynamic>> filteredTotal = users
        .where(_filterUser)
        .toList();
    List<Map<String, dynamic>> filteredActive = activeUsers
        .where(_filterUser)
        .toList();
    List<Map<String, dynamic>> filteredInactive = inactiveUsers
        .where(_filterUser)
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: scaffoldBg,
        appBar: AppBar(
          title: Text(
            "User Management",
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: appBarFore,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: appBarBg,
          foregroundColor: appBarFore,
          bottom: TabBar(
            indicatorColor: indicatorColor,
            labelColor: labelColor,
            unselectedLabelColor: unselectedLabelColor,
            tabs: [
              Tab(text: "Total (${filteredTotal.length})"),
              Tab(text: "Active (${filteredActive.length})"),
              Tab(text: "Inactive (${filteredInactive.length})"),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                left: 10.w,
                right: 10.w,
                bottom: 4.h,
              ),
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: (value) => setState(() => searchQuery = value),
                hintText: "Search by name, email, or shop...",
                prefixIcon: Icons.search,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildUserList(filteredTotal, noDataColor),
                  _buildUserList(filteredActive, noDataColor),
                  _buildUserList(filteredInactive, noDataColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _filterUser(Map<String, dynamic> user) {
    final query = searchQuery.toLowerCase();
    return user['name'].toLowerCase().contains(query) ||
        user['email'].toLowerCase().contains(query) ||
        user['shop'].toLowerCase().contains(query);
  }

  Widget _buildUserList(
    List<Map<String, dynamic>> usersList,
    Color noDataColor,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: usersList.isEmpty
          ? Center(
              child: Text(
                "No users found",
                style: TextStyle(fontSize: 14.sp, color: noDataColor),
              ),
            )
          : ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) =>
                  UserCardAdmin(user: usersList[index]),
            ),
    );
  }
}
