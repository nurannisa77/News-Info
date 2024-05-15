import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsPublishDateWidget extends StatelessWidget {
  final dynamic post;

  const NewsPublishDateWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        post != null ? DateFormat.yMMMd().format(post) : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_month_rounded,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(formattedDate, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
