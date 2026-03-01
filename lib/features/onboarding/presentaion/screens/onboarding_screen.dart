import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String name = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Manage Your Shop Smarter",
      "description":
      "Easily add products, track stock and expiry dates, and manage your shop from one place.",
      "image": AssetPaths.onboarding_1,
    },
    {
      "title": "Sell Faster & Track Dues",
      "description":
      "Create bills instantly, record sales, manage customer dues, and stay organized every day.",
      "image": AssetPaths.onboarding_2,
    },
    {
      "title": "Smart Reports & Alerts",
      "description":
      "View sales reports, get low stock alerts, and make better decisions for your shop.",
      "image": AssetPaths.onboarding_3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final data = _onboardingData[_currentPage];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _onboardingData[index]["image"]!,
                fit: BoxFit.cover,
              );
            },
          ),

          ///  Dark Overlay
          IgnorePointer(
            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),

          /// Skip Button
          Positioned(
            top: r.height(0.05),
            right: 16,
            child: TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                SigninScreen.name,
              ),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          ///  Text Content
          Positioned(
            left: 24,
            right: 24,
            bottom: r.height(0.20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  data["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          ///  Bottom Controls
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Column(
              children: [
                /// Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                        (i) => buildDot(index: i),
                  ),
                ),
                const SizedBox(height: 18),

                /// Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage ==
                        _onboardingData.length - 1) {
                      Navigator.pushReplacementNamed(
                        context,
                        SigninScreen.name,
                      );
                    } else {
                      _pageController.nextPage(
                        duration:
                        const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentPage ==
                        _onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style:  TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(right: 6),
      height: 8,
      width: _currentPage == index ? 50 : 8,
      decoration: BoxDecoration(
        color:
        _currentPage == index ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}