import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/common/width_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchWidget extends StatelessWidget {
  final void Function()? onTap;

  const SearchWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Feather.search,
                      color: Color(kOrange.value),
                      size: 20.h,
                    ),
                    WidthSpacer(width: 20),
                    ReusableText(
                      text: "Search for works",
                      style:
                          appstyle(18, Color(kOrange.value), FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesome.sliders,
                color: Color(kDarkGrey.value),
                size: 20.h,
              )
            ],
          ),
          HeightSpacer(size: 7),
          Divider(
            color: Color(kDarkGrey.value),
            thickness: 0.5,
            endIndent: 40.w,
          ),
         
        ],
      ),
    );
  }
}
