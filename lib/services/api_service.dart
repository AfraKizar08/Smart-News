import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String apiKey = '7031a2b2a03e4a2b97b372427dad0788';
  static const String baseUrl = 'https://newsapi.org/v2';

  /// Fetches articles based on a category from the top headlines endpoint.
  Future<List<Article>> fetchArticlesByCategory(String category) async {
    final url = '$baseUrl/top-headlines?category=$category&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  /// Fetches articles based on a query from the everything endpoint.
  Future<List<Article>> fetchArticlesByQuery(String query) async {
    final String fromDate = DateTime.now()
        .subtract(Duration(days: 30))
        .toIso8601String()
        .split('T')[0]; // Last 30 days
    final url =
        '$baseUrl/everything?q=$query&from=$fromDate&sortBy=publishedAt&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  /// Fetches search results from the everything endpoint.
  Future<List<Article>> fetchSearchResults(String query) async {
    final url = '$baseUrl/everything?q=$query&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Business category
  Future<List<Article>> fetchBusinessArticles() async {
    final url = '$baseUrl/top-headlines?category=business&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Entertainment category
  Future<List<Article>> fetchEntertainmentArticles() async {
    final url = '$baseUrl/top-headlines?category=entertainment&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Health category
  Future<List<Article>> fetchHealthArticles() async {
    final url = '$baseUrl/top-headlines?category=health&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Science category
  Future<List<Article>> fetchScienceArticles() async {
    final url = '$baseUrl/top-headlines?category=science&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Sports category
  Future<List<Article>> fetchSportsArticles() async {
    final url = '$baseUrl/top-headlines?category=sports&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  // Fetch articles for Technology category
  Future<List<Article>> fetchTechnologyArticles() async {
    final url = '$baseUrl/top-headlines?category=technology&apiKey=$apiKey';
    return _fetchArticles(url);
  }

  /// Private helper method to make HTTP requests and parse the response.
  Future<List<Article>> _fetchArticles(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body)['articles'];

      // Correctly map the JSON list to a list of Article objects
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load articles. Status Code: ${response.statusCode}');
    }
  }
}