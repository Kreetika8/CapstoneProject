import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/profileprovider_employer.dart';
import 'package:classico/views/common/app_bar.dart';
import 'package:classico/views/common/drawer/drawer_widget.dart';
import 'package:classico/views/ui/onboarding/widgets/page_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

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

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load existing profile data when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileNotifier = Provider.of<ProfileNotifierEmployer>(context, listen: false);
      nameController.text = profileNotifier.name;
      emailController.text = profileNotifier.email;
      phoneController.text = profileNotifier.phone;
      companyController.text = profileNotifier.company;
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        Provider.of<ProfileNotifierEmployer>(context, listen: false)
            .updateProfileImage(File(pickedFile.path));
      });
    }
  }

  void _editPhone() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: phoneController.text);
        return AlertDialog(
          title: const Text("Edit Phone Number"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.length != 10) {
                  _showError("Please enter a valid 10-digit phone number.");
                } else {
                  setState(() {
                                       phoneController.text = controller.text;
                    Provider.of<ProfileNotifierEmployer>(context, listen: false)
                        .updatePhone(controller.text);
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

  void _editEmail() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: emailController.text);
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
                    Provider.of<ProfileNotifierEmployer>(context, listen: false)
                        .updateEmail(controller.text);
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

  void _editName() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: nameController.text);
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
                  Provider.of<ProfileNotifierEmployer>(context, listen: false)
                      .updateName(controller.text);
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

  void _editCompany() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: companyController.text);
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
                  Provider.of<ProfileNotifierEmployer>(context, listen: false)
                      .updateCompany(controller.text);
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

  void _logout() {
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
                  MaterialPageRoute(builder: (context) => const PageThree()),
                );
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    final profileNotifier = Provider.of<ProfileNotifierEmployer>(context);

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
                    onTap: _pickImage,
                    child: ClipOval(
                      child: SizedBox(
                        width: 120.0,
                        height: 120.0,
                        child: profileNotifier.profileImage == null
                            ? Image.asset(
                                'assets/images/user.png', // Default image
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                profileNotifier.profileImage!,
                                fit: BoxFit.cover,
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
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.0.h),
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
                          "Name: ${profileNotifier.name}",
                          style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Company Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.0.h),
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
                          "Company: ${profileNotifier.company}",
                          style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Email Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.0.h),
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
                          "Email: ${profileNotifier.email}",
                          style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Editable Phone Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 12.0.h),
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
                          "Phone: ${profileNotifier.phone}",
                          style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600),
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

  // Method to show error messages
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}