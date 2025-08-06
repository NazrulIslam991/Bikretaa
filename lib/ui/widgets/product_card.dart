import 'package:bikretaa/ui/screens/bottom_nav_bar/products/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatelessWidget {
  final String productName;
  final String category;
  final String totalUnit;
  final int unitPrice;
  final String imagePath;

  const ProductCardWidget({
    super.key,
    required this.productName,
    required this.category,
    required this.totalUnit,
    required this.unitPrice,
    required this.imagePath,
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Text(
                category,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 5),
              Text(
                "Total: $totalUnit units",
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$unitPrice tk",
                    style: GoogleFonts.italianno(
                      textStyle: TextStyle(
                        color: Colors.red,
                        letterSpacing: .5,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        DetailsProductScreen.name,
                      );
                    },

                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      "show more...",
                      style: GoogleFonts.abyssinicaSil(
                        textStyle: TextStyle(
                          color: Colors.blue,
                          letterSpacing: .5,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
