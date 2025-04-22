// import 'package:flutter/material.dart';
// import '../model/feeds_model.dart';

// class SearchProvider extends ChangeNotifier {
//   String _query = "";
//   List<FeedModel> _allFeeds = [];
//   List<FeedModel> _filteredFeeds = [];

//   String get query => _query;
//   List<FeedModel> get filteredFeeds => _filteredFeeds;

//   void setFeeds(List<FeedModel> feeds) {
//     _allFeeds = feeds;
//     _filteredFeeds = feeds;
//     notifyListeners();
//   }

//   void updateQuery(String query) {
//     _query = query;
//     _filteredFeeds = _allFeeds.where((feed) {
//       return feed.paragraph.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String _query = '';

  String get query => _query;

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }
}
