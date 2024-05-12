import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/news/news_alert_dialog_widget.dart';
import 'package:news_info/screen/news/news_publish_date_widget.dart';
import 'package:news_info/screen/news/news_thumbnail_widget.dart';
import 'package:news_info/screen/news/news_title_widget.dart';

class NewsItemWidget extends StatelessWidget {
  final Post post;

  const NewsItemWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NewsAlertDialogWidget(post: post);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          height: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NewsThumbnailWidget(post: post.thumbnail ?? ''),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NewsTitleWidget(post: post.title ?? ''),
                      NewsPublishDateWidget(post: post.pubDate ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
