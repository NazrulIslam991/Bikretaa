import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/auth/presentation/database/otp_generator.dart';
import 'package:bikretaa/features/auth/presentation/database/otp_service.dart';
import 'package:bikretaa/features/auth/presentation/screens/sign_up/create_account_by_information.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/auth/presentation/widgets/custom_pin_code_text_feild.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final String otp;

  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
  static const name = '/Verification_Email';
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _otpEController;

  late String currentOtp;
  bool _otpVerificationProgress = false;

  @override
  void initState() {
    super.initState();
    _otpEController = TextEditingController();
    currentOtp = widget.otp;
  }

  @override
  void dispose() {
    _otpEController.dispose();
    super.dispose();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OTP_Headline'.tr,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: r.fontXXXL(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: r.height(0.005)),
                    Text(
                      'OTP_subHeadLine'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.4,
                        fontStyle: FontStyle.italic,
                        fontSize: r.fontSmall(),
                      ),
                    ),
                    SizedBox(height: r.height(0.06)),
                    SizedBox(
                      height: 55.h,
                      width: double.infinity,
                      child: CustomPinCodeField(
                        controller: _otpEController,
                        onCompleted: (value) {
                          print("OTP input completed: $value");
                        },
                      ),
                    ),
                    //SizedBox(height: r.height(0.02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Didnt_receive_a_code'.tr,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                            fontSize: r.fontSmall(),
                          ),
                        ),
                        TextButton(
                          onPressed: _onTapResendCode,
                          child: Text(
                            'Resend'.tr,
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: r.fontSmall(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: r.height(0.04)),
                    Visibility(
                      visible: !_otpVerificationProgress,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: _onTapVerify,
                        child: Text(
                          'Verify'.tr,
                          style: TextStyle(
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

  // Verify OTP
  void _onTapVerify() async {
    final enteredOtp = _otpEController.text.trim();
    setState(() => _otpVerificationProgress = true);

    await Future.delayed(Duration(seconds: 3));

    if (enteredOtp == currentOtp) {
      showSnackbarMessage(context, 'OTP_Verified_Successfully'.tr);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccountByInformation(email: widget.email),
        ),
      );
    } else {
      showSnackbarMessage(context, 'Invalid_OTP_Please_try_again'.tr);
    }

    setState(() => _otpVerificationProgress = false);
  }

  // Resend OTP
  void _onTapResendCode() async {
    final email = widget.email;
    final otp = OtpGenerator.generate(length: 6);

    final response = await OtpApiService.sendOtp(email: email, otp: otp);

    if (response.isSuccess) {
      setState(() => currentOtp = otp);
      showSnackbarMessage(context, "OTP resent to $email");
    } else {
      showSnackbarMessage(
        context,
        "Failed to resend OTP: ${response.errorMessage}",
      );
    }
  }
}
