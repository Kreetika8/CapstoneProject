import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/jobs_provider.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/employerUI/mywork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class CreateWorkPage extends StatefulWidget {
  const CreateWorkPage({super.key});

  @override
  State<CreateWorkPage> createState() => _CreateWorkPageState();
}

class _CreateWorkPageState extends State<CreateWorkPage> {
  // Controllers for each input field
  final TextEditingController _jobPositionController = TextEditingController();
  final TextEditingController _jobLocationController = TextEditingController();
  final TextEditingController _workplaceController = TextEditingController();
  final TextEditingController _contractPeriodController = TextEditingController();
    final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  String _selectedFrequency = "hour"; // Default salary frequency

  @override
  void dispose() {
    // Dispose controllers to free memory
    _jobPositionController.dispose();
    _jobLocationController.dispose();
    _workplaceController.dispose();
    _contractPeriodController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();

    super.dispose();
  }

  //title
  void _showTitleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Work Title",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please enter the job title",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: TextField(
            controller: _jobPositionController,
            maxLines: 1, // One line for the title
            decoration: InputDecoration(
              hintText: "Enter job title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              SizedBox(width: 10), // Add space between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_jobPositionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter the title"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      setState(() {
                        // Save or handle the title here if needed
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set text color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Location Dialog (using separate controller for location)
  void _showLocationDialog() {
    TextEditingController _locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Work Location",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please enter the work location",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: TextField(
            controller: _locationController,
            maxLines: 1, // One line for the location
            decoration: InputDecoration(
              hintText: "Enter location here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Ensures proper spacing
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              SizedBox(width: 10), // Add space between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_locationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter the location"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      setState(() {
                        // Save the location entered in the controller
                        _jobLocationController.text = _locationController.text;
                      });
                      Navigator.pop(context); // Close the dialog
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //workplace
  void _showWorkplaceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select Workplace Type",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Choose the type of workplace for the job",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: ["Onsite", "Remote", "Hybrid"].map((workplace) {
                    return RadioListTile<String>(
                      title: Text(
                        workplace,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      value: workplace,
                      groupValue: _workplaceController.text,
                      activeColor: Color(kOrange.value),
                      onChanged: (value) {
                        setDialogState(() {
                          _workplaceController.text =
                              value!; // Update the selected workplace
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_workplaceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select a workplace type"),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {
                  // No need to update text further, it's already selected
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

//contract period

  void _showContractPeriodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Contract period",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Determine and choose the contract period",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextField for entering total time
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            _contractPeriodController, // Use this controller
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Total Time",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      _selectedFrequency, // Display frequency directly
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children:
                      ["hour", "day", "week", "month", "year"].map((frequency) {
                    return RadioListTile<String>(
                      title: Text(
                        frequency,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      value: frequency,
                      groupValue: _selectedFrequency,
                      activeColor: Color(kOrange.value),
                      onChanged: (value) {
                        setDialogState(() {
                          _selectedFrequency = value!; // Update the frequency
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_contractPeriodController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter a total contract Period"),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {
                  // Save total time with selected frequency directly (without "/")
                  _contractPeriodController.text =
                      "${_contractPeriodController.text} $_selectedFrequency";
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

//Salary
  void _showSalaryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Salary",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Determine and choose the salary",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) => SingleChildScrollView(
            // Wrap the Column in SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _salaryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "/",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      _selectedFrequency,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children:
                      ["hour", "day", "week", "month", "year"].map((frequency) {
                    return RadioListTile<String>(
                      title: Text(
                        frequency,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      value: frequency,
                      groupValue: _selectedFrequency,
                      activeColor: Color(kOrange.value),
                      onChanged: (value) {
                        // Update the selected frequency and clear previous salary
                        setDialogState(() {
                          _selectedFrequency = value!;
                          _salaryController.clear(); // Clear the salary input
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_salaryController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter a salary amount"),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {
                  _salaryController.text =
                      "${_salaryController.text} / $_selectedFrequency";
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

//requirements
  void _showRequirementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Requirements",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Write the requirements for your work",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: TextField(
            controller: _requirementsController, // Use the correct controller
            maxLines: 5, // Allow for a large text input area
            decoration: InputDecoration(
              hintText: "Enter the requirements here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10.w), // Add padding to prevent overflow
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                SizedBox(width: 10), // Space between buttons
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_requirementsController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter requirements"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        setState(() {
                          // Optionally handle the requirements here
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //description
  void _showDescriptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Write the description of your work",
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(kDarkGrey.value),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descriptionController,
                maxLines: 5, // Allow for a large text input area
                decoration: InputDecoration(
                  hintText: "Enter the description here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Wrap buttons in Expanded to prevent overflow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              SizedBox(width: 10), // Add space between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a description"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      setState(() {
                        // No further update needed, just saving description
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 void _validateAndPost() {
  // Print the values of the controllers to debug
  print("Job Position: ${_jobPositionController.text.trim()}");
  print("Workplace: ${_workplaceController.text.trim()}");
  print("Job Location: ${_jobLocationController.text.trim()}");
  print("Contract Period: ${_contractPeriodController.text.trim()}");
  print("Description: ${_descriptionController.text.trim()}");
  print("Requirements: ${_requirementsController.text.trim()}");
  print("Salary: ${_salaryController.text.trim()}");

  if (_jobPositionController.text.trim().isEmpty ||
      _workplaceController.text.trim().isEmpty ||
      _jobLocationController.text.trim().isEmpty ||
      _contractPeriodController.text.trim().isEmpty ||
      _descriptionController.text.trim().isEmpty ||
      _requirementsController.text.trim().isEmpty ||
      _salaryController.text.trim().isEmpty 
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all the details"),
        backgroundColor: Colors.red,
      ),
    );
  } else {
    final newJob = {
      'title': _jobPositionController.text.trim(),
      'location': _jobLocationController.text.trim(),
      'workplace': _workplaceController.text.trim(),
      'contractPeriod': _contractPeriodController.text.trim(),
      'salary': _salaryController.text.trim(),
      'requirements': _requirementsController.text.trim(),
      'description': _descriptionController.text.trim(),

    };

    final jobProvider = Provider.of<JobsNotifier>(context, listen: false);
    jobProvider.addJob(newJob); // Add job to the provider


    // Or use Navigator.pushReplacement if not using GetX:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyWorkPage()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Create your Work",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: _showTitleDialog,
                    child:
                        _buildInteractiveField("Title", _jobPositionController),
                  ),
                  GestureDetector(
                    onTap: _showLocationDialog,
                    child: _buildInteractiveField(
                        "Location", _jobLocationController),
                  ),
                  GestureDetector(
                    onTap: _showWorkplaceDialog,
                    child: _buildInteractiveField(
                        "Workplace", _workplaceController),
                  ),
                  GestureDetector(
                    onTap: _showContractPeriodDialog,
                    child: _buildInteractiveField(
                        "Contract Period", _contractPeriodController),
                  ),
                  GestureDetector(
                    onTap: _showSalaryDialog,
                    child: _buildInteractiveField("Salary", _salaryController),
                  ),
                  GestureDetector(
                    onTap: _showRequirementDialog,
                    child: _buildInteractiveField(
                        "Requirements", _requirementsController),
                  ),
                  GestureDetector(
                    onTap: _showDescriptionDialog,
                    child: _buildInteractiveField(
                        "Description", _descriptionController),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _validateAndPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kDarkPurple.value),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(kLight.value),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveField(
      String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.text.isNotEmpty)
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  // Wrap the Text widget with Flexible
                  child: Text(
                    controller.text.isEmpty ? label : controller.text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: controller.text.isEmpty
                          ? Colors.black
                          : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: Color(kDarkPurple.value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
