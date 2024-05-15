import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/news/widget/news_card_item_widget.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, _) {
        return FutureBuilder<GetNewsResponseModel>(
          future: newsProvider.getNews(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return _buildNewsList(context, snapshot.data?.data?.posts);
            }
          },
        );
      },
    );
  }

  Widget _buildNewsList(BuildContext context, List<Post>? posts) {
    if (posts == null || posts.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return NewsItemWidget(post: posts[index]);
            },
          ),
        ),
      );
    }
  }
}
