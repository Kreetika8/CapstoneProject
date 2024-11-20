import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProfileNotifierWorker extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _aboutme = '';
  String _resume = '';
  File? _profileImage;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get aboutme => _aboutme;
  String get resume => _resume;
  File? get profileImage => _profileImage;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void updateAboutMe(String aboutme) {
    _aboutme = aboutme;
    notifyListeners();
  }

  void updateResume(String resume) {
    _resume = resume;
    notifyListeners();
  }

  void updateProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController resumeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileNotifier =
          Provider.of<ProfileNotifierWorker>(context, listen: false);
      nameController.text = profileNotifier.name;
      aboutMeController.text = profileNotifier.aboutme;
      emailController.text = profileNotifier.email;
      phoneController.text = profileNotifier.phone;
      resumeController.text = profileNotifier.resume;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutMeController.dispose();
    emailController.dispose();
    phoneController.dispose();
    resumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = Provider.of<ProfileNotifierWorker>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: aboutMeController,
                decoration: InputDecoration(labelText: 'About Me'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: resumeController,
                decoration: InputDecoration(labelText: 'Resume'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  profileNotifier.updateName(nameController.text);
                  profileNotifier.updateAboutMe(aboutMeController.text);
                  profileNotifier.updateEmail(emailController.text);
                  profileNotifier.updatePhone(phoneController.text);
                  profileNotifier.updateResume(resumeController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Profile updated successfully")),
                  );
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
