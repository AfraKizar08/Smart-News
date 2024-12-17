import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/article_card.dart';
import '../screens/bookmarks_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsController newsController = Get.find();

  final List<String> categories = [
    'General', 'Business', 'Technology',
    'Sports', 'Health', 'Science', 'Entertainment'
  ];

  String _selectedCategory = 'General';
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    newsController.fetchNews(category: 'general');
  }

  // Add theme toggle method
  void _toggleTheme() {
    Get.changeThemeMode(
        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Smart',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      children: [
                        TextSpan(
                          text: ' News',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Add theme toggle button
                    IconButton(
                      icon: Icon(
                          Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: Colors.black
                      ),
                      onPressed: _toggleTheme,
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _isSearching = !_isSearching;
                          if (!_isSearching) {
                            _searchQuery = '';
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookmarksScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    newsController.fetchNews(category: category.toLowerCase());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          Expanded( child: Obx(() {
            if (newsController.isLoading.value) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: double.infinity,
                      color: Colors.white,
                    );
                  },
                ),
              );
            }

            final filteredArticles = newsController.searchArticles(_searchQuery);
            return filteredArticles.isEmpty
                ? const Center(child: Text('No articles found.'))
                : ListView.builder(
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: filteredArticles[index]);
              },
            );
          }),
          ),
        ],
      ),
    );
  }
}