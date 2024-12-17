import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';

class NewsController extends GetxController {
  // News Articles
  RxList<Article> articles = <Article>[].obs;
  RxBool isLoading = false.obs;

  // Bookmarked Articles
  RxList<Article> bookmarkedArticles = <Article>[].obs;

  // Fetch News Articles
  Future<void> fetchNews({String category = 'general'}) async {
    isLoading.value = true;

    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7031a2b2a03e4a2b97b372427dad0788';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles.value = (data['articles'] as List)
            .map((json) => Article.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (error) {
      print('Error fetching news: $error');
    } finally {
      isLoading.value = false;
    }
  }

  // Add to Bookmarks
  void addBookmark(Article article) {
    if (!bookmarkedArticles.contains(article)) {
      bookmarkedArticles.add(article);
    }
  }

  // Remove from Bookmarks
  void removeBookmark(Article article) {
    bookmarkedArticles.remove(article);
  }

  // Check if Article is Bookmarked
  bool isBookmarked(Article article) {
    return bookmarkedArticles.contains(article);
  }

  // Search Articles
  List<Article> searchArticles(String query) {
    return articles.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase()) ||
          article.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}