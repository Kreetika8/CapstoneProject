import 'package:classico/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class JobPage extends StatelessWidget {
  final String title;
  final String id;
  final String location;
  final String contractPeriod;
  final String salary;
  final List<String> requirements;
  final String description;
  final String employerEmail; // Added employerEmail field

  JobPage({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    required this.contractPeriod,
    required this.salary,
    required this.requirements,
    required this.description,
    required this.employerEmail, // Accept employer email
  });

  // Function to launch the email client
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('Subject=Job Application for $title'), // Optional subject
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(kOrange.value),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            // Centered Job Title
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Location Section with Icon
            Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListTile(
                leading: Icon(Icons.location_on, color: Color(kDarkBlue.value)),
                title: Text(
                  "Location: $location",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(kDark.value),
                  ),
                ),
              ),
            ),

            // Contract Period Section with Icon
            Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListTile(
                leading: Icon(Icons.access_time, color: Color(kDarkBlue.value)),
                title: Text(
                  "Contract Period: $contractPeriod",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(kDark.value),
                  ),
                ),
              ),
            ),

            // Salary Section with Icon
            Card(
              elevation: 5,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListTile(
                leading: Icon(Icons.monetization_on, color: Color(kDarkBlue.value)),
                title: Text(
                  "Salary: $salary",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(kDark.value),
                  ),
                ),
              ),
            ),

            // Job Requirements heading
            Text(
              "Job Requirements:",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),

            // Job Requirements list
            for (var requirement in requirements)
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  "- $requirement",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(kDark.value),
                  ),
                ),
              ),
            SizedBox(height: 26.h),

            // Job Description heading
            Text(
              "Job Description:",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),

            // Job Description
            Text(
              description,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 24.h),

            // Apply Button with Enhanced Styling
            ElevatedButton(
              onPressed: () {
                _launchEmail(employerEmail); // Pass the employer's email here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                backgroundColor: Color(kOrange.value),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                shadowColor: Color(kDarkBlue.value),
                elevation: 5,
              ),
              child: Text(
                'Apply for Job',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(kDark.value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
