// To parse this JSON data, do
//
//     final postPaymentStripeResponse = postPaymentStripeResponseFromJson(jsonString);

import 'dart:convert';

PostPaymentStripeResponse postPaymentStripeResponseFromJson(String str) =>
    PostPaymentStripeResponse.fromJson(json.decode(str));

String postPaymentStripeResponseToJson(PostPaymentStripeResponse data) =>
    json.encode(data.toJson());

class PostPaymentStripeResponse {
  PostPaymentStripeResponse({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int statusCode;

  factory PostPaymentStripeResponse.fromJson(Map<String, dynamic> json) =>
      PostPaymentStripeResponse(
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
    required this.stripePaymentToken,
    required this.msg,
    required this.success,
  });

  String stripePaymentToken;
  String msg;
  String success;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        stripePaymentToken: json["stripe_payment_token"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "stripe_payment_token": stripePaymentToken,
        "msg": msg,
        "success": success,
      };
}
