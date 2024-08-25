import 'package:classico/controllers/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawerscreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const Drawerscreen({super.key, required this.indexSetter});

  @override
  State<Drawerscreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<Drawerscreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return GestureDetector();
      },
    );
  }
}
