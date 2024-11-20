import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/ui/search/search.dart';
import 'package:classico/views/ui/search/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainSearchPage extends StatelessWidget {
  const MainSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h), // Adjusted height to fit both title and search
        child: CustomAppBar(
          text: "Search", // Set the main app bar title
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom title with search instructions
                Text(
                  "Search \nFind & Apply",
                  style: appstyle(40.sp, Color(kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(size: 40), // Spacer between text and search widget
                
                // Search widget for job search
                SearchWidget(
                  onTap: () {
                    // Navigate to the search page
                    Get.to(() => const SearchPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const DrawerWidget(), // Drawer widget for the sidebar
    );
  }
}
