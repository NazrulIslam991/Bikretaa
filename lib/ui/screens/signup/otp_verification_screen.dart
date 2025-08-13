import 'package:bikretaa/database/network_caller.dart';
import 'package:bikretaa/database/signin_and_signup/otp_generator.dart';
import 'package:bikretaa/database/signin_and_signup/urls.dart';
import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/screens/signup/create_account_by_information.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    return Scaffold(
      body: Background_image(
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
                        color: Colors.grey,
                        letterSpacing: 0.4,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 50),

                    Container(
                      height: 50.h,
                      width: double.infinity,
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 45.h,
                          fieldWidth: 40.h,
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
                          print("OTP input completed: $v");
                        },
                        appContext: context,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Didn't receive a code? ",
                          style: TextStyle(
                            color: Colors.grey,
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
                        child: Text("Verify"),
                      ),
                    ),

                    SizedBox(height: 20.h),

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

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.sendEmailOtp,
      body: {
        "sender": {"name": "Bikretaa", "email": "rentrover2025@gmail.com"},
        "to": [
          {"email": email},
        ],
        "subject": "Your One-Time Password (OTP) Code",
        "htmlContent":
            "<html lang="
            "><body>"
            "<h2>One-Time Verification Code</h2>"
            "<p>Dear User,</p>"
            "<p>Your One-Time Password (OTP) for verification is:</p>"
            "<h1 style='color:#2E86C1;'>$otp</h1>"
            "<br>"
            "<p>Best regards,<br>BIkretaa Team</p>"
            "</body></html>",
      },
      isBrevoRequest: true,
    );

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
