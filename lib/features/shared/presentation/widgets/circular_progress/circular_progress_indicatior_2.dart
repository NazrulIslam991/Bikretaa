import 'package:flutter/material.dart';

class CircularProgressIndicator2 extends StatelessWidget {
  final String? message;

  const CircularProgressIndicator2({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [const CircularProgressIndicator()],
        ),
      ),
    );
  }
}
