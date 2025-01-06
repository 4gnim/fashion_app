import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final String email;
  final String id;
  final String username;

  ProfileModel({
    required this.email,
    required this.id,
    required this.username,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json["email"]?.toString() ?? '', // Pastikan email adalah string
        id: json["id"]?.toString() ?? '', // Konversi id ke string
        username: json["username"]?.toString() ??
            '', // Pastikan username adalah string
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "username": username,
      };
}
