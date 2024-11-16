import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/exports.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/ui/authent/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Drawerscreen extends StatefulWidget {
  final ValueSetter<int> indexSetter;
  const Drawerscreen({super.key, required this.indexSetter});

  @override
  State<Drawerscreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<Drawerscreen> {

  // A method to navigate to the Home Page using GetX for navigation
  void navigateToHome() {
    // Closes the drawer and navigate to the Home page
    Get.toNamed('/homepage');
    ZoomDrawer.of(context)?.close();
  }

  Widget drawerItem(IconData icon, String title, int index, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
        ZoomDrawer.of(context)!.close(); // Close the drawer after selecting an item
        if (onTap != null) {
          onTap(); // Handle any additional onTap actions here
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 20),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return GestureDetector(
          onDoubleTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Scaffold(
            backgroundColor: Color(kDarkBlue.value),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home drawer item
                drawerItem(
                  AntDesign.home,
                  "Home",
                  0,
                  zoomNotifier.currentIndex == 0
                      ? Color(kLight.value)
                      : Color(kDarkGrey.value),
                  onTap: navigateToHome,  // Navigate to the Home page
                ),
                // Chat drawer item
                drawerItem(
                  Ionicons.chatbubble_outline,
                  "Chat",
                  1,
                  zoomNotifier.currentIndex == 1
                      ? Color(kLight.value)
                      : Color(kDarkGrey.value),
                  onTap: () {
                    Get.toNamed('/chat'); // Navigate to Chat page
                  },
                ),
                // Liked Jobs drawer item
                drawerItem(
                  AntDesign.heart,
                  "Liked Jobs",
                  2,
                  zoomNotifier.currentIndex == 2
                      ? Color(kLight.value)
                      : Color(kDarkGrey.value),
                  onTap: () {
                    Get.toNamed('/liked_jobs'); // Navigate to Liked Jobs page
                  },
                ),
                // Applications drawer item
                drawerItem(
                  AntDesign.calendar,
                  "Applications",
                  3,
                  zoomNotifier.currentIndex == 3
                      ? Color(kLight.value)
                      : Color(kDarkGrey.value),
                  onTap: () {
                    Get.toNamed('/applications'); // Navigate to Applications page
                  },
                ),
                // Profile drawer item
                drawerItem(
                  AntDesign.user,
                  "Profile",
                  4,
                  zoomNotifier.currentIndex == 4
                      ? Color(kLight.value)
                      : Color(kDarkGrey.value),
                  onTap: () {
                    Get.to(() => ProfilePage()); // Navigate to Profile page
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
