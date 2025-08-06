import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    splash_screen();
  }

  Future<void> splash_screen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed((context), SigninScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Background_image(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: screenSize.height * 0.4,
            width: screenSize.width * 0.6,
          ),
        ),
      ),
    );
  }
}
