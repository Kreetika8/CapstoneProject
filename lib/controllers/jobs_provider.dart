import 'package:flutter/material.dart';

class JobsNotifier extends ChangeNotifier {
  final List<Map<String, dynamic>> _jobs = []; // Use dynamic for more flexibility

  List<Map<String, dynamic>> get jobs => _jobs;

  get appliedJobs => null;

  // Add a job to the list
  void addJob(Map<String, dynamic> job) {
    _jobs.add(job);
    notifyListeners();
  }

  // Remove a job from the list 
  void deleteJob(Map<String, dynamic> job) {
    _jobs.remove(job);
    notifyListeners();
  }

  // Optional: Clear all jobs
  void clearJobs() {
    _jobs.clear();
    notifyListeners();
  }
}
