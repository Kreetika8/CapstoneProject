import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/employerUI/creatework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Add GetX import

class HomepageEmployer extends StatefulWidget {
  const HomepageEmployer({super.key});

  @override
  State<HomepageEmployer> createState() => _HomePageState();
}

class _HomePageState extends State<HomepageEmployer> {
  @override
  Widget build(BuildContext context) {
    // Ensure screenutil is initialized
    ScreenUtil.init(context);

    return Scaffold(
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
            child: const DrawerWidget(),
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 20.h),

            // RichText: Create a work and search workers for your work
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Create a Work\n",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(kDarkBlue.value),
                    ),
                  ),
                  TextSpan(
                    text: "you are one step away from finding the workers",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(kDarkGrey.value),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Add Image in the middle of the screen
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/HomepageEmployer.png',
                  width: 0.8.sw,
                  height: 0.4.sh,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),

      // Floating Action Button: Create a work now
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Use GetX navigation to avoid context-related issues
            Get.to(() => CreateWorkPage()); // Navigate to CreateWorkPage using GetX
          },
          label: Row(
            children: [
              Icon(Icons.add, size: 24.sp),
              SizedBox(width: 8.w),
              Text("Create a Work Now", style: TextStyle(fontSize: 16.sp)),
            ],
          ),
          backgroundColor: Color(0xFFFB8C00),
        ),
      ),
    );
  }
}
