import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';

class NewsTitleWidget extends StatelessWidget {
  final Post post;

  const NewsTitleWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      post.title ?? '',
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.w600),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}
