import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> fetchNews({String category = 'general'}) async {
    _isLoading = true;
    notifyListeners();

    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7031a2b2a03e4a2b97b372427dad0788';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _articles = (data['articles'] as List)
            .map((json) => Article.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print("Error fetching news: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}

