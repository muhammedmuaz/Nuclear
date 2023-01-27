// To parse this JSON data, do
//
//     final checkSubscription = checkSubscriptionFromJson(jsonString);

import 'dart:convert';

CheckSubscription checkSubscriptionFromJson(String str) =>
    CheckSubscription.fromJson(json.decode(str));

String checkSubscriptionToJson(CheckSubscription data) =>
    json.encode(data.toJson());

class CheckSubscription {
  CheckSubscription({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  VideoStreamingApp videoStreamingApp;
  int statusCode;

  factory CheckSubscription.fromJson(Map<String, dynamic> json) =>
      CheckSubscription(
        videoStreamingApp:
            VideoStreamingApp.fromJson(json["VIDEO_STREAMING_APP"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP": videoStreamingApp.toJson(),
        "status_code": statusCode,
      };
}

class VideoStreamingApp {
  VideoStreamingApp({
    required this.currentPlan,
    required this.expiredOn,
    required this.msg,
    required this.success,
  });

  String currentPlan;
  int expiredOn;
  String msg;
  String success;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        currentPlan: json["current_plan"],
        expiredOn: json["expired_on"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "current_plan": currentPlan,
        "expired_on": expiredOn,
        "msg": msg,
        "success": success,
      };
}
