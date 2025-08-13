import 'package:bikretaa/database/signin_and_signup/firestore_user_check.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/main_nav_bar_screen.dart';
import 'package:bikretaa/ui/screens/forgot_password_screen.dart';
import 'package:bikretaa/ui/screens/signup/create_account_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/email_feild_controller.dart';
import 'package:bikretaa/ui/widgets/password_feild_widget.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
  static const name = 'Signin_name';
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailEcontroller = TextEditingController();
  TextEditingController _passwordEcontroller = TextEditingController();
  bool _signinProgressIndicator = false;

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
                        "Wellcome To Bikretaa",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    Container(
                      height: 65.h,
                      child: EmailFeildWidget(
                        emailEcontroller: _emailEcontroller,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 65.h,
                          child: PasswordFeildWidget(
                            passwordEcontroller: _passwordEcontroller,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Transform.translate(
                            offset: Offset(0, -15.h),
                            child: TextButton(
                              onPressed: () => _onTapForgetPassword(),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Visibility(
                      visible: !_signinProgressIndicator,

                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: () => _onTapSignin(),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.h,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.4,
                            fontSize: 10.h,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.h,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() => _onTapSignUp()),
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

  // start signin process
  void _onTapSignin() async {
    if (_formKey.currentState!.validate()) {
      _signInProcess();
    }
  }

  //"Database section for the sign-in process"
  Future<void> _signInProcess() async {
    final email = _emailEcontroller.text.trim();
    final password = _passwordEcontroller.text.trim();

    setState(() {
      _signinProgressIndicator = true;
    });

    bool userExists = await FirestoreUtils.checkUserExists(email);
    if (!userExists) {
      showSnackbarMessage(context, 'No account found');
      setState(() {
        _signinProgressIndicator = false;
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavBarScreen.name,
        (predicate) => false,
      );

      showSnackbarMessage(context, "Login successful!");
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No account found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }

      showSnackbarMessage(context, errorMessage);
    } catch (e) {
      showSnackbarMessage(context, 'An unexpected error occurred: $e');
    } finally {
      setState(() {
        _signinProgressIndicator = false;
      });
    }
  }

  // Forgot password button section
  void _onTapForgetPassword() {
    Navigator.pushReplacementNamed(context, ForgotPasswordScreen.name);
  }

  //signup button section
  void _onTapSignUp() {
    Navigator.pushReplacementNamed(context, CreateAccountScreen.name);
  }
}
