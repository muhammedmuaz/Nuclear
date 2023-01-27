// To parse this JSON data, do
//
//     final movieDetailModel = movieDetailModelFromJson(jsonString);

import 'dart:convert';

MovieDetailModel movieDetailModelFromJson(String str) => MovieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieDetailModel data) => json.encode(data.toJson());

class MovieDetailModel {
    MovieDetailModel({
        required this.videoStreamingApp,
        required this.userPlanStatus,
        required this.statusCode,
    });

    VideoStreamingApp videoStreamingApp;
    bool userPlanStatus;
    int statusCode;

    factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
        videoStreamingApp: VideoStreamingApp.fromJson(json["VIDEO_STREAMING_APP"]),
        userPlanStatus: json["user_plan_status"],
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP": videoStreamingApp.toJson(),
        "user_plan_status": userPlanStatus,
        "status_code": statusCode,
    };
}

class VideoStreamingApp {
    VideoStreamingApp({
        required this.movieId,
        required this.movieTitle,
        required this.movieImage,
        required this.movieVideoCrew,
        required this.language,
        required this.movieCountryOfOrigin,
        required this.movieAccess,
        required this.moviesSubtitle,
        required this.description,
        required this.movieDuration,
        required this.releaseDate,
        required this.imdbRating,
        required this.videoType,
        required this.videoUrl,
        required this.downloadEnable,
        required this.downloadUrl,
        required this.langId,
        required this.languageName,
        required this.genreList,
        required this.relatedMovies,
    });

    int movieId;
    String movieTitle;
    String movieImage;
    List<MovieVideoCrew> movieVideoCrew;
    String language;
    String movieCountryOfOrigin;
    MovieAccess movieAccess;
    List<String> moviesSubtitle;
    String description;
    String movieDuration;
    String releaseDate;
    String imdbRating;
    String videoType;
    String videoUrl;
    String downloadEnable;
    String downloadUrl;
    int langId;
    String languageName;
    List<GenreList> genreList;
    List<RelatedMovie> relatedMovies;

    factory VideoStreamingApp.fromJson(Map<String, dynamic> json) => VideoStreamingApp(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        movieImage: json["movie_image"],
        movieVideoCrew: List<MovieVideoCrew>.from(json["movie_video_crew"].map((x) => MovieVideoCrew.fromJson(x))),
        language: json["language"],
        movieCountryOfOrigin: json["movie_country_of_origin"],
        movieAccess: movieAccessValues.map[json["movie_access"]]!,
        moviesSubtitle: List<String>.from(json["movies_subtitle"].map((x) => x)),
        description: json["description"],
        movieDuration: json["movie_duration"],
        releaseDate: json["release_date"],
        imdbRating: json["imdb_rating"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
        downloadEnable: json["download_enable"],
        downloadUrl: json["download_url"],
        langId: json["lang_id"],
        languageName: json["language_name"],
        genreList: List<GenreList>.from(json["genre_list"].map((x) => GenreList.fromJson(x))),
        relatedMovies: List<RelatedMovie>.from(json["related_movies"].map((x) => RelatedMovie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_image": movieImage,
        "movie_video_crew": List<dynamic>.from(movieVideoCrew.map((x) => x.toJson())),
        "language": language,
        "movie_country_of_origin": movieCountryOfOrigin,
        "movie_access": movieAccessValues.reverse[movieAccess],
        "movies_subtitle": List<dynamic>.from(moviesSubtitle.map((x) => x)),
        "description": description,
        "movie_duration": movieDuration,
        "release_date": releaseDate,
        "imdb_rating": imdbRating,
        "video_type": videoType,
        "video_url": videoUrl,
        "download_enable": downloadEnable,
        "download_url": downloadUrl,
        "lang_id": langId,
        "language_name": languageName,
        "genre_list": List<dynamic>.from(genreList.map((x) => x.toJson())),
        "related_movies": List<dynamic>.from(relatedMovies.map((x) => x.toJson())),
    };
}

class GenreList {
    GenreList({
        required this.genreId,
        required this.genreName,
    });

    String genreId;
    String genreName;

    factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
        genreId: json["genre_id"],
        genreName: json["genre_name"],
    );

    Map<String, dynamic> toJson() => {
        "genre_id": genreId,
        "genre_name": genreName,
    };
}

enum MovieAccess { PAID }

final movieAccessValues = EnumValues({
    "Paid": MovieAccess.PAID
});

class MovieVideoCrew {
    MovieVideoCrew({
        required this.name,
        required this.credit,
    });

    String name;
    String credit;

    factory MovieVideoCrew.fromJson(Map<String, dynamic> json) => MovieVideoCrew(
        name: json["name"],
        credit: json["credit"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "credit": credit,
    };
}

class RelatedMovie {
    RelatedMovie({
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

    factory RelatedMovie.fromJson(Map<String, dynamic> json) => RelatedMovie(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: movieAccessValues.map[json["movie_access"]]!,
    );

    Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccessValues.reverse[movieAccess],
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
