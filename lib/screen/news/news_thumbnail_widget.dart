import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';

class NewsThumbnailWidget extends StatelessWidget {
  final Post post;

  const NewsThumbnailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: post.thumbnail != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                post.thumbnail!,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.image_not_supported, size: 120),
    );
  }
}
