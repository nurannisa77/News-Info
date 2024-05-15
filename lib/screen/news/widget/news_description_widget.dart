import 'package:flutter/material.dart';

class NewsDescriptionWidget extends StatelessWidget {
  final dynamic post;

  const NewsDescriptionWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Text(
      post,
      style: const TextStyle(
        fontSize: 14,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
