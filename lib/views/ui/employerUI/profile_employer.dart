import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Profile",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: MediaQuery.of(context).size.width, // Adjust width dynamically
            height: MediaQuery.of(context).size.height * 0.12, // Adjust height dynamically
            color: Color(kLight.value),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Provide a valid radius
                  child: Image.asset(
                    'assets/images/user.png', // Add your image path
                    width: 60.0, // Set a width for the clipped image
                    height: 60.0, // Set a height for the clipped image
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10), // Add some spacing
                Text(
                  "User Name", // Replace with dynamic data if needed
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}
