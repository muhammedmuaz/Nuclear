import 'dart:convert';

AllShowsModel allShowsModelFromJson(String str) =>
    AllShowsModel.fromJson(json.decode(str));

String allShowsModelToJson(AllShowsModel data) => json.encode(data.toJson());

class AllShowsModel {
  AllShowsModel({
    required this.videoStreamingApp,
    required this.totalRecords,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int totalRecords;
  int statusCode;

  factory AllShowsModel.fromJson(Map<String, dynamic> json) => AllShowsModel(
        videoStreamingApp: List<VideoStreamingApp>.from(
            json["VIDEO_STREAMING_APP"]
                .map((x) => VideoStreamingApp.fromJson(x))),
        totalRecords: json["total_records"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP":
            List<dynamic>.from(videoStreamingApp.map((x) => x.toJson())),
        "total_records": totalRecords,
        "status_code": statusCode,
      };
}

class VideoStreamingApp {
  VideoStreamingApp({
    required this.showId,
    required this.showTitle,
    required this.showPoster,
  });

  int? showId;
  String? showTitle;
  String? showPoster;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        showId: json["show_id"],
        showTitle: json["show_title"],
        showPoster: json["show_poster"],
      );

  Map<String, dynamic> toJson() => {
        "show_id": showId,
        "show_title": showTitle,
        "show_poster": showPoster,
      };
}
