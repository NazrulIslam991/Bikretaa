import 'package:bikretaa/app/controller/customer_controller/customer_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/model/customer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerListScreen extends StatefulWidget {
  final String title;

  const CustomerListScreen({super.key, required this.title});

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final CustomerController customerController = Get.find<CustomerController>();

  late String shopUID;
  Future<List<CustomerModel>>? customerFuture;

  @override
  void initState() {
    super.initState();
    loadShopUIDAndCustomers();
  }

  Future<void> loadShopUIDAndCustomers() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // no logged-in user
    shopUID = user.uid;

    customerFuture = customerController.getAllCustomers(shopUID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer List",
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: customerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<CustomerModel>>(
              future: customerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No customers found",
                      style: TextStyle(
                        fontSize: r.fontMedium(),
                        color: theme.textTheme.titleSmall?.color ?? Colors.grey,
                      ),
                    ),
                  );
                }

                final customers = snapshot.data!;

                return ListView.separated(
                  padding: EdgeInsets.all(r.paddingMedium()),
                  itemCount: customers.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: r.height(0.015)),
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return CustomerInformationCard(
                      customer: customer,
                      r: r,
                      theme: theme,
                    );
                  },
                );
              },
            ),
    );
  }
}

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({
    super.key,
    required this.customer,
    required this.r,
    required this.theme,
  });

  final CustomerModel customer;
  final Responsive r;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium()),
        child: Row(
          children: [
            CircleAvatar(
              radius: r.width(0.06),
              backgroundColor: theme.colorScheme.secondary,
              child: Text(
                customer.name.isNotEmpty ? customer.name[0].toUpperCase() : "?",
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  color: theme.colorScheme.onSecondary,
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
                    customer.name,
                    style: TextStyle(
                      fontSize: r.fontLarge(),
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color ?? Colors.black,
                    ),
                  ),
                  SizedBox(height: r.height(0.005)),
                  Text(
                    "Mobile: ${customer.mobile}",
                    style: TextStyle(
                      fontSize: r.fontSmall(),
                      color: theme.textTheme.titleSmall?.color ?? Colors.grey,
                    ),
                  ),
                  SizedBox(height: r.height(0.002)),
                  Text(
                    "Address: ${customer.address}",
                    style: TextStyle(
                      fontSize: r.fontSmall(),
                      color: theme.textTheme.titleSmall?.color ?? Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: r.iconSmall(),
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                // Optional: navigate to customer detail page
              },
            ),
          ],
        ),
      ),
    );
  }
}
