import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/article.dart';
import '../screens/article_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _articles = [];
  bool _isLoading = false;

  void _searchArticles(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final articles = await ApiService().fetchSearchResults(query);
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching articles: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for news...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: _searchArticles,
            ),
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_articles.isEmpty)
            Expanded(
              child: Center(child: Text('No articles found.')),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    onTap: () {
                      // Navigate to article detail screen
                      Get.to(() => ArticleDetailScreen(article: article));
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}