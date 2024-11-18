import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/onboarding/widgets/page_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // For handling file paths
import 'package:flutter/services.dart'; // For handling input format validation
import 'package:email_validator/email_validator.dart'; // Import email_validator

class ProfilePageEmployer extends StatefulWidget {
  const ProfilePageEmployer({super.key});

  @override
  State<ProfilePageEmployer> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageEmployer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  File? _profileImage; // Store the selected image

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource
          .gallery, // You can change this to ImageSource.camera for camera
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Store the image in the state
      });
    }
  }

  // Method to show error messages
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Edit Phone Method
  void _editPhone() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: phoneController.text);
        return AlertDialog(
          title: const Text("Edit Phone Number"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Allow only digits
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.length != 10) {
                  _showError("Please enter a valid 10-digit phone number.");
                } else {
                  setState(() {
                    phoneController.text = controller.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Edit Email Method
  void _editEmail() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: emailController.text);
        return AlertDialog(
          title: const Text("Edit Email"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!EmailValidator.validate(controller.text)) {
                  _showError("Please enter a valid email address.");
                } else {
                  setState(() {
                    emailController.text = controller.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Edit Name Method
  void _editName() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: nameController.text);
        return AlertDialog(
          title: const Text("Edit Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  nameController.text = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Edit Company Method
  void _editCompany() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller =
            TextEditingController(text: companyController.text);
        return AlertDialog(
          title: const Text("Edit Company Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Company Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  companyController.text = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

// In your logout method:
  void _logout() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to PageThree and remove the current screen from the stack
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PageThree()), // PageThree is your target page
                );
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without logout
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

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
          // Profile Image Section
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Color(kLight.value),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage, // Trigger image picker on tap
                    child: ClipOval(
                      child: SizedBox(
                        width: 120.0, // Set the width for the circular image
                        height: 120.0, // Set the height for the circular image
                        child: _profileImage == null
                            ? Image.asset(
                                'assets/images/user.png', // Default image
                                fit: BoxFit
                                    .cover, // Ensure the image covers the circle
                              )
                            : Image.file(
                                _profileImage!, // Display selected image
                                fit: BoxFit
                                    .cover, // Ensure the image covers the circle
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Editable Information Section
          Padding(
            padding: EdgeInsets.all(20.0.h),
            child: Column(
              children: [
                // Editable Name Box
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _editName,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name: ${nameController.text}",
                          style: TextStyle(
                              fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Company Box
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _editCompany,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Company: ${companyController.text}", // Display the company name
                          style: TextStyle(
                              fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Email Box
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _editEmail,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email: ${emailController.text}",
                          style: TextStyle(
                              fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Phone Box
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _editPhone,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone: ${phoneController.text}",
                          style: TextStyle(
                              fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Logout Button
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(kDarkBlue.value),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _logout,
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
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
