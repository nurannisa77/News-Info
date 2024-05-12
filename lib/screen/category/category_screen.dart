import 'package:flutter/material.dart';
import 'package:news_info/constant/list_category_constant.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Category',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<NewsPortalProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            Provider.of<NewsPortalProvider>(context, listen: false)
                .getNewsPortal();
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.hasError()) {
            return Center(
              child: Text(provider.getErrorMessage() ?? 'Unknown Error'),
            );
          }
          return ListView.builder(
            itemCount: provider.newsPortal?.endpoints?.length ?? 0,
            itemBuilder: (context, index) {
              final endpoint = provider.getEndpointAtIndex(index);
              final paths = provider.getPathsAtIndex(index) ?? [];
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Center(
                        child: Text(
                          endpoint?.name ?? 'Unknown Endpoint',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: paths.length,
                      itemBuilder: (context, pathIndex) {
                        final path = paths[pathIndex];
                        return GestureDetector(
                          onTap: () {
                            if (paths.isNotEmpty) {
                              provider.setSelectedPath(path);
                              Navigator.pushNamed(
                                context,
                                NameRoutes.newsRoute,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      ListCategoryNameConstant
                                          .categoryNewsImage(path.name ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  ListCategoryNameConstant.categoryNewsName(
                                      path.name ?? ''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
