import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/ui/employerUI/mywork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobDetailPage extends StatelessWidget {
  final Map<String, dynamic> job; // Accept a map of job details
  final Function onDelete; // Callback for delete action

  const JobDetailPage({super.key, required this.job, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Details"),
        backgroundColor: Color(kOrange.value),
      ),
      body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Job Title Section (Centered)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(kLightGrey.value),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Color(kLightGrey.value)),
                ),
                child: Text(
                  job['title'] ?? 'No Title Available',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(kDark.value),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),

              // Job Details Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Location", job['location']),
                      Divider(color: Color(kDarkGrey.value)),
                      _buildDetailRow("Workplace", job['workplace']),
                      Divider(color: Color(kLightGrey.value)),
                      _buildDetailRow("Contract Period", " ${job['contractPeriod']}"),
                      Divider(color: Color(kDarkGrey.value)),
                      _buildDetailRow("Salary", "₹${job['salary']}"),
                      Divider(color: Color(kDarkGrey.value)),
                      _buildDetailRow("Requirements", job['requirements']),
                      Divider(color: Color(kDarkGrey.value)),
                      _buildDetailRow("Description", job['description']),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Delete Icon
              IconButton(
                onPressed: () {
                  // Show a confirmation dialog before deleting the job
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you really want to delete this work?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // If user confirms, delete the job
                              onDelete();
                              Navigator.pop(context); // Close the dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyWorkPage(), // Navigate to MyWorkPage
                                ),
                              );
                            },
                            child: Text('Yes', style: TextStyle(color: Colors.red)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog if 'No' is clicked
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 32.sp,
                ),
              ),
              Text(
                "Delete Work",
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Color(kDarkPurple.value),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'Not Available',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
