import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/env/env.dart';
import 'package:news_info/helper/shared_pref_helper.dart';
import 'package:news_info/screen/bookmark/bookmark_screen.dart';
import 'package:news_info/screen/bookmark/provider/bookmark_provider.dart';
import 'package:news_info/screen/category/category_screen.dart';
import 'package:news_info/screen/category/provider/category_provider.dart';
import 'package:news_info/screen/chatbot/chatbot_screen.dart';
import 'package:news_info/screen/chatbot/provider/chatbot_provider.dart';
import 'package:news_info/screen/home/home_screen.dart';
import 'package:news_info/screen/home/provider/home_provider.dart';
import 'package:news_info/screen/news/news_screen.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
import 'package:news_info/screen/on_boarding/on_boarding_screen.dart';
import 'package:news_info/screen/on_boarding/provider/on_boarding_provider.dart';
import 'package:news_info/widgets/bottom_navbar_widget.dart';
import 'package:news_info/widgets/provider/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Gemini.init(apiKey: Env.geminiKey);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
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
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: NameRoutes.initRoute,
        routes: <String, WidgetBuilder>{
          NameRoutes.initRoute: (context) {
            return FutureBuilder<bool>(
              future: SharedPrefHelper.newUser(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return const OnBoardingScreen();
                } else {
                  return const BottomNavbarWidget();
                }
              },
            );
          },
          NameRoutes.homeRoute: (context) => const HomeScreen(),
          NameRoutes.newsRoute: (context) => const NewsScreen(),
          NameRoutes.categoryRoute: (context) => const CategoryScreen(),
          NameRoutes.bookmarkRoute: (context) => const BookmarkScreen(),
          NameRoutes.chatbotRoute: (context) => const ChatbotScreen(),
          NameRoutes.onBoardingRoute: (context) => const OnBoardingScreen(),
        },
      ),
    );
  }
}
