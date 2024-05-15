import 'package:flutter/material.dart';
import 'package:news_info/screen/category/widget/category_list_widget.dart';
import 'package:news_info/screen/category/widget/category_search_widget.dart';
import 'package:provider/provider.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/home/provider/home_provider.dart';
import 'package:news_info/screen/category/provider/category_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Category',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer2<CategoryProvider, HomeProvider>(
        builder: (context, categoryProvider, homeProvider, _) {
          if (homeProvider.isLoading) {
            Provider.of<HomeProvider>(context, listen: false).getNewsPortal();
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (homeProvider.hasError()) {
            return Center(
              child: Text(homeProvider.getErrorMessage() ?? 'Unknown Error'),
            );
          }
          return Column(
            children: [
              const CategorySearchWidget(),
              CategoryListWidget(
                endpoints: homeProvider.newsPortal?.endpoints,
                searchQuery: categoryProvider.searchQuery,
                onTap: (path) {
                  homeProvider.setSelectedPath(path);
                  Navigator.pushNamed(
                    context,
                    NameRoutes.newsRoute,
                  );
                },
              ),
              const SizedBox(height: 16,)
            ],
          );
        },
      ),
    );
  }
}
