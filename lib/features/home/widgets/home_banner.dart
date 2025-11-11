import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/home_screen.dart';

class HomeBannerSlider extends StatefulWidget {
  final List<HomeSlider> sliders;
  const HomeBannerSlider({super.key, required this.sliders});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h, // fixed height
      width: 340.w, // fixed width
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 95.h,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                _currentIndex.value = index;
              },
            ),
            items: widget.sliders.map((slider) {
              return Builder(
                builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      slider.assetPath,
                      width: 340.w,
                      height: 100.h,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Fixed indicator at bottom
          Positioned(
            bottom: 4.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.sliders.length; i++)
                      Container(
                        width: 8.w,
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: value == i
                              ? Colors.blueAccent
                              : Colors.white.withOpacity(0.5),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
