import 'package:bikretaa/features/user/settings/supports_and_faqs/presentaion/widgets/expansion_card_widget.dart';
import 'package:flutter/material.dart';

class FAQCard extends StatelessWidget {
  final String title;
  final String description;

  const FAQCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(title: title, description: description);
  }
}
