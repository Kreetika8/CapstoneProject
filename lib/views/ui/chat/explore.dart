import 'dart:math';

import 'package:classico/controllers/jobs_provider.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/jobs/widgets/job_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Map<String, dynamic>> displayedJobs = [];

  @override
  void initState() {
    super.initState();
    _loadRandomJobs();
  }

  void _loadRandomJobs() {
    final jobProvider = Provider.of<JobsNotifier>(context, listen: false);
    final allJobs = jobProvider.jobs;

    // Pick a random subset of 10-20 jobs
    final random = Random();
    final subsetSize = random.nextInt(11) + 10; // Between 10 and 20
    setState(() {
      displayedJobs = List.from(allJobs)..shuffle(random);
      displayedJobs = displayedJobs.take(subsetSize).toList();
    });
  }

  void _deleteJobLocally(Map<String, dynamic> job) {
    setState(() {
      displayedJobs.remove(job);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Job '${job['title']}' removed from your feed!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Explore",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadRandomJobs();
        },
        child: displayedJobs.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 80.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "No work available for now \n Please check  again later",
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
                  itemCount: displayedJobs.length,
                  itemBuilder: (context, index) {
                    final job = displayedJobs[index];
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
                        leading: CircleAvatar(
                          radius: 24.w, // Adjust size of the image
                          backgroundImage: job['posterImage'] != null
                              ? NetworkImage(job['posterImage'])
                              : AssetImage('assets/images/user.png')
                                  as ImageProvider,
                        ),
                        title: Text(
                          job['title'] ?? '', // Ensure title is not null
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "${job['location']} | ${job['workplace']}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                                size: 24.sp,
                              ),
                              onPressed: () async {
                                final confirmed = await _showDeleteConfirmation(
                                    context, job['title']);
                                if (confirmed == true) {
                                  _deleteJobLocally(job);
                                }
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          final jobId = job['id'] ?? '';
                          final jobTitle = job['title'] ?? '';
                          final jobLocation = job['location'] ?? '';
                          final jobContractPeriod = job['contractPeriod'] ?? '';
                          final jobSalary = job['salary'] ?? '';
                          final String employerEmail = job['employerEmail'] ??
                              ''; // Extract employerEmail from job data

                          // Ensure requirements is a list
                          final jobRequirements = job['requirements'] is List
                              ? List<String>.from(job['requirements'])
                              : [
                                  job['requirements'].toString()
                                ]; // Convert to list if it's a single string

                          final jobDescription = job['description'] ?? '';

                          if (jobId.isNotEmpty && jobTitle.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobPage(
                                  title: jobTitle,
                                  id: jobId,
                                  location: jobLocation,
                                  contractPeriod: jobContractPeriod,
                                  salary: jobSalary,
                                  requirements: jobRequirements,
                                  description: jobDescription,
                                  employerEmail: employerEmail, // Pass employer email here
                                ),
                              ),
                            );
                          } else {
                            // Handle the case where jobId or jobTitle is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Invalid work data. Please try again.")),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context, String jobTitle) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Remove Job"),
        content: Text(
          "Are you sure you want to remove the job '$jobTitle' from your feed?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
