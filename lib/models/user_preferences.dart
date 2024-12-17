class UserPreferences {
  final List<String> bookmarks;

  UserPreferences({this.bookmarks = const []});

  void addBookmark(String articleUrl) {
    bookmarks.add(articleUrl);
  }

  void removeBookmark(String articleUrl) {
    bookmarks.remove(articleUrl);
  }
}
