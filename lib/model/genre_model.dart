import 'dart:convert';

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
  GenreModel({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int statusCode;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
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
    required this.genreId,
    required this.genreName,
  });

  int genreId;
  String genreName;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        genreId: json["genre_id"],
        genreName: json["genre_name"],
      );

  Map<String, dynamic> toJson() => {
        "genre_id": genreId,
        "genre_name": genreName,
      };
}
