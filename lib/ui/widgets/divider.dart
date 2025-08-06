import 'package:flutter/material.dart';

class Divider_widget extends StatelessWidget {
  const Divider_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 25,
      endIndent: 25,
      color: Colors.grey,
    );
  }
}
