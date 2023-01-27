import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/controller/movie_controller.dart';
import 'package:testapp/videoPlayer/video_player.dart';
import 'package:testapp/widgets/movie_card.dart';
import '../constants.dart';
import '../widgets/custom_textfield.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<String> countries = countriesArray.values.toList();

  // Current Year
  int totalyears = DateTime.now().year;
  bool isLoading = false;
  int total = 5;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _countriesscrollController = ScrollController();
  final ScrollController _yearsscrollController = ScrollController();
  final MovieController _movieController = Get.find();

// Search Tags

  bool issearchTagSelected = false;
  List<String> country = [];
  List<int> countryisactive = [];
  bool allcountriesisActive = true;
  List<String> genreId = [];
  List<int> genreIdisactive = [];
  bool allgenreisActive = true;
  List<String> year = [];
  List<int> yearisactive = [];
  bool allyearisActive = true;

  // Scroll Listener

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        child: SafeArea(child: Obx(() {
          return NotificationListener(
            onNotification: (t) {
              if (t is ScrollEndNotification) {
                if (_scrollController.position.maxScrollExtent ==
                    _scrollController.position.pixels) {
                  _movieController.fetchmoremovies(
                      _movieController.allMoviesModel!.totalRecords);
                }
                if (_countriesscrollController.position.maxScrollExtent ==
                    _countriesscrollController.position.pixels) {
                  _movieController.fetchmorecountries(countries.length);
                }
                if (_yearsscrollController.position.maxScrollExtent ==
                    _yearsscrollController.position.pixels) {
                  _movieController.fetchmoreyears(totalyears);
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text Field
                  CustomTextField(
                    isgenrePage: false,
                    ishomePage: false,
                  ),

                  const SizedBox(height: 20),

                  // Search by Tags
                  const Text(
                    "Search by tags",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),

                  const SizedBox(height: 20),

                  // Country Tag
                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        moviecontroller.isloading.value
                            ? Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: boxColor,
                                        highlightColor: Colors.white10,
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: boxColor),
                                        ),
                                      );
                                    }),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    controller: _countriesscrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _movieController.countrieslength.value,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          issearchTagSelected = true;
                                          if (index != 0) {
                                            // Changing total movies length
                                            _movieController
                                                    .explorepageavailablenmovies
                                                    .value =
                                                _movieController.allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()
                                                    .length;

                                            // Checking if lenght is less then 10 then assign total movies lenth to showable length
                                            if (_movieController
                                                    .explorepageavailablenmovies
                                                    .value <
                                                10) {
                                              print(index);
                                              print("IF ran");
                                              _movieController
                                                      .exploremovieslength
                                                      .value =
                                                  _movieController
                                                      .explorepageavailablenmovies
                                                      .value;
                                              print(_movieController
                                                  .exploremovieslength.value);
                                            }

                                            allcountriesisActive = false;
                                            if (countryisactive
                                                .contains(index)) {
                                              int valueIndex = countryisactive
                                                  .indexOf(index);
                                              countryisactive
                                                  .removeAt(valueIndex);
                                              if (country.length == 1) {
                                                if (genreIdisactive.isEmpty &&
                                                    countryisactive.isEmpty &&
                                                    yearisactive.isEmpty) {
                                                  issearchTagSelected = false;
                                                }
                                              }
                                              country.remove(countriesArray.keys
                                                  .toList()[index]);
                                            } else if (!yearisactive
                                                .contains(index)) {
                                              countryisactive.add(index);
                                              country.add(countriesArray.keys
                                                  .toList()[index]);
                                            }
                                          }
                                          if (countryisactive.isEmpty) {
                                            allcountriesisActive = true;
                                          }

                                          if (index == 0) {
                                            allcountriesisActive = true;
                                            countryisactive.clear();
                                            if (allyearisActive &&
                                                allcountriesisActive &&
                                                allgenreisActive) {
                                              issearchTagSelected = false;
                                            }
                                            country.clear();
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: allcountriesisActive &&
                                                      index == 0
                                                  ? const Color(0xffF5A754)
                                                      .withOpacity(0.5)
                                                  : countryisactive
                                                          .contains(index)
                                                      ? const Color(0xffF5A754)
                                                          .withOpacity(0.5)
                                                      : boxColor),
                                          child: AutoSizeText(
                                            countries[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Genre Tag

                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        moviecontroller.isloading.value
                            ? Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: boxColor,
                                        highlightColor: Colors.white10,
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: boxColor),
                                        ),
                                      );
                                    }),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: moviecontroller.genreModel!
                                            .videoStreamingApp.length +
                                        1,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (index != 0) {
                                            // Changing total movies length
                                            _movieController
                                                    .explorepageavailablenmovies
                                                    .value =
                                                _movieController.allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()
                                                    .length;
                                            // Checking if lenght is less then 10 then assign total movies lenth to showable length
                                            if (_movieController
                                                    .explorepageavailablenmovies
                                                    .value <
                                                10) {
                                              _movieController
                                                  .exploremovieslength
                                                  .value = 0;
                                            }

                                            allgenreisActive = false;
                                            if (genreIdisactive
                                                .contains(index)) {
                                              int valueIndex = genreIdisactive
                                                  .indexOf(index);
                                              genreIdisactive
                                                  .removeAt(valueIndex);
                                              if (genreId.length == 1) {
                                                if (genreIdisactive.isEmpty &&
                                                    countryisactive.isEmpty &&
                                                    yearisactive.isEmpty) {
                                                  issearchTagSelected = false;
                                                }
                                              }
                                              genreId.remove(moviecontroller
                                                  .genreModel!
                                                  .videoStreamingApp[index - 1]
                                                  .genreId
                                                  .toString());
                                              // Enabling genre after movies fetched

                                              issearchTagSelected = true;
                                            } else if (!genreIdisactive
                                                .contains(index)) {
                                              genreIdisactive.add(index);
                                              genreId.add(moviecontroller
                                                  .genreModel!
                                                  .videoStreamingApp[index - 1]
                                                  .genreId
                                                  .toString());
                                            }
                                          }

                                          if (genreIdisactive.isEmpty) {
                                            allgenreisActive = true;
                                          }

                                          if (index == 0) {
                                            allgenreisActive = true;
                                            genreIdisactive.clear();
                                            if (allyearisActive &&
                                                allcountriesisActive &&
                                                allgenreisActive) {
                                              issearchTagSelected = false;
                                            }
                                            genreId.clear();
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: allgenreisActive &&
                                                      index == 0
                                                  ? const Color(0xffF5A754)
                                                      .withOpacity(0.5)
                                                  : genreIdisactive
                                                          .contains(index)
                                                      ? const Color(0xffF5A754)
                                                          .withOpacity(0.5)
                                                      : boxColor),
                                          child: index == 0
                                              ? const AutoSizeText(
                                                  "All Genre",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              : AutoSizeText(
                                                  moviecontroller
                                                      .genreModel!
                                                      .videoStreamingApp[
                                                          index - 1]
                                                      .genreName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Years Tag

                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        moviecontroller.isloading.value
                            ? Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: boxColor,
                                        highlightColor: Colors.white10,
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: boxColor),
                                        ),
                                      );
                                    }),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    controller: _yearsscrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _movieController.yearslength.value,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (index != 0) {
                                            _movieController
                                                    .explorepageavailablenmovies
                                                    .value =
                                                _movieController.allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()
                                                    .length;

                                            // Checking if lenght is less then 10 then assign total movies lenth to showable length
                                            if (_movieController
                                                    .explorepageavailablenmovies
                                                    .value <
                                                10) {
                                              print(index);
                                              print("IF ran");
                                              _movieController
                                                      .exploremovieslength
                                                      .value =
                                                  _movieController
                                                      .explorepageavailablenmovies
                                                      .value;
                                              print(_movieController
                                                  .exploremovieslength.value);
                                            }
                                            allyearisActive = false;
                                            issearchTagSelected = true;
                                            if (yearisactive.contains(index)) {
                                              int valueIndex =
                                                  yearisactive.indexOf(index);
                                              yearisactive.removeAt(valueIndex);
                                              if (year.length == 1) {
                                                if (genreIdisactive.isEmpty &&
                                                    countryisactive.isEmpty &&
                                                    yearisactive.isEmpty) {
                                                  issearchTagSelected = false;
                                                }
                                              }
                                              year.remove((totalyears - index)
                                                  .toString());
                                            } else if (!yearisactive
                                                .contains(index)) {
                                              print("Releasing Year");
                                              print(totalyears - index);
                                              yearisactive.add(index);
                                              year.add((totalyears - index)
                                                  .toString());
                                            }
                                          }

                                          if (yearisactive.isEmpty) {
                                            allyearisActive = true;
                                          }

                                          if (index == 0) {
                                            allyearisActive = true;
                                            yearisactive.clear();
                                            if (allyearisActive &&
                                                allcountriesisActive &&
                                                allgenreisActive) {
                                              issearchTagSelected = false;
                                            }
                                            year.clear();
                                          }

                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: devicewidth * 0.25,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: allyearisActive &&
                                                      index == 0
                                                  ? const Color(0xffF5A754)
                                                      .withOpacity(0.5)
                                                  : yearisactive.contains(index)
                                                      ? const Color(0xffF5A754)
                                                          .withOpacity(0.5)
                                                      : boxColor),
                                          child: index == 0
                                              ? const AutoSizeText(
                                                  "All Years",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              : AutoSizeText(
                                                  (totalyears - index)
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const AutoSizeText(
                    "Movies",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),

                  const SizedBox(height: 20),

                  _movieController.ismoviesloading.value
                      ? GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 2,
                                  childAspectRatio: 100 / 140),
                          children: List.generate(6, (index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: Shimmer.fromColors(
                                    baseColor: boxColor,
                                    highlightColor: Colors.white10,
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: boxColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }))
                      : Obx(() {
                          return GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 20.0,
                                      crossAxisCount: 2,
                                      childAspectRatio: deviceheight < 550
                                          ? 100 / 200
                                          : 100 / 150),
                              children: issearchTagSelected
                                  ? _movieController
                                          .isUserSearchedinExplorePage.value

                                      // Movies with Searched Value

                                      ? List.generate(
                                          _movieController
                                              .exploremovieslength.value,
                                          (index) => MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                                  element
                                                                      .release_date) ||
                                                              genreId.contains(
                                                                  element
                                                                      .movie_genre_id) ||
                                                              country.contains(
                                                                  element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                                  element
                                                                      .release_date) ||
                                                              genreId.contains(
                                                                  element
                                                                      .movie_genre_id) ||
                                                              country.contains(
                                                                  element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                                  element
                                                                      .release_date) ||
                                                              genreId.contains(
                                                                  element
                                                                      .movie_genre_id) ||
                                                              country.contains(
                                                                  element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                                  element
                                                                      .release_date) ||
                                                              genreId.contains(
                                                                  element
                                                                      .movie_genre_id) ||
                                                              country.contains(
                                                                  element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .release_date,
                                              ))
                                      :

                                      // Movies without searched value

                                      List.generate(
                                          _movieController
                                              .exploremovieslength.value,
                                          (index) => MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (year.contains(
                                                              element
                                                                  .release_date)
                                                          ? year.contains(element
                                                                      .release_date) &&
                                                                  genreId.contains(
                                                                      element
                                                                          .movie_genre_id)
                                                              ? genreId.contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                      country.contains(
                                                                          element
                                                                              .country_of_origin)
                                                                  ? country.contains(
                                                                      element
                                                                          .country_of_origin)
                                                                  : country
                                                                      .isEmpty
                                                              : genreId.isEmpty
                                                          : year.isEmpty);
                                                    })
                                                    .toList()[index]
                                                    .release_date,
                                              ))
                                  : _movieController
                                          .isUserSearchedinExplorePage.value
                                      ? List.generate(
                                          _movieController.exploremovieslength
                                              .value, (index) {
                                          return MovieCardWidget(
                                            movieId: _movieController
                                                .allMoviesModel!
                                                .videoStreamingApp
                                                .where((element) {
                                                  return element.movieTitle
                                                      .toLowerCase()
                                                      .contains(moviecontroller
                                                          .assignStringExplore
                                                          .value
                                                          .toLowerCase());
                                                })
                                                .toList()[index]
                                                .movieId,
                                            title: _movieController
                                                .allMoviesModel!
                                                .videoStreamingApp
                                                .where((element) {
                                                  return element.movieTitle
                                                      .toLowerCase()
                                                      .contains(moviecontroller
                                                          .assignStringExplore
                                                          .value
                                                          .toLowerCase());
                                                })
                                                .toList()[index]
                                                .movieTitle,
                                            imgurl: _movieController
                                                .allMoviesModel!
                                                .videoStreamingApp
                                                .where((element) {
                                                  return element.movieTitle
                                                      .toLowerCase()
                                                      .contains(moviecontroller
                                                          .assignStringExplore
                                                          .value
                                                          .toLowerCase());
                                                })
                                                .toList()[index]
                                                .moviePoster,
                                            releasedate: _movieController
                                                .allMoviesModel!
                                                .videoStreamingApp[index]
                                                .release_date,
                                          );
                                        })
                                      : List.generate(
                                          _movieController.exploremovieslength
                                              .value, (index) {
                                          return MovieCardWidget(
                                              movieId: _movieController
                                                  .allMoviesModel!
                                                  .videoStreamingApp[index]
                                                  .movieId,
                                              title: _movieController
                                                  .allMoviesModel!
                                                  .videoStreamingApp[index]
                                                  .movieTitle,
                                              imgurl: _movieController
                                                  .allMoviesModel!
                                                  .videoStreamingApp[index]
                                                  .moviePoster,
                                              releasedate: _movieController
                                                  .allMoviesModel!
                                                  .videoStreamingApp[index]
                                                  .release_date);
                                        }));
                        }),

                  _movieController.exploreisfetchingmoremovies.value
                      ? Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        })),
      ),

      // floatingActionButton: FloatingActionButton(onPressed: (() => print(deviceheight)))
    );
  }
}












