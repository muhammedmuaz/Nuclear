import 'package:flutter/material.dart';

class carouselData {
  String imgurl;
  carouselData({
    required this.imgurl,
  });
}

class genres {
  String title;
  bool isenabled;
  genres({required this.title, required this.isenabled});
}

List<carouselData> carousellist = [
  carouselData(
    imgurl: "assets/cover1.png",
  ),
  carouselData(
    imgurl: "assets/cover2.png",
  ),
  carouselData(
    imgurl: "assets/cover3.png",
  )
];

List<carouselData> continueWatchinglist = [
  carouselData(
    imgurl: "assets/watch1.png",
  ),
  carouselData(
    imgurl: "assets/watch2.png",
  ),
  carouselData(
    imgurl: "assets/watch1.png",
  ),
  carouselData(
    imgurl: "assets/watch2.png",
  ),
];

List<carouselData> genresWatchinglist = [
  carouselData(
    imgurl: "assets/watch3.png",
  ),
  carouselData(
    imgurl: "assets/watch4.png",
  ),
  carouselData(
    imgurl: "assets/watch3.png",
  ),
  carouselData(
    imgurl: "assets/watch4.png",
  ),
];

List<genres> genres_list = [
  genres(title: "Action", isenabled: true),
  genres(title: "Comedy", isenabled: false),
  genres(title: "Drama", isenabled: false),
  genres(title: "Fantasy", isenabled: false),
];

List<genres> country_list = [
  genres(title: "All Country", isenabled: true),
  genres(title: "Japan", isenabled: false),
  genres(title: "USA", isenabled: false),
  genres(title: "South Korea", isenabled: false),
  genres(title: "UAE", isenabled: false),
  genres(title: "UK", isenabled: false),
];

List<genres> allgenres_list = [
  genres(title: "All Genre", isenabled: false),
  genres(title: "Action", isenabled: false),
  genres(title: "Comedy", isenabled: false),
  genres(title: "Drama", isenabled: false),
  genres(title: "Fantasy", isenabled: false),
];

List<genres> years_list = [
  genres(title: "All Years", isenabled: false),
  genres(title: "2022", isenabled: false),
  genres(title: "2021", isenabled: false),
  genres(title: "2020", isenabled: false),
  genres(title: "2015-2019", isenabled: false),
];

List<carouselData> gridviewlist = [
  carouselData(
    imgurl: "assets/movie1.png",
  ),
  carouselData(
    imgurl: "assets/movie2.png",
  ),
  carouselData(
    imgurl: "assets/movie3.png",
  ),
  carouselData(
    imgurl: "assets/movie4.png",
  ),
  carouselData(
    imgurl: "assets/movie5.png",
  ),
  carouselData(
    imgurl: "assets/movie6.png",
  )
];

List<carouselData> popularchannellist = [
  carouselData(
    imgurl: "assets/icon1.png",
  ),
  carouselData(
    imgurl: "assets/icon2.png",
  ),
  carouselData(
    imgurl: "assets/icon3.png",
  )
];

class people {
  String ImgUrl;
  String title;
  String subtitle;
  people({required this.ImgUrl, required this.title, required this.subtitle});
}

List<people> peopleList = [
  people(
      ImgUrl: "assets/profile1.png",
      title: "Director",
      subtitle: "Anthon John"),
  people(ImgUrl: "assets/profile3.png", title: "Actor", subtitle: "Jennifer"),
  people(ImgUrl: "assets/profile4.png", title: "Actor", subtitle: "Joanna"),
];
