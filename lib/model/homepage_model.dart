// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
    HomePageModel({
        required this.videoStreamingApp,
        required this.statusCode,
    });

    VideoStreamingApp videoStreamingApp;
    int statusCode;

    factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        videoStreamingApp: VideoStreamingApp.fromJson(json["VIDEO_STREAMING_APP"]),
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "VIDEO_STREAMING_APP": videoStreamingApp.toJson(),
        "status_code": statusCode,
    };
}

class VideoStreamingApp {
    VideoStreamingApp({
        required this.slider,
        required this.recentlyWatched,
        required this.latestMovies,
        required this.latestShows,
        required this.popularMovies,
        required this.popularShows,
        required this.homeSections3Title,
        required this.homeSections3Type,
        required this.homeSections3LangId,
        required this.homeSections3,
        required this.homeSections4Title,
        required this.homeSections4Type,
        required this.homeSections4LangId,
        required this.homeSections4,
        required this.homeSections5Title,
        required this.homeSections5Type,
        required this.homeSections5LangId,
        required this.homeSections5,
    });

    List<Slider> slider;
    List<RecentlyWatched> recentlyWatched;
    List<HomeSections3> latestMovies;
    List<Show> latestShows;
    List<HomeSections3> popularMovies;
    List<Show> popularShows;
    String homeSections3Title;
    String homeSections3Type;
    int homeSections3LangId;
    List<HomeSections3> homeSections3;
    String homeSections4Title;
    String homeSections4Type;
    int homeSections4LangId;
    List<dynamic> homeSections4;
    String homeSections5Title;
    String homeSections5Type;
    int homeSections5LangId;
    List<dynamic> homeSections5;

    factory VideoStreamingApp.fromJson(Map<String, dynamic> json) => VideoStreamingApp(
        slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
        recentlyWatched: List<RecentlyWatched>.from(json["recently_watched"].map((x) => RecentlyWatched.fromJson(x))),
        latestMovies: List<HomeSections3>.from(json["latest_movies"].map((x) => HomeSections3.fromJson(x))),
        latestShows: List<Show>.from(json["latest_shows"].map((x) => Show.fromJson(x))),
        popularMovies: List<HomeSections3>.from(json["popular_movies"].map((x) => HomeSections3.fromJson(x))),
        popularShows: List<Show>.from(json["popular_shows"].map((x) => Show.fromJson(x))),
        homeSections3Title: json["home_sections3_title"],
        homeSections3Type: json["home_sections3_type"],
        homeSections3LangId: json["home_sections3_lang_id"],
        homeSections3: List<HomeSections3>.from(json["home_sections3"].map((x) => HomeSections3.fromJson(x))),
        homeSections4Title: json["home_sections4_title"],
        homeSections4Type: json["home_sections4_type"],
        homeSections4LangId: json["home_sections4_lang_id"],
        homeSections4: List<dynamic>.from(json["home_sections4"].map((x) => x)),
        homeSections5Title: json["home_sections5_title"],
        homeSections5Type: json["home_sections5_type"],
        homeSections5LangId: json["home_sections5_lang_id"],
        homeSections5: List<dynamic>.from(json["home_sections5"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
        "recently_watched": List<dynamic>.from(recentlyWatched.map((x) => x.toJson())),
        "latest_movies": List<dynamic>.from(latestMovies.map((x) => x.toJson())),
        "latest_shows": List<dynamic>.from(latestShows.map((x) => x.toJson())),
        "popular_movies": List<dynamic>.from(popularMovies.map((x) => x.toJson())),
        "popular_shows": List<dynamic>.from(popularShows.map((x) => x.toJson())),
        "home_sections3_title": homeSections3Title,
        "home_sections3_type": homeSections3Type,
        "home_sections3_lang_id": homeSections3LangId,
        "home_sections3": List<dynamic>.from(homeSections3.map((x) => x.toJson())),
        "home_sections4_title": homeSections4Title,
        "home_sections4_type": homeSections4Type,
        "home_sections4_lang_id": homeSections4LangId,
        "home_sections4": List<dynamic>.from(homeSections4.map((x) => x)),
        "home_sections5_title": homeSections5Title,
        "home_sections5_type": homeSections5Type,
        "home_sections5_lang_id": homeSections5LangId,
        "home_sections5": List<dynamic>.from(homeSections5.map((x) => x)),
    };
}

class HomeSections3 {
    HomeSections3({
        required this.movieId,
        required this.movieTitle,
        required this.moviePoster,
        required this.movieDuration,
        required this.movieAccess,
        this.moviePosterVideoImage,
    });

    int movieId;
    String movieTitle;
    String moviePoster;
    String movieDuration;
    MovieAccess movieAccess;
    String? moviePosterVideoImage;

    factory HomeSections3.fromJson(Map<String, dynamic> json) => HomeSections3(
        movieId: json["movie_id"],
        movieTitle: json["movie_title"],
        moviePoster: json["movie_poster"],
        movieDuration: json["movie_duration"],
        movieAccess: movieAccessValues.map[json["movie_access"]]!,
        moviePosterVideoImage: json["movie_poster_video_image"],
    );

    Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_title": movieTitle,
        "movie_poster": moviePoster,
        "movie_duration": movieDuration,
        "movie_access": movieAccessValues.reverse[movieAccess],
        "movie_poster_video_image": moviePosterVideoImage,
    };
}

enum MovieAccess { PAID }

final movieAccessValues = EnumValues({
    "Paid": MovieAccess.PAID
});

class Show {
    Show({
        required this.showId,
        required this.showTitle,
        required this.showPoster,
    });

    int showId;
    String showTitle;
    String showPoster;

    factory Show.fromJson(Map<String, dynamic> json) => Show(
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

class RecentlyWatched {
    RecentlyWatched({
        required this.movieName,
        required this.videoId,
        required this.videoType,
        required this.videoImagesFull,
        required this.videoThumbImage,
    });

    String movieName;
    int videoId;
    String videoType;
    String videoImagesFull;
    String videoThumbImage;

    factory RecentlyWatched.fromJson(Map<String, dynamic> json) => RecentlyWatched(
        movieName: json["movie_name"],
        videoId: json["video_id"],
        videoType: json["video_type"],
        videoImagesFull: json["video_images_full"],
        videoThumbImage: json["video_thumb_image"],
    );

    Map<String, dynamic> toJson() => {
        "movie_name": movieName,
        "video_id": videoId,
        "video_type": videoType,
        "video_images_full": videoImagesFull,
        "video_thumb_image": videoThumbImage,
    };
}

class Slider {
    Slider({
        required this.sliderTitle,
        this.sliderType,
        this.sliderPostId,
        required this.sliderImage,
    });

    String sliderTitle;
    dynamic sliderType;
    dynamic sliderPostId;
    String sliderImage;

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        sliderTitle: json["slider_title"],
        sliderType: json["slider_type"],
        sliderPostId: json["slider_post_id"],
        sliderImage: json["slider_image"],
    );

    Map<String, dynamic> toJson() => {
        "slider_title": sliderTitle,
        "slider_type": sliderType,
        "slider_post_id": sliderPostId,
        "slider_image": sliderImage,
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
