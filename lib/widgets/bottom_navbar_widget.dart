import 'package:flutter/material.dart';
import 'package:news_info/screen/bookmark/bookmark_screen.dart';
import 'package:news_info/screen/category/category_screen.dart';
import 'package:news_info/screen/home/home_screen.dart';
import 'package:news_info/widgets/provider/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavbarProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: provider.currentIndex,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          BookmarkScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setCurrentIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).colorScheme.secondary),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Theme.of(context).colorScheme.onPrimary),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Theme.of(context).colorScheme.secondary),
            label: 'Category',
            activeIcon: Icon(Icons.category, color: Theme.of(context).colorScheme.onPrimary),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_rounded, color: Theme.of(context).colorScheme.secondary),
            label: 'Bookmark',
            activeIcon: Icon(Icons.bookmark_add_rounded, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary, 
        unselectedItemColor: Theme.of(context).colorScheme.secondary, 
      ),
    );
  }
}
