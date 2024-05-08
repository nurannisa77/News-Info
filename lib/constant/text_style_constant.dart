import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_info/constant/color_constant.dart';

class TextStyleConstant {
  static TextStyle boldText = GoogleFonts.inter(
    fontSize: 24,
    color: ColorConstant.whiteColor,
    fontWeight: FontWeight.w900,
  );
   static TextStyle mediumText = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle semiBold = GoogleFonts.poppins(
    fontSize: 12,
    color: ColorConstant.greyColor
  );
}