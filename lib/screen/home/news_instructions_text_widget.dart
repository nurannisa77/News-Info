import 'package:flutter/material.dart';
import 'package:news_info/constant/text_style_constant.dart';

class NewsInstructionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Text(
        "Pick the channels that interests you",
        style: TextStyleConstant.boldText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
