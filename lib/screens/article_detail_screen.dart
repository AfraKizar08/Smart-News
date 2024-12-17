import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            article.imageUrl.isNotEmpty
                ? Image.network(article.imageUrl, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            // Article Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Article Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                article.description.isNotEmpty ? article.description : 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}