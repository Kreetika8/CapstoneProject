import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final zoomDrawer = ZoomDrawer.of(context);
        if (zoomDrawer != null) {
          zoomDrawer.toggle();
        } else {
          print('ZoomDrawer is null');
        }
      },
      child: SvgPicture.asset(
        "assets/icons/menu.svg", 
        width: 30.w, 
        height: 30.h,
      ),
    );
  }
}
