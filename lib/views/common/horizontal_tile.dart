import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/common/width_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          width: MediaQuery.of(context).size.width * 0.7  ,
          height: MediaQuery.of(context).size.height * 0.27,
          color: Color(kLightGrey.value),
          child: SingleChildScrollView(
            // Make it scrollable if content overflows
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user.png"),
                    ),
                    const WidthSpacer(width: 15),
                    ReusableText(
                      text: "Facebook",
                      style: appstyle(20, Color(kDark.value), FontWeight.w600),
                    ),
                  ],
                ),
                const HeightSpacer(size: 15),
                ReusableText(
                  text: "Plumber",
                  style: appstyle(20, Color(kDark.value), FontWeight.w600),
                ),
                ReusableText(
                  text: "Kathmandu",
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                ),

               const HeightSpacer(size: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(
                      children: [
                        ReusableText(
                          text: "15K",
                          style: appstyle(23, Color(kDark.value), FontWeight.w600),
                        ),
                        ReusableText(
                          text: "/monthly",
                          style: appstyle(23, Color(kDarkGrey.value), FontWeight.w600),
                        ),
                      ],
                    ),
                    Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kDarkGrey.value),
                    child: const Icon(Icons.chevron_right), // Replace 'chevron_forward' with 'chevron_right'
                  ),
                ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
