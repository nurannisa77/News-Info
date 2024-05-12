import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/news/news_card_item_widget.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<NewsProvider>(
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
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<Post>? news) {
    if (news == null || news.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              return NewsItemWidget(post: news[index]);
            },
          ),
        ),
      );
    }
  }
}
