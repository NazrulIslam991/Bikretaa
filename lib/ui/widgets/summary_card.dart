import 'package:flutter/material.dart';

class home_summary_card extends StatelessWidget {
  final int totalProducts;
  final String CardTitle;
  const home_summary_card({
    super.key,
    required this.totalProducts,
    required this.CardTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green.shade100,
                child: ClipOval(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: Image.asset(
                      'assets/images/doller.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                CardTitle,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade400,
                  fontSize: 12,
                ),
              ),
              Text(
                "$totalProducts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Show Details",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.blue.shade400,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
