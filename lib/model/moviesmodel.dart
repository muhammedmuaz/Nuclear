import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  MoviesModel({
    required this.videoStreamingApp,
    required this.totalRecords,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int totalRecords;
  int statusCode;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
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
  VideoStreamingApp(
      {required this.movieId,
      required this.movieTitle,
      required this.moviePoster,
      required this.movieDuration,
      required this.movieAccess,
      required this.release_date,
      required this.movie_genre_id,
      required this.country_of_origin});

  int movieId;
  String movieTitle;
  String moviePoster;
  String movieDuration;
  MovieAccess movieAccess;
  String release_date;
  String movie_genre_id;
  String country_of_origin;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"] == null ? "" : json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: movieAccessValues.map![json["movie_access"]]!,
        release_date: json["release_date"],
        movie_genre_id: json["movie_genre_id"],
        country_of_origin: json["country_of_origin"],
      );

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster == null ? "" : moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccessValues.reverse[movieAccess],
      };
}

enum MovieAccess { PAID }

final movieAccessValues = EnumValues({"Paid": MovieAccess.PAID});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

class AllMoviesModelExplore {
  AllMoviesModelExplore(
      {required this.movieId,
      required this.movieTitle,
      required this.moviePoster,
      required this.movieDuration,
      required this.movieAccess,
      required this.release_date,
      required this.movie_genre_id,
      required this.country_of_origin});

  int movieId;
  String movieTitle;
  String moviePoster;
  String movieDuration;
  MovieAccess movieAccess;
  String release_date;
  String movie_genre_id;
  String country_of_origin;

  factory AllMoviesModelExplore.fromJson(Map<String, dynamic> json) =>
      AllMoviesModelExplore(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"] == null ? "" : json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: movieAccessValues.map![json["movie_access"]]!,
        release_date: json["release_date"],
        movie_genre_id: json["movie_genre_id"],
        country_of_origin: json["country_of_origin"],
      );

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster == null ? "" : moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccessValues.reverse[movieAccess],
      };
}