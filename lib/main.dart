import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/category/category_screen.dart';
import 'package:news_info/screen/home/news_portal_screen.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';
import 'package:news_info/screen/news/news_screen.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
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
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        theme: FlexThemeData.light(
          scheme: FlexScheme.flutterDash,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.flutterDash,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 13,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: NameRoutes.initRoute,
        routes: {
          NameRoutes.initRoute: (context) =>  CategoryScreen(),
          NameRoutes.homeRoute: (context) => const NewsPortalScreen(),
          NameRoutes.newsRoute: (context) => const NewsScreen(),
        },
      ),
    );
  }
}
