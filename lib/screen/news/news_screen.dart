import 'package:flutter/material.dart';
import 'package:news_info/model/get_news_response_model.dart';
import 'package:news_info/screen/news/news_card_item_widget.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<GetNewsResponseModel> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = _fetchNews();
  }

  Future<GetNewsResponseModel> _fetchNews() async {
    return Provider.of<NewsProvider>(context, listen: false).fetchNews(context);
  }

  Widget _buildNewsList(List<Post>? news) {
    if (news == null || news.isEmpty) {
      return const Center(child: Text('No data available'));
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return NewsItemWidget(post: news[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder<GetNewsResponseModel>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return _buildNewsList(snapshot.data?.data?.posts);
          }
        },
      ),
    );
  }
}
