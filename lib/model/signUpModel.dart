// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel? signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel? data) => json.encode(data!.toJson());

class SignUpModel {
    SignUpModel({
        this.videoStreamingApp,
        this.statusCode,
    });

    List<VideoStreamingApp?>? videoStreamingApp;
    int? statusCode;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        videoStreamingApp: json["VIDEO_STREAMING_APP"] == null ? [] : List<VideoStreamingApp?>.from(json["VIDEO_STREAMING_APP"]!.map((x) => VideoStreamingApp.fromJson(x))),
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP": videoStreamingApp == null ? [] : List<dynamic>.from(videoStreamingApp!.map((x) => x!.toJson())),
        "status_code": statusCode,
    };
}

class VideoStreamingApp {
    VideoStreamingApp({
        this.token,
        this.user,
        this.msg,
        this.success,
    });

    String? token;
    User? user;
    String? msg;
    String? success;

    factory VideoStreamingApp.fromJson(Map<String, dynamic> json) => VideoStreamingApp(
        token: json["token"],
        user: User.fromJson(json["user"]),
        msg: json["msg"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "msg": msg,
        "success": success,
    };
}

class User {
    User({
        this.name,
        this.email,
        this.userImage,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? name;
    String? email;
    String? userImage;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        userImage: json["user_image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "user_image": userImage,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
