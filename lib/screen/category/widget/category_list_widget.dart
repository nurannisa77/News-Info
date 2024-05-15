import 'package:flutter/material.dart';
import 'package:news_info/constant/list_category_constant.dart';
import 'package:news_info/model/get_list_news_portal_response_model.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Endpoint>? endpoints;
  final String searchQuery;
  final Function(Path) onTap;

  const CategoryListWidget({
    super.key,
    this.endpoints,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: endpoints?.length ?? 0,
        itemBuilder: (context, index) {
          final endpoint = endpoints?[index];
          final paths = endpoint?.paths ?? [];
          final filteredPaths = paths.where((path) {
            final name =
                ListCategoryNameConstant.categoryNewsName(path.name ?? '');
            return name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

          return filteredPaths.isEmpty
              ? const SizedBox.shrink()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      (endpoint?.name ?? 'Unknown Endpoint').toUpperCase(),
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 30.0,
                    ),
                    itemCount: filteredPaths.length,
                    itemBuilder: (context, pathIndex) {
                      final path = filteredPaths[pathIndex];
                      return GestureDetector(
                        onTap: () {
                          onTap(path);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 96,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                                    width: 60,
                                    height: 60,
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
                                  Text(
                                    ListCategoryNameConstant
                                            .categoryNewsName(
                                                path.name ?? '')
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
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
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
        },
      ),
    );
  }
}
