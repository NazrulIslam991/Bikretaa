import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/widgets/background.dart';
import 'package:bikretaa/ui/widgets/circular_progress_indicatior.dart';
import 'package:bikretaa/ui/widgets/confirm_password_feild_widget.dart';
import 'package:bikretaa/ui/widgets/email_feild_controller.dart';
import 'package:bikretaa/ui/widgets/mobile_feild_widget.dart';
import 'package:bikretaa/ui/widgets/password_feild_widget.dart';
import 'package:bikretaa/ui/widgets/shop_name_widget.dart';
import 'package:bikretaa/ui/widgets/shop_type_dropdown_menu.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountByInformation extends StatefulWidget {
  const CreateAccountByInformation({super.key});

  @override
  State<CreateAccountByInformation> createState() =>
      _CreateAccountByInformationState();
  static const name = 'Created_account_by_information';
}

class _CreateAccountByInformationState
    extends State<CreateAccountByInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailEcontroller = TextEditingController();
  TextEditingController _shopNameEcontroller = TextEditingController();
  TextEditingController _mobileEcontroller = TextEditingController();
  TextEditingController _passwordEcontroller = TextEditingController();
  TextEditingController _confirmpasswordEcontroller = TextEditingController();

  bool _isExpanded = false;
  String? selectedShopType;

  bool _SignupInProgress = false;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Shop Information",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    SizedBox(height: 20),

                    ShopNameWidget(shopNameEcontroller: _shopNameEcontroller),

                    SizedBox(height: 20),

                    EmailFeildWidget(emailEcontroller: _emailEcontroller),
                    SizedBox(height: 20),

                    MobileFeildWidget(mobileEcontroller: _mobileEcontroller),

                    SizedBox(height: 20),

                    ShopTypeDropdownWidget(
                      onSaved: (value) {
                        selectedShopType = value;
                      },
                    ),

                    SizedBox(height: 20),

                    PasswordFeildWidget(
                      passwordEcontroller: _passwordEcontroller,
                    ),
                    SizedBox(height: 20),

                    ConfirmPasswordFeildWidget(
                      confirmpasswordEcontroller: _confirmpasswordEcontroller,
                      passwordEcontroller: _passwordEcontroller,
                    ),

                    SizedBox(height: 16),

                    Visibility(
                      visible: !_SignupInProgress,
                      replacement: CenterCircularProgressIndiacator(),
                      child: ElevatedButton(
                        onPressed: SignUpComplete,
                        child: Text('Done'),
                      ),
                    ),
                    SizedBox(height: 40),
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

  void SignUpComplete() {
    if (_formKey.currentState!.validate()) {
      final email = _emailEcontroller.text;
      final password = _passwordEcontroller.text;
      final shopName = _shopNameEcontroller.text;
      final phone = _mobileEcontroller.text;
      final shopType = selectedShopType;
      showSnackbarMessage(
        context,
        "shop name :  $shopName , email : $email mobile : $phone shop type : $shopType and  password : $password , ",
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninScreen.name,
        (predicate) => false,
      );
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
