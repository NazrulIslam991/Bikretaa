import 'package:bikretaa/app/body_background.dart';
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
  static const name = 'Verification_Email';
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
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "OTP Verification",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Enter verification code sent to your email address",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.4,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 50),

                    Container(
                      height: 50.h,
                      width: double.infinity,
                      child: CustomPinCodeField(
                        controller: _otpEController,
                        onCompleted: (value) {
                          print("OTP input completed: $value");
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Didn't receive a code? ",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                            fontSize: 11.h,
                          ),
                        ),
                        TextButton(
                          onPressed: _onTapResendCode,
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.h,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    Visibility(
                      visible: !_otpVerificationProgress,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: _onTapVerify,
                        child: Text(
                          "Verify",
                          style: TextStyle(color: theme.colorScheme.primary),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Center(
                      child: AuthBottomText(
                        normalText: "Have an account? ",
                        actionText: "Sign In",
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

  //signip button section
  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  //verify otp process"
  void _onTapVerify() async {
    final enteredOtp = _otpEController.text.trim();
    setState(() {
      _otpVerificationProgress = true;
    });

    await Future.delayed(Duration(seconds: 3));

    if (enteredOtp == currentOtp) {
      showSnackbarMessage(context, "OTP Verified Successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccountByInformation(email: widget.email),
        ),
      );
    } else {
      showSnackbarMessage(context, "Invalid OTP! Please try again.");
    }

    setState(() {
      _otpVerificationProgress = false;
    });
  }

  //"Database section for resend otp process"
  void _onTapResendCode() async {
    final email = widget.email;

    final otp = OtpGenerator.generate(length: 6);

    final response = await OtpApiService.sendOtp(email: email, otp: otp);

    if (response.isSuccess) {
      setState(() {
        currentOtp = otp;
      });
      showSnackbarMessage(context, "OTP resent to $email");
    } else {
      showSnackbarMessage(
        context,
        "Failed to resend OTP: ${response.errorMessage}",
      );
    }
  }
}
