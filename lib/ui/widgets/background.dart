import 'package:flutter/material.dart';

class Background_image extends StatelessWidget {
  const Background_image({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/Background.jpg',
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          child,
        ],
      ),
    );
  }
}
