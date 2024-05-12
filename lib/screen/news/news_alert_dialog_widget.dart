import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/bookmark/news_bookmark_widget.dart';
import 'package:news_info/screen/news/news_description_widget.dart';
import 'package:news_info/screen/news/news_publish_date_widget.dart';
import 'package:news_info/screen/news/news_title_widget.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';

class NewsAlertDialogWidget extends StatelessWidget {
  final Post post;

  const NewsAlertDialogWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            NewsTitleWidget(post: post.title ?? ''),
            const SizedBox(height: 8),
            NewsDescriptionWidget(post: post.description ?? ''),
            const SizedBox(height: 4),
            InkWell(
              onTap: () {
                NewsProvider.launchURL(context, post.link);
              },
              child: Text(
                "Read More",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            NewsPublishDateWidget(post: post.pubDate ?? ''),
            const SizedBox(height: 8),
            NewsBookmarkWidget(post: post),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Close",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
