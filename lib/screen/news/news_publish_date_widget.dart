import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_info/constant/color_constant.dart';
import 'package:news_info/constant/text_style_constant.dart';
import 'package:news_info/model/get_news_response_model.dart';

class NewsPublishDateWidget extends StatelessWidget {
  final Post post;

  const NewsPublishDateWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        post.pubDate != null ? DateFormat.yMMMd().format(post.pubDate!) : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_month_rounded,
            size: 16, color: ColorConstant.greyColor),
        const SizedBox(width: 4),
        Text(
          formattedDate,
          style: TextStyleConstant.semiBold
          ),
      ],
    );
  }
}
