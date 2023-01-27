import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int statusCode;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        videoStreamingApp: List<VideoStreamingApp>.from(
            json["VIDEO_STREAMING_APP"]
                .map((x) => VideoStreamingApp.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP":
            List<dynamic>.from(videoStreamingApp.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class VideoStreamingApp {
  VideoStreamingApp({
    required this.token,
    required this.userId,
    required this.name,
    required this.email,
    required this.userImage,
    required this.msg,
    required this.success,
  });

  String token;
  int userId;
  String name;
  String email;
  String userImage;
  String msg;
  String success;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        token: json["token"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        userImage: json["user_image"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "name": name,
        "email": email,
        "user_image": userImage,
        "msg": msg,
        "success": success,
      };
}
