import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? trackingId;
    String token;
    Profile profile;

    LoginModel({
        required this.trackingId,
        required this.token,
        required this.profile,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        trackingId: json["trackingID"],
        token: json["token"],
        profile: Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "trackingID": trackingId,
        "token": token,
        "profile": profile.toJson(),
    };
}

class Profile {
    int id;
    String username;
    String fullName;
    String email;
    String image;

    Profile({
        required this.id,
        required this.username,
        required this.fullName,
        required this.email,
        required this.image,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "email": email,
        "image": image,
    };
}