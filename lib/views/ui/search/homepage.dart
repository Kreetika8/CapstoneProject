import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/common/heading_widget.dart';
import 'package:classico/views/common/height_spacer.dart';
import 'package:classico/views/common/horizontal_tile.dart';
import 'package:classico/views/common/vertical_tile.dart';
import 'package:classico/views/ui/jobs/widgets/job_page.dart';
import 'package:classico/views/ui/search/search.dart';
import 'package:classico/views/ui/search/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // Fetch screen height
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // AppBar with custom style and drawer icon
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              child: const CircleAvatar(
                radius: 13,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(), // Drawer widget inside the AppBar
          ),
        ),
      ),
      
      // Main body content
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 10),
                
                // Main heading of the homepage
                Text(
                  "Search \nFind & Apply",
                  style: appstyle(40, Color(kDark.value), FontWeight.bold),
                ),
                
                const HeightSpacer(size: 40),

                // Search widget for job search
                SearchWidget(
                  onTap: () {
                    // Navigate to the search page
                    Get.to(() => const SearchPage());
                  },
                ),
                
                const HeightSpacer(size: 30),
                
                // Heading for Popular Works section
                HeadingWidget(
                  text: "Popular Works",
                  onTap: () {
                    // Additional navigation or action if needed
                  },
                ),
                
                const HeightSpacer(size: 15),
                
                // Horizontal list of popular job categories
                SizedBox(
                  height: height * 0.28, // Adjust height as necessary
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return JobHorizontalTile(
                        onTap: () {
                          // Navigate to the job details page
                          Get.to(() => const JobPage(title: 'Facebook', id: '12'));
                        },
                      );
                    },
                  ),
                ),
                
                const HeightSpacer(size: 20),
                
                // Heading for Recently Posted Jobs section
                HeadingWidget(
                  text: "Recently Posted",
                  onTap: () {
                    // Additional navigation or action if needed
                  },
                ),
                
                const HeightSpacer(size: 20),
                
                // Vertical list of job postings
                VerticalTile()
              ],
            ),
          ),
        ),
      ),
      
      // Adding drawer to the scaffold
      drawer: const DrawerWidget(),
    );
  }
}