// List.generate(
//                                       _movieController
//                                           .exploremovieslength.value,
//                                       (index) => _movieController
//                                               .isUserSearchedinExplorePage.value
//                                           ? MovieCardWidget(
//                                               movieId: _movieController
//                                                   .allMoviesModel!
//                                                   .videoStreamingApp
//                                                   .where((element) {
//                                                     return (year.contains(
//                                                                 element
//                                                                     .release_date) ||
//                                                             genreId.contains(element
//                                                                 .movie_genre_id) ||
//                                                             country.contains(element
//                                                                 .country_of_origin)) &&
//                                                         element.movieTitle
//                                                             .toLowerCase()
//                                                             .contains(moviecontroller
//                                                                 .assignStringExplore
//                                                                 .value
//                                                                 .toLowerCase());
//                                                   })
//                                                   .toList()[index]
//                                                   .movieId,
//                                               title: _movieController
//                                                   .allMoviesModel!
//                                                   .videoStreamingApp
//                                                   .where((element) {
//                                                     return (year.contains(
//                                                                 element
//                                                                     .release_date) ||
//                                                             genreId.contains(element
//                                                                 .movie_genre_id) ||
//                                                             country.contains(element
//                                                                 .country_of_origin)) &&
//                                                         element.movieTitle
//                                                             .toLowerCase()
//                                                             .contains(moviecontroller
//                                                                 .assignStringExplore
//                                                                 .value
//                                                                 .toLowerCase());
//                                                   })
//                                                   .toList()[index]
//                                                   .movieTitle,
//                                               imgurl: _movieController
//                                                   .allMoviesModel!
//                                                   .videoStreamingApp
//                                                   .where((element) {
//                                                     return (year.contains(
//                                                                 element
//                                                                     .release_date) ||
//                                                             genreId.contains(element
//                                                                 .movie_genre_id) ||
//                                                             country.contains(element
//                                                                 .country_of_origin)) &&
//                                                         element.movieTitle
//                                                             .toLowerCase()
//                                                             .contains(moviecontroller
//                                                                 .assignStringExplore
//                                                                 .value
//                                                                 .toLowerCase());
//                                                   })
//                                                   .toList()[index]
//                                                   .moviePoster)
//                                           : MovieCardWidget(
//                                               movieId: _movieController
//                                                   .allMoviesModel!
//                                                   .videoStreamingApp
//                                                   .where((element) {
//                                                     return (year.contains(element
//                                                             .release_date) ||
//                                                         genreId.contains(element
//                                                             .movie_genre_id) ||
//                                                         country.contains(element
//                                                             .country_of_origin));
//                                                   })
//                                                   .toList()[index]
//                                                   .movieId,
//                                               title:
//                                                   _movieController
//                                                       .allMoviesModel!
//                                                       .videoStreamingApp
//                                                       .where((element) {
//                                                         return year.contains(element.release_date) ||
//                                                             genreId.contains(element
//                                                                 .movie_genre_id) ||
//                                                             country.contains(element
//                                                                 .country_of_origin);
//                                                       })
//                                                       .toList()[index]
//                                                       .movieTitle,
//                                               imgurl:
//                                                   _movieController
//                                                       .allMoviesModel!
//                                                       .videoStreamingApp
//                                                       .where((element) {
//                                                         return year.contains(element.release_date) ||
//                                                             genreId.contains(element
//                                                                 .movie_genre_id) ||
//                                                             country.contains(element
//                                                                 .country_of_origin);
//                                                       })
//                                                       .toList()[index]
//                                                       .moviePoster))
                                  