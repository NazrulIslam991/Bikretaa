import 'package:bikretaa/features/sales/screens/add_sales_screen.dart';
import 'package:bikretaa/features/sales/screens/due_collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // First small FAB - Due Collection
        Positioned(
          bottom: 60.h,
          right: 0,
          child: ScaleTransition(
            scale: _animation,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'Due Collection',
                    style: TextStyle(
                      fontSize: 12.sp,
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
                  child: Icon(Icons.payments, size: 20.h, color: Colors.black),
                ),
              ],
            ),
          ),
        ),

        // Second small FAB - Product Sale
        Positioned(
          bottom: 110.h,
          right: 0,
          child: ScaleTransition(
            scale: _animation,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    'Product Sale',
                    style: TextStyle(
                      fontSize: 12.sp,
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
                    size: 20.h,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Main FAB
        Positioned(
          bottom: 2.h,
          child: FloatingActionButton(
            onPressed: toggle,
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            child: AnimatedRotation(
              turns: isOpen ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.add_box_outlined,
                size: 25.h,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
