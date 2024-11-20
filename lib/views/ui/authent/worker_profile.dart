import 'dart:io';
import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/onboarding/widgets/page_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController resumeController = TextEditingController();

  File? _profileImage; // Store the selected image
  File? _resumeFile; // Store the selected PDF file

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load existing profile data when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfileData(); // Load data from shared preferences
    });
  }

  // Load profile data from shared preferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    aboutMeController.text = prefs.getString('aboutMe') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    phoneController.text = prefs.getString('phone') ?? '';
    resumeController.text = prefs.getString('resume') ?? '';

    // Load profile image path if it exists
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }

    // Load resume file path if it exists
    String? resumePath = prefs.getString('resumeFile');
    if (resumePath != null) {
      setState(() {
        _resumeFile = File(resumePath);
      });
    }
  }

  // Save profile data to shared preferences
  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('aboutMe', aboutMeController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('resume', resumeController.text);

    // Save profile image path
    if (_profileImage != null) {
      await prefs.setString('profileImage', _profileImage!.path);
    }

    // Save resume file path
    if (_resumeFile != null) {
      await prefs.setString('resumeFile', _resumeFile!.path);
    }
  }

  // Method to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // You can change this to ImageSource.camera for camera
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Store the image in the state
      });
      _saveProfileData(); // Save the updated profile data
    }
  }

  // Method to pick a resume (PDF file)
  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _resumeFile = File(result.files.single.path!); // Store the selected file
      });
      _saveProfileData(); // Save the updated profile data
    } else {
      // Handle case when no file is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected or file type not supported.')),
      );
    }
  }

  // Method to show error messages
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  // Logout Method
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PageThree()), // PageThree is your target page
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
                      child: _profileImage != null
                          ? Image.file(
                              _profileImage!,
                              width: 120.0.h,
                              height: 120.0.h,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size: 120.0.h,
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(nameController.text.isEmpty
                      ? "Name "
                      : " ${nameController.text}"),
                ],
              ),
            ),
          ),
          // Profile Info Section
          Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              children: [
                _buildEditableBox("Name: ${nameController.text}", _editName),
                const SizedBox(height: 15),
                _buildEditableBox(
                  aboutMeController.text.isEmpty
                      ? "About Me: Tap to edit"
                      : "About Me: ${aboutMeController.text}",
                  _editAboutMe,
                ),
                const SizedBox(height: 15),
                _buildEditableBox("Email: ${emailController.text}", _editEmail),
                const SizedBox(height: 15),
                _buildEditableBox("Phone: ${phoneController.text}", _editPhone),
                const SizedBox(height: 15),
                // Resume Field Section
                GestureDetector(
                  onTap: _pickResume, // Trigger resume picker
                  child: Container(
                    padding: EdgeInsets.all(10.0.h),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _resumeFile != null
                              ? "Resume: ${_resumeFile!.path.split('/').last}"
                              : "Resume: Tap to upload",
                        ),
                        const Icon(Icons.upload_file),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          // Logout Button
          Padding(
            padding: EdgeInsets.all(12.0.h),
            child: ElevatedButton(
              onPressed: _logout,
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for building editable boxes
  Widget _buildEditableBox(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0.h),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            const Icon(Icons.edit),
          ],
        ),
      ),
    );
  }

  // Edit methods for different fields
  void _editName() {
    _showEditDialog('Name', nameController);
  }

  void _editAboutMe() {
    _showEditDialog('About Me', aboutMeController);
  }

  void _editEmail() {
    _showEditDialog('Email', emailController);
  }

  void _editPhone() {
    _showEditDialog('Phone', phoneController);
  }

  // Method for showing editable text fields
  void _showEditDialog(String field, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter your $field'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Save the updated value
                  _saveProfileData();
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
