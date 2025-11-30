import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/shared/presentation/share_preferences_helper/shared_preferences_helper.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior_2.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/supports_and_faqs/database/account_info_delete.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/account_deletation_card.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/email_support_card.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/faq_card.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/feedback_card.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/info_section_widget.dart';
import 'package:bikretaa/features/supports_and_faqs/widgets/section_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportFaqScreen extends StatefulWidget {
  const SupportFaqScreen({super.key});

  @override
  State<SupportFaqScreen> createState() => _SupportFaqScreenState();
}

class _SupportFaqScreenState extends State<SupportFaqScreen> {
  bool _loading = false;
  final TextEditingController _feedbackController = TextEditingController();
  int _charCount = 0;

  final Color blue = const Color(0xFF007BFF);
  final Color green = const Color(0xFF28A745);

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: Text(
          'support_faqs'.tr,
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.w700,
            color: blue,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: r.height(0.01),
          bottom: r.height(0.02),
          left: r.width(0.04),
          right: r.width(0.04),
        ),
        children: [
          SectionText(
            text: 'welcome_support'.tr,
            fontSize: r.fontLarge(),
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: r.height(0.01)),
          SectionText(
            text: 'welcome_desc'.tr,
            fontSize: r.fontMedium(),
            opacity: 0.85,
          ),
          SizedBox(height: r.height(0.025)),

          // FAQs
          FAQCard(
            title: 'faq_manage_products_title'.tr,
            description: 'faq_manage_products_desc'.tr,
          ),
          FAQCard(
            title: 'faq_track_sales_title'.tr,
            description: 'faq_track_sales_desc'.tr,
          ),
          FAQCard(
            title: 'faq_stock_alerts_title'.tr,
            description: 'faq_stock_alerts_desc'.tr,
          ),
          FAQCard(
            title: 'faq_reset_password_title'.tr,
            description: 'faq_reset_password_desc'.tr,
          ),

          // Account deletion
          AccountDeletionCard(
            theme: theme,
            onDelete: () async {
              setState(() => _loading = true);
              await _deleteAccount(context);
              if (mounted) setState(() => _loading = false);
            },
          ),
          SizedBox(height: r.height(0.025)),

          // Email Support
          InfoSection(
            icon: Icons.mail_outline,
            iconColor: blue,
            title: 'email_support'.tr,
            child: EmailSupportCard(theme: theme, onPressed: _openGmail),
          ),
          SizedBox(height: r.height(0.025)),

          // Feedback
          InfoSection(
            icon: Icons.chat_bubble_outline,
            iconColor: green,
            title: 'help_feedback'.tr,
            child: FeedbackCard(
              theme: theme,
              controller: _feedbackController,
              charCount: _charCount,
              onChanged: (v) => setState(() => _charCount = v.length),
              onSend: _sendFeedback,
            ),
          ),
          SizedBox(height: r.height(0.03)),

          // Footer
          Center(
            child: Text(
              'urgent_contact_note'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: r.fontSmall(),
                fontWeight: FontWeight.w300,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- FUNCTIONS --------------------
  Future<void> _deleteAccount(BuildContext context) async {
    final ok = await showConfirmDialog(
      context: context,
      title: "delete_account".tr,
      content: "delete_account_confirm".tr,
      confirmText: "delete_account".tr,
      confirmColor: Colors.red,
    );

    if (!ok) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CircularProgressIndicator2(),
    );

    try {
      await DeleteAccountHelper().deleteAll();
      await SharedPreferencesHelper.removeUser();

      if (mounted) Navigator.pop(context);

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SigninScreen.name,
          (predicate) => false,
        );
      }
    } catch (_) {
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _openGmail() async {
    const String to = 'support@bikretaa.com';
    final Uri gmailAppUri = Uri.parse(
      'googlegmail://co?to=$to&subject=${Uri.encodeComponent('Bikretaa App Support')}',
    );
    final Uri mailUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {'subject': 'Bikretaa App Support'},
    );

    if (await canLaunchUrl(gmailAppUri)) {
      await launchUrl(gmailAppUri);
    } else if (await canLaunchUrl(mailUri)) {
      await launchUrl(mailUri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('could_not_open_email'.tr)));
    }
  }

  void _sendFeedback() {
    final text = _feedbackController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('please_enter_feedback'.tr)));
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('feedback_sent'.tr)));
    _feedbackController.clear();
    setState(() => _charCount = 0);
  }
}
