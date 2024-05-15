import 'package:flutter/material.dart';
import 'package:news_info/screen/bookmark/provider/bookmark_provider.dart';
import 'package:provider/provider.dart';

class BookmarkNewsWidget extends StatelessWidget {
  final dynamic post;
  const BookmarkNewsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        bool isBookmarked = bookmarkProvider.isBookmarked(post.link);
        return IconButton(
          onPressed: () async {
            if (isBookmarked) {
              await bookmarkProvider.deleteBookmark(post.link, context);
            } else {
              await bookmarkProvider.addToBookmark(post, context);
            }
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? Colors.blue : null, 
          ),
        );
      },
    );
  }
}
