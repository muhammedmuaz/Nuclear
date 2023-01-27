import 'dart:convert';

PopularMoviesModel popularMoviesModelFromJson(String str) =>
    PopularMoviesModel.fromJson(json.decode(str));

String popularMoviesModelToJson(PopularMoviesModel data) =>
    json.encode(data.toJson());

class PopularMoviesModel {
  PopularMoviesModel({
    required this.videoStreamingApp,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int statusCode;

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) =>
      PopularMoviesModel(
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
    required this.movieId,
    required this.movieTitle,
    required this.moviePoster,
    required this.movieDuration,
    required this.movieAccess,
  });

  int movieId;
  String movieTitle;
  String moviePoster;
  String movieDuration;
  String movieAccess;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: json["movie_access"],
      );

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccess,
      };
}
