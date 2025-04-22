import 'package:flutter/material.dart';
import 'package:shayari_app/model/feeds_model.dart';
import 'package:shayari_app/firebase/firebase_service.dart';

class FeedProvider with ChangeNotifier {
  List<FeedModel> _feeds = [];
  String _deviceId = '';

  List<FeedModel> get feeds => _feeds;
  String get deviceId => _deviceId;

  // Set device ID
  void setDeviceId(String deviceId) {
    _deviceId = deviceId;
    notifyListeners();
  }

  // Load feeds
  void loadFeeds(List<FeedModel> feeds) {
    _feeds = feeds;
    notifyListeners();
  }

  // Toggle like for a feed
  Future<void> toggleLike(String feedId) async {
    final feed = _feeds.firstWhere((feed) => feed.id == feedId);
    final isLiked = feed.likes.contains(_deviceId);
    if (isLiked) {
      feed.likes.remove(_deviceId);
    } else {
      feed.likes.add(_deviceId);
    }
    // Update in Firebase
    await FirebaseService().updateFeedLikes(feedId, _deviceId, !isLiked);
    notifyListeners();
  }

    // Toggle saved for a feed
  Future<void> toggleSaved(String feedId) async {
    final feed = _feeds.firstWhere((feed) => feed.id == feedId);
    final isSaved = feed.saved.contains(_deviceId);
    if (isSaved) {
      feed.saved.remove(_deviceId);
    } else {
      feed.saved.add(_deviceId);
    }
    // Update in Firebase
    await FirebaseService().updateFeedSaved(feedId, _deviceId, !isSaved);
    notifyListeners();
  }

  // Trending 
  List<FeedModel> get topFeeds{
    List<FeedModel> sortedFeeds = List.from(_feeds);
    sortedFeeds.sort((a, b)=> b.likes.length.compareTo(a.likes.length));
    return sortedFeeds.take(4).toList();
  }

  
}