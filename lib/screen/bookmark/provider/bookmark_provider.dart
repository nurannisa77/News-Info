import 'package:flutter/material.dart';
import 'package:news_info/db/db_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class BookmarkProvider extends ChangeNotifier {
  late Future<List<Map<String, dynamic>>> _bookmarkListFuture;
  List<String> _bookmarkLinks = [];

  BookmarkProvider() {
    _refreshBookmarkList();
  }

Future<void> _refreshBookmarkList() async {
  _bookmarkListFuture = DbHelper.instance.getBookmarks();
  List<Map<String, dynamic>> bookmarks = await _bookmarkListFuture;
  _bookmarkLinks = bookmarks.map((bookmark) => bookmark['link'] as String).toList();
  notifyListeners();
}


  Future<void> deleteBookmark(String link) async {
    await DbHelper.instance.deleteBookmark(link);
    _refreshBookmarkList();
  }

  Future<List<Map<String, dynamic>>> getBookmarkListFuture() async {
    return _bookmarkListFuture;
  }

  bool isBookmarked(String link) {
    return _bookmarkLinks.contains(link);
  }

  Future<void> addToBookmark(dynamic post, BuildContext context) async {
    await DbHelper.instance.insertBookmark({
      'link': post.link,
      'title': post.title,
      'pubDate': post.pubDate,
      'description': post.description,
      'thumbnail': post.thumbnail,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully added to Bookmark!')),
    );
    _refreshBookmarkList();
    notifyListeners();
  }

  static void launchURL(String? url, BuildContext context) async {
    if (url != null && url.isNotEmpty) {
      var uri = Uri.parse(url.toLowerCase());
      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
        } else {
          throw 'Could not launch $uri';
        }
      } catch (e) {
        'Error launching URL: $e';
      }
    }
  }
}
