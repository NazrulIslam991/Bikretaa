import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/screens/signup/create_account_by_information.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
  static const name = 'Verification_Email';
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _otpEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Background_image(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
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
                      "Enter verification code, we send to your email address",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 50),

                    Container(
                      height: 60,
                      width: double.infinity,
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: 50,
                          activeColor: Colors.blue,
                          activeFillColor: Colors.blue.shade100,
                          selectedColor: Colors.green,
                          selectedFillColor: Colors.greenAccent.shade100,
                          inactiveColor: Colors.grey,
                          inactiveFillColor: Colors.grey.shade200,
                          disabledColor: Colors.red.shade100,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        controller: _otpEController,
                        onCompleted: (v) {
                          print("Completed");
                        },

                        appContext: context,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't receive a code? ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            letterSpacing: 0.4,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _onTapResendCode(),
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () => _OnTapEmailVerification(),
                      child: Text("verify"),
                    ),

                    SizedBox(height: 40),

                    Center(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                letterSpacing: 0.4,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (() => SignIn()),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  void SignIn() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  void _OnTapEmailVerification() {
    Navigator.pushNamed(context, CreateAccountByInformation.name);
  }

  void _onTapResendCode() {}
}
