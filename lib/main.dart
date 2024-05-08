import 'package:flutter/material.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/home/news_portal_screen.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsPortalProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: NameRoutes.initRoute,
        routes: {
          NameRoutes.initRoute: (context) => const NewsPortalScreen(),
          NameRoutes.homeRoute: (context) => const NewsPortalScreen(),
        },
      ),
    );
  }
}
