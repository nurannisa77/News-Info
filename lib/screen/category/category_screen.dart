import 'package:flutter/material.dart';
import 'package:news_info/constant/list_category_constant.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Category',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<NewsPortalProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            Provider.of<NewsPortalProvider>(context, listen: false)
                .getNewsPortal();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.hasError()) {
            return Center(
              child: Text(provider.getErrorMessage() ?? 'Unknown Error'),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24.0,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.4),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.newsPortal?.endpoints?.length ?? 0,
                  itemBuilder: (context, index) {
                    final endpoint = provider.getEndpointAtIndex(index);
                    final paths = provider.getPathsAtIndex(index) ?? [];
                    final filteredPaths = paths.where((path) {
                      final name = ListCategoryNameConstant.categoryNewsName(
                          path.name ?? '');
                      return name
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());
                    }).toList();

                    return filteredPaths.isEmpty
                        ? SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Text(
                                    (endpoint?.name ?? 'Unknown Endpoint')
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                  ),
                                  itemCount: filteredPaths.length,
                                  itemBuilder: (context, pathIndex) {
                                    final path = filteredPaths[pathIndex];
                                    return GestureDetector(
                                      onTap: () {
                                        if (filteredPaths.isNotEmpty) {
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceVariant,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    height: 80 ,
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        ListCategoryNameConstant
                                                            .categoryNewsImage(
                                                                path.name ?? ''),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              ListCategoryNameConstant
                                                      .categoryNewsName(
                                                          path.name ?? '')
                                                  .toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 12,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
