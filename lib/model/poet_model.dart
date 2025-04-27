// To parse this JSON data, do
//
//     final poet = poetFromJson(jsonString);

import 'dart:convert';

List<Poet> poetFromJson(String str) => List<Poet>.from(json.decode(str).map((x) => Poet.fromJson(x)));

String poetToJson(List<Poet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Poet {
    String name;
    String about;
    String image;
    List<String> awards;
    List<String> education;
    List<String> work;
    List<String> mood;
    String language;

    Poet({
        required this.name,
        required this.about,
        required this.image,
        required this.awards,
        required this.education,
        required this.work,
        required this.language,
        required this.mood,

    });

    factory Poet.fromJson(Map<String, dynamic> json) => Poet(
        name: json["name"],
        about: json["about"],
        image: json["image"],
        awards: List<String>.from(json["awards"].map((x) => x)),
        education: List<String>.from(json["education"].map((x) => x)),
        work: List<String>.from(json["work"].map((x) => x)),
        mood: List<String>.from(json["mood"].map((x) => x)),

        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "about": about,
        "image": image,
        "awards": List<dynamic>.from(awards.map((x) => x)),
        "education": List<dynamic>.from(education.map((x) => x)),
        "work": List<dynamic>.from(work.map((x) => x)),
        "mood": List<dynamic>.from(mood.map((x) => x)),

        "language": language,
    };
}
