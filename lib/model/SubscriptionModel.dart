// To parse this JSON data, do
//
//     final subsciptionPlaModel = subsciptionPlaModelFromJson(jsonString);

import 'dart:convert';

SubsciptionPlaModel subsciptionPlaModelFromJson(String str) =>
    SubsciptionPlaModel.fromJson(json.decode(str));

String subsciptionPlaModelToJson(SubsciptionPlaModel data) =>
    json.encode(data.toJson());

class SubsciptionPlaModel {
  SubsciptionPlaModel({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int statusCode;

  factory SubsciptionPlaModel.fromJson(Map<String, dynamic> json) =>
      SubsciptionPlaModel(
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
    required this.planId,
    required this.planName,
    required this.planDuration,
    required this.planPrice,
    required this.description,
    required this.currencyCode,
  });

  int planId;
  String planName;
  String planDuration;
  String planPrice;
  List<String> description;
  String currencyCode;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDuration: json["plan_duration"],
        planPrice: json["plan_price"],
        description: List<String>.from(json["description"].map((x) => x)),
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_name": planName,
        "plan_duration": planDuration,
        "plan_price": planPrice,
        "description": List<dynamic>.from(description.map((x) => x)),
        "currency_code": currencyCode,
      };
}
