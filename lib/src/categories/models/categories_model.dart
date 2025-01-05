import 'dart:convert';

List<Categories> userDbFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String userDbToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  String title;
  int id;
  String imageUrl;

  Categories({
    required this.title,
    required this.id,
    required this.imageUrl,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        title: json["title"],
        id: json["id"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "imageUrl": imageUrl,
      };
}
