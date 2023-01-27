import 'dart:convert';

MoviegenreDetailmodel moviegenreDetailmodelFromJson(String str) =>
    MoviegenreDetailmodel.fromJson(json.decode(str));

String moviegenreDetailmodelToJson(MoviegenreDetailmodel data) =>
    json.encode(data.toJson());

class MoviegenreDetailmodel {
  MoviegenreDetailmodel({
    required this.videoStreamingApp,
    required this.totalRecords,
    required this.statusCode,
  });

  List<VideoStreamingApp> videoStreamingApp;
  int totalRecords;
  int statusCode;

  factory MoviegenreDetailmodel.fromJson(Map<String, dynamic> json) =>
      MoviegenreDetailmodel(
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
  MovieAccess movieAccess;

  factory VideoStreamingApp.fromJson(Map<String, dynamic> json) =>
      VideoStreamingApp(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: movieAccessValues.map![json["movie_access"]]!,
      );

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster,
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
