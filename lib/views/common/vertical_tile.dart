import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/common/width_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: MediaQuery.of(context).size.height * 0.18,  // Adjusted height
        width: MediaQuery.of(context).size.width,
        color: Color(kLightGrey.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Changed to start
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Color(kLightGrey.value),
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
                WidthSpacer(width: 10.w),  // Added `ScreenUtil` width spacing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Plumber",
                      style: appstyle(20, Color(kDark.value), FontWeight.w600),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,  // Adjust width responsively
                      child: ReusableText(
                        text: "Kathmandu",
                        style: appstyle(18, Color(kDarkGrey.value), FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(kLight.value),
                  child: Icon(Ionicons.chevron_forward),  // Icon for forward arrow
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),  // Added padding between rows
              child: Row(
                children: [
                  ReusableText(
                    text: "20K",
                    style: appstyle(23, Color(kDark.value), FontWeight.w600),
                  ),
                  SizedBox(width: 5.w),  // Small spacing between text elements
                  ReusableText(
                    text: "/monthly",
                    style: appstyle(23, Color(kDarkGrey.value), FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
