import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/database/signin_and_signup/firestore_user_check.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/signin/signin_screen.dart';
import 'package:bikretaa/ui/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:bikretaa/ui/widgets/text_feild/email_feild_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                          color: theme.colorScheme.primary,
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
                            color: theme.colorScheme.primary,
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
                            color: theme.colorScheme.primary,
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

  //start the send Password reset link
  void _OnTapResetLinkSend() {
    if (_formKey.currentState!.validate()) {
      sendPasswordResetLinkProcess();
    }
  }

  //"Database section for the send Password reset link process"
  Future<void> sendPasswordResetLinkProcess() async {
    final email = _emailEcontroller.text.trim();

    setState(() {
      _forgotPassword_ProgressIndicator = true;
    });

    bool userExists = await FirestoreUtils.checkUserExists(email);

    if (!userExists) {
      showSnackbarMessage(context, "No user found for that email.");
      setState(() {
        _forgotPassword_ProgressIndicator = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _forgotPassword_ProgressIndicator = false;
      });

      showSnackbarMessage(
        context,
        "Password Reset Link sent successfully! Check your email.",
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.name,
        (predicate) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        default:
          errorMessage = e.message ?? "An error occurred. Please try again.";
      }
      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'An unexpected error occurred: $e');
    } finally {
      setState(() {
        _forgotPassword_ProgressIndicator = false;
      });
    }
  }

  //signup button section
  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }
}
