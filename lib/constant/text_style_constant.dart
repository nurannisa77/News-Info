import 'package:flutter/material.dart';

class TextStyleConstant {
  static TextStyle? onBoardingTittle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onBackground);
  }

  static TextStyle? onBoardingBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onBackground);
  }

  static TextStyle? onBoardingFooter(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary);
  }
}
