import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shayari_app/model/feeds_model.dart';

import '../model/poet_model.dart';
import '../utils/logger.dart';
class FirebaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> saveUserData(String deviceId, List<String>moods) async{
  firestore.collection("users").doc(deviceId).set({
    'deviceId': deviceId,
    'moods': moods,
  });
}
  static Stream<List<FeedModel>> getFeeds(String language) {
    return firestore.collection("feeds").where("language", isEqualTo: language).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return FeedModel.fromJson(doc.data());
      }).toList();
    });
  }

  // Get feeds based on the selected name 
  
   Stream<List<FeedModel>> getFeedByPoetName(String name) {
    return firestore.collection("feeds").where("author", isEqualTo: name).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return FeedModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<List<DocumentSnapshot>> fetchFilteredFeeds(List<String> moods) async {
    var querySnapshot = await firestore.collection('feeds').where('category', whereIn: moods).get();
    return querySnapshot.docs;
  }

  // Get POET
    static Stream<List<Poet>> getPoet() {
    return firestore.collection("poet").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return Poet.fromJson(doc.data());
      }).toList();
    });
  }

    // Get POET
   Stream<List<Poet>> getPoetProfile(String poetName) {
    return firestore.collection("poet").where('name', isEqualTo: poetName).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return Poet.fromJson(doc.data());
      }).toList();
    });
  }

    // Get POET BASED ON THR LANGUAGE
  //   static Stream<List<Poet>> getPoetBasedOnLanguage(String lang) {
  //   return firestore.collection("poet").where('language', isEqualTo: lang.toUpperCase()).snapshots().map((snapshot){
  //     return snapshot.docs.map((doc){
  //       return Poet.fromJson(doc.data());
  //     }).toList();
  //   });
  // }


static Stream<List<Poet>> getPoetBasedOnLanguage(String lang) {
  final language = lang.toUpperCase().trim();
  logger.d("QUERYING FOR LANGUAGE: $language");
  
  return firestore.collection("poet")
    .snapshots()
    .map((snapshot) {
      logger.d("ALL POETS IN DATABASE:");
      for (var doc in snapshot.docs) {
        logger.d("ID: ${doc.id} | Language: ${doc['language']} | Name: ${doc['name']}");
      }
      
      // Then filter client-side for testing
      return snapshot.docs
          .where((doc) => doc['language'].toString().toUpperCase() == language)
          .map((doc) => Poet.fromJson(doc.data()))
          .toList();
    });
}
  
  
    // Update likes for a feed
  Future<void> updateFeedLikes(String feedId, String deviceId, bool isLiked) async {
    try {
      if (isLiked) {
        // Add deviceId to likes array
        await firestore.collection("feeds").doc(feedId).update({
          'likes': FieldValue.arrayUnion([deviceId]),
        });
      } else {
        // Remove deviceId from likes array
        await firestore.collection("feeds").doc(feedId).update({
          'likes': FieldValue.arrayRemove([deviceId]),
        });
      }
    } catch (e) {
      print("Error updating feed likes: $e");
      rethrow;
    }
  }


   // Update likes for a feed
  Future<void> updateFeedSaved(String feedId, String deviceId, bool isLiked) async {
    try {
      if (isLiked) {
        // Add deviceId to likes array
        await firestore.collection("feeds").doc(feedId).update({
          'saved': FieldValue.arrayUnion([deviceId]),
        });
      } else {
        // Remove deviceId from likes array
        await firestore.collection("feeds").doc(feedId).update({
          'saved': FieldValue.arrayRemove([deviceId]),
        });
      }
    } catch (e) {
      print("Error updating feed likes: $e");
      rethrow;
    }
  }



   // Get LIKED LIST
     Stream<List<FeedModel>> getLikedList({required deviceId}) {
    return firestore.collection("feeds").where('likes', arrayContains: deviceId).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return FeedModel.fromJson(doc.data());
      }).toList();
    });
  }

  
   // Get SAVED LIST
     Stream<List<FeedModel>> getSavedList({required deviceId}) {
    return firestore.collection("feeds").where('saved', arrayContains: deviceId).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return FeedModel.fromJson(doc.data());
      }).toList();
    });
  }

  // get the poet post 

    Future<List<DocumentSnapshot>> poetFeed(String name) async {
    var querySnapshot = await firestore.collection('feeds').where('author', isEqualTo: name).get();
    return querySnapshot.docs;
  }

  

}