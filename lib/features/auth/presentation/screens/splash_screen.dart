import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/shared/presentation/screens/main_nav_bar_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.pushReplacementNamed(context, MainNavBarScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, SigninScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Background_image(
        child: Center(
          child: Image.asset(
            AssetPaths.logo,
            height: screenSize.height * 0.4,
            width: screenSize.width * 0.6,
          ),
        ),
      ),
    );
  }
}
