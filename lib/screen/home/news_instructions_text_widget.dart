import 'package:flutter/material.dart';

class NewsInstructionText extends StatelessWidget {
  const NewsInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
      child: Center(
        child: Text(
          "Pick the channels that interests you",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
