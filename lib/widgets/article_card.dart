import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/article.dart';
import '../screens/article_detail_screen.dart';

class ArticleCard extends StatefulWidget {
  final Article article;

  const ArticleCard({required this.article, Key? key}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: widget.article.imageUrl.isNotEmpty
                ? Image.network(
              widget.article.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            )
                : Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),
          // Article Details
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.article.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  widget.article.description.isNotEmpty
                      ? widget.article.description
                      : 'No description available.',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Actions (Read More, Like, & Bookmark)
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(() => ArticleDetailScreen(article: widget.article));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Read More'),
              ),
              Row(
                children: [
                  // Heart Icon for Like
                  IconButton(
                    icon: Icon(
                      _isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      // Toggle like status
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                  // Bookmark Icon
                  IconButton(
                    icon: Icon(
                      newsController.isBookmarked(widget.article)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      if (newsController.isBookmarked(widget.article)) {
                        newsController.removeBookmark(widget.article);
                        Get.snackbar(
                          'Removed',
                          'The article has been removed from your bookmarks.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.black,
                        );
                      } else {
                        newsController.addBookmark(widget.article);
                        Get.snackbar(
                          'Added',
                          'The article has been added to your bookmarks.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green.withOpacity(0.8),
                          colorText: Colors.black,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}