import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/exports.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/custom_btn.dart';
import 'package:classico/views/common/custom_textfield.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/ui/authent/login.dart';
import 'package:classico/views/ui/authent/signup.dart';
import 'package:classico/views/ui/authent/signup_Employer.dart';
import 'package:classico/views/ui/search/mainscreen.dart';
import 'package:classico/views/ui/search/mainscreen_Employer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginEmployer extends StatefulWidget {
  const LoginEmployer({super.key});

  @override
  State<LoginEmployer> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginEmployer> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: "Login",
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HeightSpacer(size: 50),
                ReusableText(
                  text: "Welcome Back",
                  style: appstyle(30, Color(kDark.value), FontWeight.w600),
                ),
                ReusableText(
                  text: "Fill the details to login to your account",
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w500),
                ),
                HeightSpacer(size: 50),
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
                HeightSpacer(size: 50),
                CustomTextfield(
                  controller: password,
                  keyboardType: TextInputType.text,
                  hintText: "Password",
                  obscureText: loginNotifier.obscureText,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifier.togglePasswordVisibility();
                    },
                    child: Icon(
                      loginNotifier.obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(kDark.value),
                    ),
                  ),
                ),
                HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const SignupEmployer());
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: appstyle(
                                14, Color(kLightBlue.value), FontWeight.w500),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: appstyle(
                                14, Color(kOrange.value), FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                HeightSpacer(size: 50),
                CustomButton(
                  OnTap: () {
                    Get.to(() => MainscreenEmployer());;
                  },
                  text: "Login as a Employer",
                ),
                HeightSpacer(size: 20),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => LoginPage());  // Navigate to MainScreenEmployer on tap
                    },
                    child: Text(
                      "Are you a worker? Click here",
                      style: appstyle(
                          14, Color(kLightBlue.value), FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
