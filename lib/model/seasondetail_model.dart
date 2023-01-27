// To parse this JSON data, do
//
//     final seasonDetailModel = seasonDetailModelFromJson(jsonString);

import 'dart:convert';

SeasonDetailModel seasonDetailModelFromJson(String str) =>
    SeasonDetailModel.fromJson(json.decode(str));

String seasonDetailModelToJson(SeasonDetailModel data) =>
    json.encode(data.toJson());

class SeasonDetailModel {
  SeasonDetailModel({
    required this.videoStreamingApp,
    required this.userPlanStatus,
    required this.totalRecords,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  bool userPlanStatus;
  int totalRecords;
  int statusCode;

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        videoStreamingApp: List<VideoStreamingApp>.from(
            json["VIDEO_STREAMING_APP"]
                .map((x) => VideoStreamingApp.fromJson(x))),
        userPlanStatus: json["user_plan_status"],
        totalRecords: json["total_records"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP":
            List<dynamic>.from(videoStreamingApp.map((x) => x.toJson())),
        "user_plan_status": userPlanStatus,
        "total_records": totalRecords,
        "status_code": statusCode,
      };
}

class VideoStreamingApp {
  VideoStreamingApp({
    required this.episodeId,
    required this.episodeSubtitle,
    required this.episodeTitle,
    required this.episodeImage,
    required this.videoAccess,
    required this.description,
    required this.duration,
    required this.releaseDate,
    required this.imdbRating,
    required this.videoType,
    required this.videoUrl,
    required this.langId,
    required this.languageName,
    required this.genreList,
    required this.seriesName,
    required this.seasonName,
    required this.downloadEnable,
    required this.downloadUrl,
  });

  int episodeId;
  List<String> episodeSubtitle;
  String episodeTitle;
  String episodeImage;
  String videoAccess;
  String description;
  String duration;
  String releaseDate;
  String imdbRating;
  String videoType;
  String videoUrl;
  int langId;
  String languageName;
  List<String> genreList;
  String seriesName;
  String seasonName;
  String downloadEnable;
  String downloadUrl;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        episodeId: json["episode_id"],
        episodeSubtitle:
            List<String>.from(json["episode_subtitle"].map((x) => x)),
        episodeTitle: json["episode_title"],
        episodeImage: json["episode_image"],
        videoAccess: json["video_access"],
        description: json["description"],
        duration: json["duration"],
        releaseDate: json["release_date"],
        imdbRating: json["imdb_rating"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
        langId: json["lang_id"],
        languageName: json["language_name"],
        genreList: List<String>.from(json["genre_list"].map((x) => x)),
        seriesName: json["series_name"],
        seasonName: json["season_name"],
        downloadEnable: json["download_enable"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "episode_id": episodeId,
        "episode_subtitle": List<dynamic>.from(episodeSubtitle.map((x) => x)),
        "episode_title": episodeTitle,
        "episode_image": episodeImage,
        "video_access": videoAccess,
        "description": description,
        "duration": duration,
        "release_date": releaseDate,
        "imdb_rating": imdbRating,
        "video_type": videoType,
        "video_url": videoUrl,
        "lang_id": langId,
        "language_name": languageName,
        "genre_list": List<dynamic>.from(genreList.map((x) => x)),
        "series_name": seriesName,
        "season_name": seasonName,
        "download_enable": downloadEnable,
        "download_url": downloadUrl,
      };
}
