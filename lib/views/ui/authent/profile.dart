import 'dart:io';
import 'package:classico/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _picker = ImagePicker();
  File? _image;
  String _name = "Name";
  String _email = "example@example.com";
  String _phone = "Phone Number";
  String _aboutMe = "This is about me...";
  String _resume = "Resume not uploaded"; // Placeholder for resume file name

  // Method to pick an image for profile
  Future<void> _pickImage() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      print("Permission denied");
    }
  }

  // Method to pick a PDF resume file
  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null) {
      setState(() {
        _resume = result.files.single.name; // Get the name of the selected file
      });
    } else {
      print("No file selected");
    }
  }

  // Edit Name Method
  void _editName() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: _name);
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
                  _name = controller.text;
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

  // Edit Email Method
  void _editEmail() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: _email);
        return AlertDialog(
          title: const Text("Edit Email"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _email = controller.text;
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

  // Edit Phone Method
  void _editPhone() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: _phone);
        return AlertDialog(
          title: const Text("Edit Phone Number"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _phone = controller.text;
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

  // Edit About Me Method
  void _editAboutMe() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: _aboutMe);
        return AlertDialog(
          title: const Text("Edit About Me"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "About Me"),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _aboutMe = controller.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: kLightGrey,
      ),
      body: ListView(
        children: [
          // Profile Image Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image == null
                        ? const AssetImage('assets/images/profile.png')
                        : FileImage(_image!) as ImageProvider,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _editName,
                  child: Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileButton(
            context,
            icon: Icons.picture_as_pdf,
            text: _resume,
            onPressed: _pickResume,
          ),
          _buildProfileButton(
            context,
            icon: Icons.info,
            text: _aboutMe,
            onPressed: _editAboutMe,
          ),
          _buildProfileButton(
            context,
            icon: Icons.email,
            text: _email,
            onPressed: _editEmail,
          ),
          _buildProfileButton(
            context,
            icon: Icons.phone,
            text: _phone,
            onPressed: _editPhone,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Add logout action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "LOGOUT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        color: Colors.grey[200],
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.black),
          label: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
