import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:flutter/material.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn({
    super.key,
    this.width,
    this.height,
    this.text,
    this.onTap,
    required this.color,
    this.color2,
  });

  final double? width;
  final double? height;
  final String? text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          border: Border.all(
            width: 1,
            color: color,
          ),
          borderRadius: BorderRadius.circular(8), // Add a border radius if desired
        ),
        child: Center(
          child: ReusableText(
            text: text ?? "Button", // Provide a default text if null
            style: appstyle(16, color, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
