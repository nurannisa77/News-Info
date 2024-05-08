import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/news/news_publish_date_widget.dart';
import 'package:news_info/screen/news/news_thumbnail_widget.dart';
import 'package:news_info/screen/news/news_title_widget.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';

class NewsItemWidget extends StatelessWidget {
  final Post post;

  const NewsItemWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: GestureDetector(
        onTap: () {
          NewsProvider.launchURL(context, post.link);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NewsThumbnailWidget(post: post),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NewsTitleWidget(post: post),
                      const SizedBox(height: 4),
                      NewsPublishDateWidget(post: post),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
