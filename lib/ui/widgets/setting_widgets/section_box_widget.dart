import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionBoxWidget extends StatelessWidget {
  final List<Widget> children;
  const SectionBoxWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: 0.8.h,
                thickness: 0.5.h,
                indent: 48.w,
                color: Colors.grey.shade300,
              ),
          ],
        ],
      ),
    );
  }
}
