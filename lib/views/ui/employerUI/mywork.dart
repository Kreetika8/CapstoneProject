import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/jobs_provider.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/employerUI/job_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobsNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "My Work",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: jobProvider.jobs.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.work_off_rounded,
                    size: 80.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "You have not created any work",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: ListView.builder(
                itemCount: jobProvider.jobs.length,
                itemBuilder: (context, index) {
                  final job = jobProvider.jobs[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    shadowColor: Colors.black.withOpacity(0.1),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      title: Text(
                        job['title'] ?? '',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(kDark.value),
                        ),
                      ),
                      subtitle: Text(
                        "${job['location']} | ${job['workplace']}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      trailing: Text(
                        "₹${job['salary']}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(kOrange.value),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(
                              job: job,
                              onDelete: () {
                                jobProvider.deleteJob(job);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Job '${job['title']}' deleted!"),
                                  ),
                                );

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
