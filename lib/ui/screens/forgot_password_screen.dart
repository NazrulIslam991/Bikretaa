import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/email_feild_controller.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
  static const name = 'Forgot_password';
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailEcontroller = TextEditingController();
  bool _forgotPassword_ProgressIndicator = false;
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
                        "Forget Password",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Center(
                      child: Text(
                        "Please enter email address to reset the password",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    Container(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Visibility(
                      visible: _forgotPassword_ProgressIndicator == false,

                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: () => _OnTapResetLinkSend(),
                        child: Text(
                          'Reset Link',
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
                            fontWeight: FontWeight.normal,
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
                                ..onTap = (() => _onTapSignIn()),
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

  void _OnTapResetLinkSend() {
    if (_formKey.currentState!.validate()) {
      final email = _emailEcontroller.text;
      showSnackbarMessage(context, "Your Email is $email");
      Navigator.pushReplacementNamed(context, SigninScreen.name);
    }
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }
}
