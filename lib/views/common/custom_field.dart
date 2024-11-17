import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:flutter/material.dart';


class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    required this.obscureText,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final VoidCallback? onEditingComplete;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(kDark.value),
          width: 1,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            hintText: hintText,
            hintStyle: appstyle(14, Color(kDark.value), FontWeight.w500),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
          ),
          cursorHeight: 20,
          style: appstyle(16, Color(kDark.value), FontWeight.w500),
        ),
      ),
    );
  }
}
