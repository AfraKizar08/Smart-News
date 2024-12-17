import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/article_detail_screen.dart';
import 'controllers/news_controller.dart';
import 'models/article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize NewsController
    Get.put(NewsController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',

      // Light Theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),

      // system theme by default
      themeMode: ThemeMode.system,

      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) =>
            ArticleDetailScreen(article: ModalRoute.of(context)!.settings.arguments as Article),
        '/bookmarks': (context) => BookmarksScreen(),
      },
    );
  }
}