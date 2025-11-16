import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/screens/add_sales_screen.dart';
import 'package:bikretaa/features/sales/screens/due_collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingMenuFAB extends StatefulWidget {
  const FloatingMenuFAB({super.key});

  @override
  State<FloatingMenuFAB> createState() => _FloatingMenuFABState();
}

class _FloatingMenuFABState extends State<FloatingMenuFAB>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void toggle() {
    if (isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: r.height(0.085),
          right: 0,
          child: ScaleTransition(
            scale: _animation,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.width(0.015),
                    vertical: r.height(0.005),
                  ),
                  margin: EdgeInsets.only(right: r.width(0.015)),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(r.radiusSmall()),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'due_collection'.tr,
                    style: r.textStyle(
                      fontSize: r.fontSmall(),
                      color: theme.colorScheme.background,
                    ),
                  ),
                ),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Navigator.pushNamed(context, DueCollectionScreen.name);
                    toggle();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.payments,
                    size: r.iconMedium(),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // -----------------------------
        // 2️⃣ Product Sale FAB
        // -----------------------------
        Positioned(
          bottom: r.height(0.16),
          right: 0,
          child: ScaleTransition(
            scale: _animation,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.width(0.015),
                    vertical: r.height(0.005),
                  ),
                  margin: EdgeInsets.only(right: r.width(0.015)),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(r.radiusSmall()),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'product_sale'.tr,
                    style: r.textStyle(
                      fontSize: r.fontSmall(),
                      color: theme.colorScheme.background,
                    ),
                  ),
                ),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Navigator.pushNamed(context, AddSalesScreen.name);
                    toggle();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    size: r.iconMedium(),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // -----------------------------
        // 3️⃣ Main FAB
        // -----------------------------
        Positioned(
          bottom: r.height(0),
          child: FloatingActionButton(
            onPressed: toggle,
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            child: AnimatedRotation(
              turns: isOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.add_box_outlined,
                size: r.iconLarge(),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
