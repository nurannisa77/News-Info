import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_info/screen/category/provider/category_provider.dart';

class CategorySearchWidget extends StatelessWidget {
  const CategorySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: TextField(
          onChanged: (value) {
            Provider.of<CategoryProvider>(context, listen: false)
                .setSearchQuery(value);
          },
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            labelText: 'Search',
            labelStyle: TextStyle(
              fontSize: 16.0,
              color:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 24.0,
              color:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
