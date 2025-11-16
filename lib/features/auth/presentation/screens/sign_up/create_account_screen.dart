import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/database/firestore_user_check.dart';
import 'package:bikretaa/features/auth/presentation/database/otp_generator.dart';
import 'package:bikretaa/features/auth/presentation/database/otp_service.dart';
import 'package:bikretaa/features/auth/presentation/screens/sign_up/otp_verification_screen.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/email_feild_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
  static const name = 'Created_account';
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEcontroller = TextEditingController();
  bool _verificationCodeProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: r.height(0.02),
                horizontal: r.width(0.04),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'SignUp_Headline'.tr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: r.fontXXXL(),
                        ),
                      ),
                    ),
                    SizedBox(height: r.height(0.005)),
                    Center(
                      child: Text(
                        'SignUp_subHeadLine'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: theme.colorScheme.primary,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                          fontSize: r.fontSmall(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: r.height(0.05)),
                    SizedBox(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),
                    //SizedBox(height: r.height(0.04)),
                    Visibility(
                      visible: !_verificationCodeProgressIndicator,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: _onTapVerifyEmail,
                        child: Text(
                          'Next'.tr,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: r.fontSmall(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: r.height(0.03)),
                    Center(
                      child: AuthBottomText(
                        normalText: 'Sign_up_bottom_text_1'.tr,
                        actionText: 'Sign_up_bottom_text_2'.tr,
                        onTap: _onTapSignIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to SignIn screen
  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  // Verify email process
  void _onTapVerifyEmail() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailEcontroller.text.trim();
      setState(() => _verificationCodeProgressIndicator = true);

      bool userExists = await FirestoreUtils.checkUserExists(email);

      if (userExists) {
        showSnackbarMessage(
          context,
          'Account_already_exists_with_this_email'.tr,
        );
        setState(() {
          _verificationCodeProgressIndicator = false;
        });
        return;
      }

      final otp = OtpGenerator.generate(length: 6);

      // API call to send OTP
      final response = await OtpApiService.sendOtp(email: email, otp: otp);

      setState(() => _verificationCodeProgressIndicator = false);

      if (response.isSuccess) {
        showSnackbarMessage(context, "OTP sent to $email");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(email: email, otp: otp),
          ),
        );
      } else {
        showSnackbarMessage(
          context,
          "Failed to send OTP: ${response.errorMessage}",
        );
      }
    }
  }
}
