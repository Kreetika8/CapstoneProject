import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensures the container takes up the full width
        height: double.infinity, // Ensures the container takes up the full height
        color: Color(kLight.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns the entire Column to the left
          children: [
            const HeightSpacer(size: 70),

            Center(
              child: Image.asset("assets/images/LandingImage.png"),
            ),

            const HeightSpacer(size: 40),

            Padding(
              padding: const EdgeInsets.only(left: 30.0), // Adjust padding to your needs
              child: RichText(
                text: TextSpan(
                  style: appstyle(30, Color(kDark.value), FontWeight.w500), // Default style for all text
                  children: [
                    const TextSpan(text: "Find Your\n"),
                    TextSpan(
                      text: "Contract Work\n",
                      style: appstyle(35, Color(kOrange.value), FontWeight.w600).copyWith(
                        decoration: TextDecoration.underline, // Underline "Contract Work"
                      ),
                    ),
                    const TextSpan(text: "Here!"),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
