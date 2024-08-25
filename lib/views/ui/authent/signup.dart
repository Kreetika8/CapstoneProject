import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/signup_provider.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/custom_btn.dart';
import 'package:classico/views/common/custom_textfield.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/ui/authent/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>(); // Define the form key
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: "Register",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form( // Wrap the fields inside a Form widget
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 30),
                  ReusableText(
                    text: "Hello, Welcome!",
                    style: appstyle(30, Color(kDark.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: "Create an account to get started",
                    style: appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
                  ),
                  const HeightSpacer(size: 30),
                  CustomTextfield(
                    controller: name,
                    keyboardType: TextInputType.text,
                    hintText: "Full Name",
                    obscureText: false,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter your name";
                      } else {
                        return null;
                      }
                    }, 
                  ),
                  const HeightSpacer(size: 30),
                  CustomTextfield(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    obscureText: false,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 30),
                  CustomTextfield(
                    controller: password,
                    keyboardType: TextInputType.text,
                    hintText: "Password",
                    obscureText: signupNotifier.obscurePassword,
                    validator: (password) {
                      if (!signupNotifier.passwordValidator(password ?? '')) {
                        return "Please enter a valid password with at least \none uppercase, one lowercase, one digit, \na special character, and a length of 8 characters.";
                      
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signupNotifier.togglePasswordVisibility();
                      },
                      child: Icon(
                        signupNotifier.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 30),
                  CustomTextfield(
                    controller: confirmPassword,
                    keyboardType: TextInputType.text,
                    hintText: "Confirm Password",
                    obscureText: signupNotifier.obscureConfirmPassword,
                    validator: (value) {
                      if (value!.isEmpty || value != password.text) {
                        return "Passwords do not match";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signupNotifier.toggleConfirmPasswordVisibility();
                      },
                      child: Icon(
                        signupNotifier.obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: appstyle(
                                  14, Color(kLightBlue.value), FontWeight.w500),
                            ),
                            TextSpan(
                              text: "Log in",
                              style: appstyle(
                                  14, Color(kOrange.value), FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 30),
                  CustomButton(
                    OnTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform sign-up action
                      }
                    },
                    text: "Signup",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
