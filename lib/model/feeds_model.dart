
import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) => List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
    String image;
    int createdAt;
    String paragraph;
    String author;
    String language;
    String id;
    String title;
    String category;
    List<dynamic> likes;
    List<dynamic> saved;


    FeedModel({
        required this.image,
        required this.createdAt,
        required this.paragraph,
        required this.author,
        required this.language,
        required this.id,
        required this.title,
        required this.category,
        required this.likes,
        required this.saved,

        
    });

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        image: json["image"],
        createdAt: json["createdAt"] ?? 0,
        paragraph: json["paragraph"],
        author: json["author"],
        language: json["language"],
        id: json["id"],
        title: json["title"],
        category: json["category"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        saved: List<dynamic>.from(json["saved"].map((x) => x)),

    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "createdAt": createdAt,
        "paragraph": paragraph,
        "author": author,
        "language": language,
        "id": id,
        "title": title,
        "category": category,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "saved": List<dynamic>.from(saved.map((x) => x)),


    };
}
