import 'package:classico/constants/app_constants.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/drawer/drawerScreen.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/common/width_spacer.dart';
import 'package:classico/views/ui/applications/applications.dart';
import 'package:classico/views/ui/authent/worker_profile.dart';
import 'package:classico/views/ui/chat/explore.dart';
import 'package:classico/views/ui/search/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:classico/controllers/zoom_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
          menuScreen: Drawerscreen(
            indexSetter: (index) {
              zoomNotifier.currentIndex = index;
            },
          ),
          mainScreen: currentScreen(),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(kDarkBlue.value), 
        );
      },
    );
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const Homepage();

      case 1:
        return const ExplorePage();
      case 2:
        return const WorkerProfilePage();

      default:
        return const Homepage();
    }
  }
}


Widget drawerItem(
  IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: null,
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            Icon(icon, color: color,),

            const WidthSpacer(
              width: 12,
            ),

            ReusableText(text: text, 
            style: appstyle(12, color, FontWeight.bold))
          ],),
      )
    );
  }

