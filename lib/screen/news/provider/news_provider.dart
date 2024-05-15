import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/home/provider/home_provider.dart';
import 'package:news_info/service/news_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsProvider extends ChangeNotifier {
  Future<GetNewsResponseModel> getNews(BuildContext context) async {
    final newsProvider =
        Provider.of<HomeProvider>(context, listen: false);
    final selectedPath = newsProvider.selectedPath?.path;

    final response = await NewsService.getNews(selectedPath);
    return GetNewsResponseModel.fromJson(response.data);
  }

  static void launchURL(BuildContext context, String? url) async {
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
