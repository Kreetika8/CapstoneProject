import 'package:flutter/material.dart';

class AddJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Job"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add a job",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildJobField("Job position*", Icons.add),
            _buildJobField("Type of workplace", Icons.add),
            _buildJobField("Job location", Icons.add),
            _buildJobField("Contract Period", Icons.add),
            _buildJobField("Description", Icons.add),
            _buildJobField("Experience", Icons.add),
            _buildJobField("Salary", Icons.add),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Logic for posting a job
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
              child: Text("POST"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Icon(icon, color: Colors.orange),
        ],
      ),
    );
  }
}
