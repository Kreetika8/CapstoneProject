import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/custom_outline_btn.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/ui/authent/login.dart';
import 'package:classico/views/ui/authent/signup.dart';
import 'package:flutter/material.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key); // Close the key parameter

  @override
  Widget build(BuildContext context) {
    // Define the width and height using MediaQuery or ScreenUtil
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity, // Takes the full width of the screen
        height: double.infinity, // Takes the full height of the screen
        color: Color(kLight.value),
        child: Column(
          children: [
            const HeightSpacer(size: 65),
            Image.asset(
                "assets/images/PageThree.png"), // Ensure this asset path is correct
            const HeightSpacer(size: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To WorkSet",
                  textAlign: TextAlign.center,
                  style: appstyle(30, Color(kDark.value), FontWeight.w500),
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w), // Adjust padding to your liking
                  child: Text(
                    "Unlock Potential, Connect with Talent",
                    textAlign: TextAlign.center,
                    style: appstyle(14, Color(kDark.value), FontWeight.normal),
                  ),
                ),
                const HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Center the button
                  children: [
                    CustomOutlineBtn(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('entrypoint', true);
                        await Get.to(() => const LoginPage());
                      },
                      text: "Login",
                      width: width * 0.4,
                      height: height * 0.06,
                      color: Color(kLightBlue.value),
                      color2: Colors.transparent, // Ensure `color2` is defined
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationPage());
                      },
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.06,
                        color: Color(kDarkBlue.value),
                        child: Center(
                          child: ReusableText(
                            text: "Register",
                            style: appstyle(
                                16, Color(kLight.value), FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const HeightSpacer(size: 30),
                ReusableText(
                    text: "Continue as a guest",
                    style:
                        appstyle(16, Color(kLightBlue.value), FontWeight.w400))
              ],
            ),
          ],
        ),
      ),
    );
  }
}