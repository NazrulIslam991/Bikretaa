import 'package:bikretaa/app/responsive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
    final r = Responsive.of(context);

    return SizedBox(
      height: r.height(0.135),
      width: double.infinity,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: r.height(0.135),
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
                    borderRadius: BorderRadius.circular(r.radiusMedium()),
                    child: Image.asset(
                      slider.assetPath,
                      width: double.infinity,
                      height: r.height(0.12),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Indicator
          Positioned(
            bottom: r.height(0.01),
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
                        width: r.width(0.02),
                        height: r.width(0.02),
                        margin: EdgeInsets.symmetric(
                          horizontal: r.width(0.005),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(r.width(0.01)),
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
