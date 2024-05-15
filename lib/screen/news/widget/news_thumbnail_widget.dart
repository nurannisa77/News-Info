import 'package:flutter/material.dart';

class NewsThumbnailWidget extends StatelessWidget {
  final dynamic post;

  const NewsThumbnailWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      child: post != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                post,
                fit: BoxFit.cover,
              ),
            )
          : const Icon(Icons.image_not_supported, size: 120),
    );
  }
}
