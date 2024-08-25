import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.OnTap,
  });

  final String text;
  final Color? color;
  final void Function()? OnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        width: double.infinity, // Full width of the parent
        height: MediaQuery.of(context).size.height * 0.070,
        decoration: BoxDecoration(
          color: Color(kDarkBlue.value),
          borderRadius: BorderRadius.circular(20), // Makes the border circular
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              color ?? Color(kLight.value),
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
