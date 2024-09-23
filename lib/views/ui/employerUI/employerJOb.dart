import 'package:classico/views/ui/employerUI/homepage_employer.dart';
import 'package:flutter/material.dart';
import 'package:classico/views/ui/employerUI/addJob.dart';

class EmployerJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the homepage or any other page instead of popping to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomepageEmployer()), // Replace with your homepage widget
        );
        return false; // Prevents the default back action
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Employer Dashboard"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to Add Job Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddJobPage()),
                  );
                },
                child: Text("Add a Job"),              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Code for viewing posted jobs
                },
                child: Text("View Posted Jobs"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
