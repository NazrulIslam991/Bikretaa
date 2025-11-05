import 'package:bikretaa/app/body_background.dart';
import 'package:bikretaa/features/auth/presentation/database/firestore_user_check.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/widgets/auth_botto_text.dart';
import 'package:bikretaa/features/shared/presentation/widgets/auth_user_input_feild/email_feild_controller.dart';
import 'package:bikretaa/features/shared/presentation/widgets/circular_progress/circular_progress_indicatior.dart';
import 'package:bikretaa/features/shared/presentation/widgets/snack_bar_messege/snackbar_messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
  static const name = '/Forgot_password';
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
                        'Forgot_password'.tr,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Center(
                      child: Text(
                        'Please_enter_email_address_to_reset_the_password'.tr,
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
                          'Reset_Link'.tr,
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
      showSnackbarMessage(context, 'No_account_found_for_that_email'.tr);
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
        'Password_Reset_Link_sent_successfully_Check_your_email'.tr,
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
          errorMessage = 'The_email_address_is_not_valid'.tr;
          break;
        case 'too-many-requests':
          errorMessage = 'Too_many_requests_Please_try_again_later'.tr;
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
