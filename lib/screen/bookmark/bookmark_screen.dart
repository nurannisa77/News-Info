import 'package:flutter/material.dart';
import 'package:news_info/screen/bookmark/provider/bookmark_provider.dart';
import 'package:news_info/screen/news/news_thumbnail_widget.dart';
import 'package:news_info/screen/news/news_title_widget.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark News',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, _) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: bookmarkProvider.getBookmarkListFuture(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No bookmarked news available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final bookmark = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        BookmarkProvider.launchURL(bookmark['link'], context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                              NewsThumbnailWidget(post: bookmark['thumbnail']),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NewsTitleWidget(post: bookmark['title']),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          Provider.of<BookmarkProvider>(context,
                                                  listen: false)
                                              .deleteBookmark(bookmark['link']);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
