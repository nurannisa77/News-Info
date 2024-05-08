import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';

class NewsDescriptionWidget extends StatelessWidget {
  final Post post;

  const NewsDescriptionWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Text(
      post.description ?? '',
      style: const TextStyle(
        fontSize: 14,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
