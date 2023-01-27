// To parse this JSON data, do
//
//     final bookmarkModel = bookmarkModelFromJson(jsonString);

import 'dart:convert';

BookmarkModel? bookmarkModelFromJson(String str) => BookmarkModel.fromJson(json.decode(str));

String bookmarkModelToJson(BookmarkModel? data) => json.encode(data!.toJson());

class BookmarkModel {
    BookmarkModel({
        this.videoStreamingApp,
        this.statusCode,
    });

    List<VideoStreamingApp?>? videoStreamingApp;
    int? statusCode;

    factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        videoStreamingApp: json["VIDEO_STREAMING_APP"] == null ? [] : List<VideoStreamingApp?>.from(json["VIDEO_STREAMING_APP"]!.map((x) => VideoStreamingApp.fromJson(x))),
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP": videoStreamingApp == null ? [] : List<dynamic>.from(videoStreamingApp!.map((x) => x!.toJson())),
        "status_code": statusCode,
    };
}

class VideoStreamingApp {
    VideoStreamingApp({
        this.movieId,
        this.movieTitle,
        this.moviePoster,
        this.movieDuration,
        this.movieAccess,
        this.releaseDate,
        this.movieGenreId,
        this.countryOfOrigin,
        this.showId,
        this.showTitle,
        this.showPoster,
    });

    int? movieId;
    String? movieTitle;
    String? moviePoster;
    String? movieDuration;
    String? movieAccess;
    String? releaseDate;
    String? movieGenreId;
    String? countryOfOrigin;
    int? showId;
    String? showTitle;
    String? showPoster;

    factory VideoStreamingApp.fromJson(Map<String, dynamic> json) => VideoStreamingApp(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: json["movie_access"],
        releaseDate: json["release_date"],
        movieGenreId: json["movie_genre_id"],
        countryOfOrigin: json["country_of_origin"],
        showId: json["show_id"],
        showTitle: json["show_title"],
        showPoster: json["show_poster"],
    );

    Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccess,
        "release_date": releaseDate,
        "movie_genre_id": movieGenreId,
        "country_of_origin": countryOfOrigin,
        "show_id": showId,
        "show_title": showTitle,
        "show_poster": showPoster,
    };
}
