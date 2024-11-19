  import 'package:classico/constants/app_constants.dart';
  import 'package:classico/controllers/exports.dart';
  import 'package:classico/views/common/app_style.dart';
  import 'package:classico/views/common/reusable_text.dart';

  import 'package:flutter/material.dart';
  import 'package:flutter_vector_icons/flutter_vector_icons.dart';
  import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

  import 'package:provider/provider.dart';

  class DrawerscreenEmployer extends StatefulWidget {
    final ValueSetter<int> indexSetter;
    const DrawerscreenEmployer({super.key, required this.indexSetter});

    @override
    State<DrawerscreenEmployer> createState() => _DrawerScreenState();
  }

  class _DrawerScreenState extends State<DrawerscreenEmployer> {
    Widget drawerItem(IconData icon, String title, int index, Color color, {VoidCallback? onTap}) {
      return GestureDetector(
        onTap: () {
          widget.indexSetter(index);
          ZoomDrawer.of(context)!.close(); // Close the drawer after selecting an item
          if (onTap != null) {
            onTap();
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

    Widget drawerItems(
        IconData icon, String text, int index, Color color, Color txtcolor) {
      return GestureDetector(
        onTap: () {
          widget.indexSetter(index);
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(
                width: 12,
              ),
              ReusableText(
                text: text,
                style: appstyle(12, color, FontWeight.bold),
              ),
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
              backgroundColor: Color(kDarkPurple.value),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  drawerItem(
                    AntDesign.home,
                    "Home",
                    0,
                    zoomNotifier.currentIndex == 0
                        ? Color(kDark.value)
                        : Color(kLight.value),
                  ),
                  drawerItem(
                    Ionicons.chatbubble_outline,
                    "Applications",
                    1,
                    zoomNotifier.currentIndex == 1
                        ? Color(kDark.value)
                        : Color(kLight.value),
                  ),
                  drawerItem(
                    AntDesign.pluscircleo,
                    "Create Work",
                    2,
                    zoomNotifier.currentIndex == 2
                        ? Color(kDark.value)
                        : Color(kLight.value),
                        
                  ),
                  drawerItem(
                    AntDesign.calendar,
                    "My Work",
                    3,
                    zoomNotifier.currentIndex == 3
                        ? Color(kDark.value)
                        : Color(kLight.value),
                        
                  ),
                  drawerItem(
                    AntDesign.user,
                    "Profile",
                    4,
                    zoomNotifier.currentIndex == 4
                        ? Color(kDark.value)
                        : Color(kLight.value),
                  ),
                  
                ],
              ),
            ),
          );
        },
      );
    }
  }