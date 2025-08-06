import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/screens/signup/otp_verification_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/email_feild_controller.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
  static const name = 'Created_account';
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailEcontroller = TextEditingController();
  bool _Verificaton_code_ProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background_image(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
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

                    SizedBox(height: 5),

                    Center(
                      child: Text(
                        "We'll send a one-time password to your email address",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    EmailFeildWidget(emailEcontroller: _emailEcontroller),

                    SizedBox(height: 30),

                    Visibility(
                      visible: _Verificaton_code_ProgressIndicator == false,

                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: () => _onTapVerifyEmail(),
                        child: Text('Next'),
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
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
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

  void _onTapVerifyEmail() {
    if (_formKey.currentState!.validate()) {
      final email = _emailEcontroller.text;
      showSnackbarMessage(context, "Your Email is $email");
      Navigator.pushNamed(context, OTPVerificationScreen.name);
    }
  }

  void _onTapSignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }
}
