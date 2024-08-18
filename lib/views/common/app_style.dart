import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' as google_fonts;

TextStyle appstyle(double size, Color color, FontWeight fw) {
  return google_fonts.GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw);
}
