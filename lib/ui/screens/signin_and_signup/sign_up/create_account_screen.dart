import 'package:bikretaa/database/signin_and_signup/firestore_user_check.dart';
import 'package:bikretaa/database/signin_and_signup/otp_generator.dart';
import 'package:bikretaa/database/signin_and_signup/otp_service.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/sign_up/otp_verification_screen.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/signin/signin_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/ui/widgets/text_feild/email_feild_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      body: Background_image(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Center(
                      child: Text(
                        "We'll send a one-time password to your email address",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Visibility(
                      visible: !_verificationCodeProgressIndicator,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: () => _onTapVerifyEmail(),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.4,
                            fontSize: 10.h,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.h,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapSignIn,
                            ),
                          ],
                        ),
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

  //signup button section
  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  //"Database section for verify email process"
  void _onTapVerifyEmail() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailEcontroller.text.trim();
      setState(() => _verificationCodeProgressIndicator = true);

      bool userExists = await FirestoreUtils.checkUserExists(email);

      if (userExists) {
        showSnackbarMessage(context, "Account already exists with this email.");
        setState(() {
          _verificationCodeProgressIndicator = false;
        });
        return;
      }

      final otp = OtpGenerator.generate(length: 6);

      // api call and send otp
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
