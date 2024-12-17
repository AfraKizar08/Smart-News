import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/article_card.dart';

class BookmarksScreen extends StatelessWidget {
  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarked Articles')),
      body: Obx(() {
        return newsController.bookmarkedArticles.isEmpty
            ? Center(child: Text('No bookmarks available.'))
            : ListView.builder(
          itemCount: newsController.bookmarkedArticles.length,
          itemBuilder: (context, index) {
            return ArticleCard(article: newsController.bookmarkedArticles[index]);
          },
        );
      }),
    );
  }
}