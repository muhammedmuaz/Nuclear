import 'dart:async';

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
  const Explore({required Key key}) : super(key: key);

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
  StreamController<int> controller = StreamController<int>();

// Search Tags

  // bool issearchTagSelected = false;

  // Scroll Listener

  void addmorefuturemovies() {
    if (_movieController.exploremovieslength.value <=
        _movieController.totalexploreMovies.value - 2) {
      _movieController.exploremovieslength.value =
          _movieController.exploremovieslength.value + 2;
    } else {
      _movieController.exploremovieslength.value =
          _movieController.totalexploreMovies.value;
    }
  }

  void addmoremovies() {
    // Future.delayed(const Duration(milliseconds: 300), () {
    addmorefuturemovies();
    // });
  }

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
                  addmoremovies();
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
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
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
                  Obx(() {
                    return SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          moviecontroller.isloading.value
                              ? Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, index) {
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
                                      itemCount: _movieController
                                          .countrieslength.value,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            if (index != 0) {
                                              _movieController
                                                  .allcountriesisActive
                                                  .value = false;
                                              if (_movieController
                                                  .countryisactive
                                                  .contains(index)) {
                                                int valueIndex =
                                                    _movieController
                                                        .countryisactive
                                                        .indexOf(index);
                                                _movieController.countryisactive
                                                    .removeAt(valueIndex);
                                                if (_movieController
                                                        .country.length ==
                                                    1) {
                                                  if (_movieController.genreIdisactive.isEmpty &&
                                                      _movieController
                                                          .countryisactive
                                                          .isEmpty &&
                                                      _movieController
                                                          .yearisactive
                                                          .isEmpty) {
                                                    _movieController
                                                        .exploremovieslength
                                                        .value = 8;
                                                    _movieController
                                                        .issearchTagSelected
                                                        .value = false;
                                                  }
                                                }
                                                _movieController.country.remove(
                                                    countriesArray.keys
                                                        .toList()[index]);

// Start

// Checking and Assigning length before its important for exception

                                                if (_movieController
                                                    .country.isNotEmpty) {
                                                  if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Year / Country
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  // Year / Genre

                                                  else if (_movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Country / Genre
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  } else {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

// Assign total length
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }
                                                }

// End
                                              } else if (!_movieController
                                                  .countryisactive
                                                  .contains(index)) {
                                                _movieController.countryisactive
                                                    .add(index);
                                                _movieController.country.add(
                                                    countriesArray.keys
                                                        .toList()[index]);

// Checking and Assigning length before its important for exception

                                                if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Year / Country
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                // Year / Genre

                                                else if (_movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Country / Genre
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                } else {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) ||
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) ||
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                setState(() {});
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = true;
                                              }
                                            }
                                            if (_movieController
                                                .countryisactive.isEmpty) {
                                              _movieController
                                                  .allcountriesisActive
                                                  .value = true;
                                              // Checking and if any other tag activated then assing different length

                                              if (_movieController
                                                          .allyearisActive
                                                          .value !=
                                                      true &&
                                                  _movieController
                                                          .allgenreisActive
                                                          .value !=
                                                      true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id));
                                                        })
                                                        .toList()
                                                        .length;
                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }

                                              // For Year
                                              else if (_movieController
                                                      .allyearisActive.value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                              // For Genre
                                              else if (_movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                            }

                                            if (index == 0) {
                                              _movieController
                                                  .allcountriesisActive
                                                  .value = true;
                                              _movieController.countryisactive
                                                  .clear();
                                              if (_movieController
                                                      .allyearisActive.value &&
                                                  _movieController
                                                      .allcountriesisActive
                                                      .value &&
                                                  _movieController
                                                      .allgenreisActive.value) {
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = false;
                                              }
                                              _movieController.country.clear();
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
                                                color: _movieController
                                                            .allcountriesisActive
                                                            .value &&
                                                        index == 0
                                                    ? const Color(0xffF5A754)
                                                        .withOpacity(0.5)
                                                    : _movieController
                                                            .countryisactive
                                                            .contains(index)
                                                        ? const Color(
                                                                0xffF5A754)
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
                    );
                  }),

                  const SizedBox(height: 15),

                  // Genre Tag

                  Obx(() {
                    return SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          moviecontroller.isloading.value
                              ? Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, index) {
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
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            if (index != 0) {
                                              _movieController.allgenreisActive
                                                  .value = false;
                                              if (_movieController
                                                  .genreIdisactive
                                                  .contains(index)) {
                                                int valueIndex =
                                                    _movieController
                                                        .genreIdisactive
                                                        .indexOf(index);
                                                _movieController.genreIdisactive
                                                    .removeAt(valueIndex);

                                                if (_movieController
                                                        .genreId.length ==
                                                    1) {
                                                  if (_movieController.genreIdisactive.isEmpty &&
                                                      _movieController
                                                          .countryisactive
                                                          .isEmpty &&
                                                      _movieController
                                                          .yearisactive
                                                          .isEmpty) {
                                                    _movieController
                                                        .exploremovieslength
                                                        .value = 8;
                                                    _movieController
                                                        .issearchTagSelected
                                                        .value = false;
                                                    setState(() {});
                                                  }
                                                }
                                                _movieController.genreId.remove(
                                                    moviecontroller
                                                        .genreModel!
                                                        .videoStreamingApp[
                                                            index - 1]
                                                        .genreId
                                                        .toString());
// Start

// Checking and Assigning length before its important for exception

                                                if (_movieController
                                                    .genreId.isNotEmpty) {
                                                  if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Year / Country
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  // Year / Genre

                                                  else if (_movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Country / Genre
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  } else {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

// Assign total length
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }
                                                }

// End
                                              } else if (!_movieController
                                                  .genreIdisactive
                                                  .contains(index)) {
                                                _movieController.genreIdisactive
                                                    .add(index);
                                                _movieController.genreId.add(
                                                    moviecontroller
                                                        .genreModel!
                                                        .videoStreamingApp[
                                                            index - 1]
                                                        .genreId
                                                        .toString());

// Checking and Assigning length before its important for exception

                                                if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Year / Country
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                // Year / Genre

                                                else if (_movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Country / Genre
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                } else {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) ||
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) ||
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

// Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                setState(() {});
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = true;
                                              }
                                            }

                                            if (_movieController
                                                .genreIdisactive.isEmpty) {
                                              _movieController.allgenreisActive
                                                  .value = true;

                                              // Checking and if any other tag activated then assing different length

                                              // For Both Year / Country
                                              if (_movieController
                                                          .allyearisActive
                                                          .value !=
                                                      true &&
                                                  _movieController
                                                          .allcountriesisActive
                                                          .value !=
                                                      true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin));
                                                        })
                                                        .toList()
                                                        .length;
                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }

                                              // For Year
                                              else if (_movieController
                                                      .allyearisActive.value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                              // For Country
                                              else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                            }

                                            if (index == 0) {
                                              _movieController.allgenreisActive
                                                  .value = true;
                                              _movieController.genreIdisactive
                                                  .clear();
                                              if (_movieController
                                                      .allyearisActive.value &&
                                                  _movieController
                                                      .allcountriesisActive
                                                      .value &&
                                                  _movieController
                                                      .allgenreisActive.value) {
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = false;
                                              }
                                              _movieController.genreId.clear();
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
                                                color: _movieController
                                                            .allgenreisActive
                                                            .value &&
                                                        index == 0
                                                    ? const Color(0xffF5A754)
                                                        .withOpacity(0.5)
                                                    : _movieController
                                                            .genreIdisactive
                                                            .contains(index)
                                                        ? const Color(
                                                                0xffF5A754)
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
                    );
                  }),

                  const SizedBox(height: 15),

                  // Years Tag

                  Obx(() {
                    return SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          moviecontroller.isloading.value
                              ? Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, index) {
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
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            if (index != 0) {
                                              _movieController.allyearisActive
                                                  .value = false;

                                              if (_movieController.yearisactive
                                                  .contains(index)) {
                                                int valueIndex =
                                                    _movieController
                                                        .yearisactive
                                                        .indexOf(index);

                                                _movieController.yearisactive
                                                    .removeAt(valueIndex);

                                                if (_movieController
                                                        .year.length ==
                                                    1) {
                                                  if (_movieController.genreIdisactive.isEmpty &&
                                                      _movieController
                                                          .countryisactive
                                                          .isEmpty &&
                                                      _movieController
                                                          .yearisactive
                                                          .isEmpty) {
                                                    _movieController
                                                        .exploremovieslength
                                                        .value = 8;
                                                    _movieController
                                                        .issearchTagSelected
                                                        .value = false;
                                                  }
                                                }
                                                _movieController.year.remove(
                                                    (totalyears - index)
                                                        .toString());

// Start

// Checking and Assigning length before its important for exception

                                                if (_movieController
                                                    .year.isNotEmpty) {
                                                  if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Year / Country
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  // Year / Genre

                                                  else if (_movieController
                                                              .allyearisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) &&
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(
                                                                            element.movie_genre_id));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }

                                                  //  Country / Genre
                                                  else if (_movieController
                                                              .allcountriesisActive
                                                              .value !=
                                                          true &&
                                                      _movieController
                                                              .allgenreisActive
                                                              .value !=
                                                          true) {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) &&
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  } else {
                                                    if (_movieController
                                                            .exploremovieslength
                                                            .value >
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length) {
                                                      _movieController
                                                              .exploremovieslength
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;

// Assign total length
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .exploremovieslength
                                                              .value;
                                                    } else {
                                                      _movieController
                                                              .totalexploreMovies
                                                              .value =
                                                          _movieController
                                                              .allMoviesModel!
                                                              .videoStreamingApp
                                                              .where((element) {
                                                                return (_movieController
                                                                        .year
                                                                        .contains(element
                                                                            .release_date) ||
                                                                    _movieController
                                                                        .genreId
                                                                        .contains(element
                                                                            .movie_genre_id) ||
                                                                    _movieController
                                                                        .country
                                                                        .contains(
                                                                            element.country_of_origin));
                                                              })
                                                              .toList()
                                                              .length;
                                                    }
                                                  }
                                                }

// End

                                              } else if (!_movieController
                                                  .yearisactive
                                                  .contains(index)) {
                                                _movieController.yearisactive
                                                    .add(index);
                                                _movieController.year.add(
                                                    (totalyears - index)
                                                        .toString());

                                                // Checking and Assigning length before its important for exception

                                                if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
// All Values availabe
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                    // Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Year / Country
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    // Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                // Year / Genre

                                                else if (_movieController
                                                            .allyearisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) &&
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                    // Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) &&
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                //  Country / Genre
                                                else if (_movieController
                                                            .allcountriesisActive
                                                            .value !=
                                                        true &&
                                                    _movieController
                                                            .allgenreisActive
                                                            .value !=
                                                        true) {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) &&
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    // Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) &&
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                } else {
                                                  if (_movieController
                                                          .exploremovieslength
                                                          .value >
                                                      _movieController
                                                          .allMoviesModel!
                                                          .videoStreamingApp
                                                          .where((element) {
                                                            return (_movieController
                                                                    .year
                                                                    .contains(
                                                                        element
                                                                            .release_date) ||
                                                                _movieController
                                                                    .genreId
                                                                    .contains(
                                                                        element
                                                                            .movie_genre_id) ||
                                                                _movieController
                                                                    .country
                                                                    .contains(
                                                                        element
                                                                            .country_of_origin));
                                                          })
                                                          .toList()
                                                          .length) {
                                                    _movieController
                                                            .exploremovieslength
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;

                                                    // Assign total length
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .exploremovieslength
                                                            .value;
                                                  } else {
                                                    _movieController
                                                            .totalexploreMovies
                                                            .value =
                                                        _movieController
                                                            .allMoviesModel!
                                                            .videoStreamingApp
                                                            .where((element) {
                                                              return (_movieController
                                                                      .year
                                                                      .contains(
                                                                          element
                                                                              .release_date) ||
                                                                  _movieController
                                                                      .genreId
                                                                      .contains(
                                                                          element
                                                                              .movie_genre_id) ||
                                                                  _movieController
                                                                      .country
                                                                      .contains(
                                                                          element
                                                                              .country_of_origin));
                                                            })
                                                            .toList()
                                                            .length;
                                                  }
                                                }

                                                setState(() {});
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = true;
                                              }
                                            }

                                            if (_movieController
                                                .yearisactive.isEmpty) {
                                              _movieController
                                                  .allyearisActive.value = true;
                                              // Checking and if any other tag activated then assing different length

                                              // For Both Genre / Country
                                              if (_movieController
                                                          .allgenreisActive
                                                          .value !=
                                                      true &&
                                                  _movieController
                                                          .allcountriesisActive
                                                          .value !=
                                                      true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin));
                                                        })
                                                        .toList()
                                                        .length;
                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }

                                              // For Year
                                              else if (_movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                              // For Country
                                              else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true) {
                                                _movieController
                                                        .totalexploreMovies
                                                        .value =
                                                    _movieController
                                                        .allMoviesModel!
                                                        .videoStreamingApp
                                                        .where((element) {
                                                          return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .country_of_origin));
                                                        })
                                                        .toList()
                                                        .length;

                                                if (_movieController
                                                        .totalexploreMovies
                                                        .value >
                                                    _movieController
                                                            .exploremovieslength
                                                            .value +
                                                        8) {
                                                  _movieController
                                                      .exploremovieslength
                                                      .value = 8;
                                                } else {
                                                  _movieController
                                                          .exploremovieslength
                                                          .value =
                                                      _movieController
                                                          .totalexploreMovies
                                                          .value;
                                                }
                                              }
                                            }

                                            if (index == 0) {
                                              _movieController
                                                  .allyearisActive.value = true;
                                              _movieController.yearisactive
                                                  .clear();
                                              if (_movieController
                                                      .allyearisActive.value &&
                                                  _movieController
                                                      .allcountriesisActive
                                                      .value &&
                                                  _movieController
                                                      .allgenreisActive.value) {
                                                _movieController
                                                    .issearchTagSelected
                                                    .value = false;
                                              }
                                              _movieController.year.clear();
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
                                                color: _movieController
                                                            .allyearisActive
                                                            .value &&
                                                        index == 0
                                                    ? const Color(0xffF5A754)
                                                        .withOpacity(0.5)
                                                    : _movieController
                                                            .yearisactive
                                                            .contains(index)
                                                        ? const Color(
                                                                0xffF5A754)
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
                    );
                  }),

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
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 2,
                                  childAspectRatio: deviceheight < 550
                                      ? 100 / 200
                                      : deviceheight < 750
                                          ? 100 / 160
                                          : deviceheight < 750 &&
                                                  devicewidth > 250
                                              ? 380 / 200
                                              : 100 / 140),
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
                                          : deviceheight < 750
                                              ? 100 / 160
                                              : deviceheight < 750 &&
                                                      devicewidth > 250
                                                  ? 380 / 200
                                                  : 100 / 140),
                              children: _movieController
                                      .issearchTagSelected.value
                                  ? _movieController
                                          .isUserSearchedinExplorePage.value

                                      // Movies with Searched Value

                                      ? List.generate(
                                          _movieController.exploremovieslength
                                              .value, (index) {
                                          if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allyearisActive.value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
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
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
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
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }
                                          //  Year / Country
                                          else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allyearisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return ((_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
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
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
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
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) &&
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }

                                          // Year / Genre

                                          else if (_movieController
                                                      .allyearisActive.value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return ((_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase())));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }

                                          //  Country / Genre
                                          else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return ((_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase())));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          } else {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return ((_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) ||
                                                              _movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id) ||
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase()));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) ||
                                                              _movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id) ||
                                                              _movieController
                                                                  .country
                                                                  .contains(element
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
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) ||
                                                              _movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id) ||
                                                              _movieController
                                                                  .country
                                                                  .contains(element
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
                                                      return (_movieController
                                                                  .year
                                                                  .contains(element
                                                                      .release_date) ||
                                                              _movieController
                                                                  .genreId
                                                                  .contains(element
                                                                      .movie_genre_id) ||
                                                              _movieController
                                                                  .country
                                                                  .contains(element
                                                                      .country_of_origin)) &&
                                                          element.movieTitle
                                                              .toLowerCase()
                                                              .contains(moviecontroller
                                                                  .assignStringExplore
                                                                  .value
                                                                  .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }
                                        })
                                      :

                                      // Movies without searched value
                                      List.generate(
                                          _movieController.exploremovieslength
                                              .value, (index) {
                                          if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allyearisActive.value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }

                                          //  Year / Country
                                          else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allyearisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }

                                          // Year / Genre

                                          else if (_movieController
                                                      .allyearisActive.value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) &&
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id);
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }

                                          //  Country / Genre
                                          else if (_movieController
                                                      .allcountriesisActive
                                                      .value !=
                                                  true &&
                                              _movieController
                                                      .allgenreisActive.value !=
                                                  true) {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) &&
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          } else {
                                            return MovieCardWidget(
                                                movieId: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return (_movieController
                                                              .year
                                                              .contains(element
                                                                  .release_date) ||
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) ||
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin));
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) ||
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) ||
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) ||
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) ||
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: _movieController
                                                    .allMoviesModel!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return _movieController.year.contains(element
                                                              .release_date) ||
                                                          _movieController
                                                              .genreId
                                                              .contains(element
                                                                  .movie_genre_id) ||
                                                          _movieController
                                                              .country
                                                              .contains(element
                                                                  .country_of_origin);
                                                    })
                                                    .toList()[index]
                                                    .release_date);
                                          }
                                        })
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
    );
  }
}
