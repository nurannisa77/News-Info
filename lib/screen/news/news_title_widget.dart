import 'package:flutter/material.dart';

class NewsTitleWidget extends StatelessWidget {
  final dynamic post;

  const NewsTitleWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      post.toString(),
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
