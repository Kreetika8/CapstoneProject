import 'package:flutter/material.dart';
import 'dart:io';

class ProfileNotifierEmployer extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _company = '';
  File? _profileImage;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get company => _company;
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

  void updateCompany(String company) {
    _company = company;
    notifyListeners();
  }

  void updateProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }
}