import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testapp/view/movie_byGenre.dart';
import '../controller/movie_controller.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  bool isgenrePage;
  bool ishomePage;
  CustomTextField(
      {required this.isgenrePage, required this.ishomePage, super.key});
  // ScrollController? _scrollController;
  final MovieController moviecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    // Movie Controller
    // Device Pixels
    double deviceheight = MediaQuery.of(context).size.height;
    return Container(
      height: 51,
      color: const Color(0xff1C1A2E),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Obx(() {
            return TextField(
                style: const TextStyle(color: Colors.white),
                onTap: () {
                  if (!moviecontroller.textfieldtapped.value) {
                    moviecontroller.previousmovieslength.value =
                        moviecontroller.exploremovieslength.value;
                  }
                  moviecontroller.textfieldtapped.value = true;
                },
                controller: isgenrePage
                    ? moviecontroller.genrePageController.value
                    : ishomePage
                        ? moviecontroller.homePageController.value
                        : moviecontroller.explorePageController.value,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                cursorColor: Colors.transparent,
                onChanged: ((value) {
                  if (moviecontroller
                      .homePageController.value.text.isNotEmpty) {
                    moviecontroller.isUserSearchedinHomePage.value = true;
                    moviecontroller.assignString.value = value;

                    if (moviecontroller.allMoviesModel!.videoStreamingApp
                            .where((element) {
                          return element.movieTitle.toLowerCase().contains(
                              moviecontroller.assignString.value.toLowerCase());
                        }).length <
                        8) {
                      moviecontroller.homePagemovieslength.value =
                          moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                        return element.movieTitle.toLowerCase().contains(
                            moviecontroller.assignString.value.toLowerCase());
                      }).length;
                    }
                  }

                  if (moviecontroller
                      .explorePageController.value.text.isNotEmpty) {
                    moviecontroller.isUserSearchedinExplorePage.value = true;
                    moviecontroller.assignStringExplore.value = value;

                    if ((moviecontroller.allcountriesisActive.value != false &&
                        moviecontroller.allyearisActive.value != false &&
                        moviecontroller.allgenreisActive.value != false)) {
                      if (moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length <
                          moviecontroller.exploremovieslength.value) {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                          return element.movieTitle.toLowerCase().contains(
                              moviecontroller.assignStringExplore.value
                                  .toLowerCase());
                        }).length;

                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.exploremovieslength.value;
                      } else {
                        if (moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                              return element.movieTitle.toLowerCase().contains(
                                  moviecontroller.assignStringExplore.value
                                      .toLowerCase());
                            }).length <
                            8) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.exploremovieslength.value = 8;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                        }
                      }
                    } else if (moviecontroller.allcountriesisActive.value !=
                            true &&
                        moviecontroller.allyearisActive.value != true &&
                        moviecontroller.allgenreisActive.value != true) {
                      if (moviecontroller.exploremovieslength.value >
                          moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                                return (moviecontroller.year
                                        .contains(element.release_date) &&
                                    moviecontroller.genreId
                                        .contains(element.movie_genre_id) &&
                                    moviecontroller.country
                                        .contains(element.country_of_origin) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              })
                              .toList()
                              .length) {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.exploremovieslength.value;
                      } else {
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      moviecontroller.country
                                          .contains(element.country_of_origin));
                                })
                                .toList()
                                .length;

                        if (moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                              return (moviecontroller.year
                                      .contains(element.release_date) &&
                                  moviecontroller.genreId
                                      .contains(element.movie_genre_id) &&
                                  moviecontroller.country
                                      .contains(element.country_of_origin));
                            }).length <
                            8) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return (moviecontroller.year
                                    .contains(element.release_date) &&
                                moviecontroller.genreId
                                    .contains(element.movie_genre_id) &&
                                moviecontroller.country
                                    .contains(element.country_of_origin));
                          }).length;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.exploremovieslength.value = 8;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                        }
                      }
                    }

                    //  Year / Country
                    else if (moviecontroller.allcountriesisActive.value !=
                            true &&
                        moviecontroller.allyearisActive.value != true) {
                      if (moviecontroller.exploremovieslength.value >
                          moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                                return (moviecontroller.year
                                        .contains(element.release_date) &&
                                    moviecontroller.country
                                        .contains(element.country_of_origin) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              })
                              .toList()
                              .length) {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.exploremovieslength.value;
                      } else {
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;

                        if (moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                              return (moviecontroller.year
                                      .contains(element.release_date) &&
                                  moviecontroller.country
                                      .contains(element.country_of_origin) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length <
                            8) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return (moviecontroller.year
                                    .contains(element.release_date) &&
                                moviecontroller.country
                                    .contains(element.country_of_origin) &&
                                element.movieTitle.toLowerCase().contains(
                                    moviecontroller.assignStringExplore.value
                                        .toLowerCase()));
                          }).length;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.exploremovieslength.value = 8;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                        }
                      }
                    }


                    // Year / Genre

                    else if (moviecontroller.allyearisActive.value != true &&
                        moviecontroller.allgenreisActive.value != true) {
                      if (moviecontroller.exploremovieslength.value >
                          moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                                return (moviecontroller.year
                                        .contains(element.release_date) &&
                                    moviecontroller.genreId
                                        .contains(element.movie_genre_id) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              })
                              .toList()
                              .length) {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.exploremovieslength.value;
                      } else {
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;
                        if (moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                              return (moviecontroller.year
                                      .contains(element.release_date) &&
                                  moviecontroller.genreId
                                      .contains(element.movie_genre_id) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length <
                            8) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return (moviecontroller.year
                                    .contains(element.release_date) &&
                                moviecontroller.genreId
                                    .contains(element.movie_genre_id) &&
                                element.movieTitle.toLowerCase().contains(
                                    moviecontroller.assignStringExplore.value
                                        .toLowerCase()));
                          }).length;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.exploremovieslength.value = 8;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                        }
                      }
                    }

                    //  Country / Genre
                    else if (moviecontroller.allcountriesisActive.value !=
                            true &&
                        moviecontroller.allgenreisActive.value != true) {
                      print("This One Running");
                      if (moviecontroller.exploremovieslength.value >
                          moviecontroller.allMoviesModel!.videoStreamingApp
                              .where((element) {
                                return (moviecontroller.genreId
                                        .contains(element.movie_genre_id) &&
                                    moviecontroller.country
                                        .contains(element.country_of_origin) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              })
                              .toList()
                              .length) {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;

                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.exploremovieslength.value;
                      } else {
                        moviecontroller.totalexploreMovies.value =
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length;

                        if (moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                              return (moviecontroller.genreId
                                      .contains(element.movie_genre_id) &&
                                  moviecontroller.country
                                      .contains(element.country_of_origin) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length <
                            8) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return (moviecontroller.genreId
                                    .contains(element.movie_genre_id) &&
                                moviecontroller.country
                                    .contains(element.country_of_origin) &&
                                element.movieTitle.toLowerCase().contains(
                                    moviecontroller.assignStringExplore.value
                                        .toLowerCase()));
                          }).length;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.exploremovieslength.value = 8;
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                            return element.movieTitle.toLowerCase().contains(
                                moviecontroller.assignStringExplore.value
                                    .toLowerCase());
                          }).length;
                        }
                      }
                    } else {
                      if (moviecontroller.allyearisActive.value != true) {
                        if (moviecontroller.exploremovieslength.value >
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.year
                                          .contains(element.release_date) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.year
                                            .contains(element.release_date) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;

// Assign total length
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.year
                                            .contains(element.release_date) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;

                          if (moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                return (moviecontroller.year
                                        .contains(element.release_date) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              }).length <
                              8) {
                            moviecontroller.exploremovieslength.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return (moviecontroller.year
                                      .contains(element.release_date) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller.exploremovieslength.value;
                          } else {
                            moviecontroller.exploremovieslength.value = 8;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return element.movieTitle.toLowerCase().contains(
                                  moviecontroller.assignStringExplore.value
                                      .toLowerCase());
                            }).length;
                          }
                        }
                      }

                      // For Genre

                      else if (moviecontroller.allgenreisActive.value != true) {
                        if (moviecontroller.exploremovieslength.value >
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.genreId
                                          .contains(element.movie_genre_id) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.genreId
                                            .contains(element.movie_genre_id) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;

// Assign total length
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                          print("This One Run");
                          print(moviecontroller.totalexploreMovies.value);
                        } else {
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.genreId
                                            .contains(element.movie_genre_id) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;
                          if (moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                return (moviecontroller.genreId
                                        .contains(element.movie_genre_id) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              }).length <
                              8) {
                            moviecontroller.exploremovieslength.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return (moviecontroller.genreId
                                      .contains(element.movie_genre_id) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller.exploremovieslength.value;
                          } else {
                            moviecontroller.exploremovieslength.value = 8;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return element.movieTitle.toLowerCase().contains(
                                  moviecontroller.assignStringExplore.value
                                      .toLowerCase());
                            }).length;
                          }
                        }
                      }

                      // For Country

                      else if (moviecontroller.allcountriesisActive.value !=
                          true) {
                        if (moviecontroller.exploremovieslength.value >
                            moviecontroller.allMoviesModel!.videoStreamingApp
                                .where((element) {
                                  return (moviecontroller.country.contains(
                                          element.country_of_origin) &&
                                      element.movieTitle.toLowerCase().contains(
                                          moviecontroller
                                              .assignStringExplore.value
                                              .toLowerCase()));
                                })
                                .toList()
                                .length) {
                          moviecontroller.exploremovieslength.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.country.contains(
                                            element.country_of_origin) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;

// Assign total length
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.exploremovieslength.value;
                        } else {
                          moviecontroller.totalexploreMovies.value =
                              moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                    return (moviecontroller.country.contains(
                                            element.country_of_origin) &&
                                        element.movieTitle
                                            .toLowerCase()
                                            .contains(moviecontroller
                                                .assignStringExplore.value
                                                .toLowerCase()));
                                  })
                                  .toList()
                                  .length;

                          if (moviecontroller.allMoviesModel!.videoStreamingApp
                                  .where((element) {
                                return (moviecontroller.country
                                        .contains(element.country_of_origin) &&
                                    element.movieTitle.toLowerCase().contains(
                                        moviecontroller
                                            .assignStringExplore.value
                                            .toLowerCase()));
                              }).length <
                              8) {
                            moviecontroller.exploremovieslength.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return (moviecontroller.country
                                      .contains(element.country_of_origin) &&
                                  element.movieTitle.toLowerCase().contains(
                                      moviecontroller.assignStringExplore.value
                                          .toLowerCase()));
                            }).length;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller.exploremovieslength.value;
                          } else {
                            moviecontroller.exploremovieslength.value = 8;
                            moviecontroller.totalexploreMovies.value =
                                moviecontroller
                                    .allMoviesModel!.videoStreamingApp
                                    .where((element) {
                              return element.movieTitle.toLowerCase().contains(
                                  moviecontroller.assignStringExplore.value
                                      .toLowerCase());
                            }).length;
                          }
                        }
                      }

//                       if (moviecontroller.exploremovieslength.value >
//                           moviecontroller.allMoviesModel!.videoStreamingApp
//                               .where((element) {
//                                 return (moviecontroller.year
//                                         .contains(element.release_date) ||
//                                     moviecontroller.genreId
//                                         .contains(element.movie_genre_id) ||
//                                     moviecontroller.country.contains(
//                                             element.country_of_origin) &&
//                                         element.movieTitle
//                                             .toLowerCase()
//                                             .contains(moviecontroller
//                                                 .assignStringExplore.value
//                                                 .toLowerCase()));
//                               })
//                               .toList()
//                               .length) {
//                         moviecontroller.exploremovieslength.value =
//                             moviecontroller.allMoviesModel!.videoStreamingApp
//                                 .where((element) {
//                                   return (moviecontroller.year
//                                           .contains(element.release_date) ||
//                                       moviecontroller.genreId
//                                           .contains(element.movie_genre_id) ||
//                                       moviecontroller.country.contains(
//                                               element.country_of_origin) &&
//                                           element.movieTitle
//                                               .toLowerCase()
//                                               .contains(moviecontroller
//                                                   .assignStringExplore.value
//                                                   .toLowerCase()));
//                                 })
//                                 .toList()
//                                 .length;

// // Assign total length
//                         moviecontroller.totalexploreMovies.value =
//                             moviecontroller.exploremovieslength.value;
//                         print("This One Run");
//                         print(moviecontroller.totalexploreMovies.value);
//                       } else {
//                         moviecontroller.totalexploreMovies.value =
//                             moviecontroller.allMoviesModel!.videoStreamingApp
//                                 .where((element) {
//                                   return (moviecontroller.year
//                                           .contains(element.release_date) ||
//                                       moviecontroller.genreId
//                                           .contains(element.movie_genre_id) ||
//                                       moviecontroller.country.contains(
//                                               element.country_of_origin) &&
//                                           element.movieTitle
//                                               .toLowerCase()
//                                               .contains(moviecontroller
//                                                   .assignStringExplore.value
//                                                   .toLowerCase()));
//                                 })
//                                 .toList()
//                                 .length;
//                         print("This One Run Else");
//                         print(moviecontroller.totalexploreMovies.value);
//                       }
                    }
                  }

                  if (moviecontroller
                      .genrePageController.value.text.isNotEmpty) {
                    moviecontroller.isUserSearchedinGenrePage.value = true;
                    moviecontroller.assignStringGenre.value = value;
                    moviecontroller.genremoviesdisplaylength.value =
                        moviecontroller.genremovie_detail!.videoStreamingApp
                            .where((element) {
                      return element.movieTitle.toLowerCase().contains(
                          moviecontroller.assignStringGenre.value
                              .toLowerCase());
                    }).length;
                  }

                  if (value.isEmpty) {
                    if (moviecontroller.homePageController.value.text.isEmpty) {
                      moviecontroller.isUserSearchedinHomePage.value = false;
                    }
                    if (moviecontroller
                        .explorePageController.value.text.isEmpty) {
                      moviecontroller.isUserSearchedinExplorePage.value = false;

                      if ((moviecontroller.allcountriesisActive.value !=
                              false &&
                          moviecontroller.allyearisActive.value != false &&
                          moviecontroller.allgenreisActive.value != false)) {
                        moviecontroller.exploremovieslength.value = 8;
                      } else {
                        moviecontroller.exploremovieslength.value =
                            moviecontroller.previousmovieslength.value;
                      }

                      moviecontroller.textfieldtapped.value = false;
                    }

                    if (moviecontroller
                        .genrePageController.value.text.isEmpty) {
                      moviecontroller.isUserSearchedinGenrePage.value = false;
                    }
                  }
                }),
                decoration: const InputDecoration(
                    filled: false,
                    fillColor: Color(0xff1E2030),
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    hintText: 'What are you watching today',
                    hintTextDirection: TextDirection.ltr,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none));
          })),
          const VerticalDivider(
            color: Colors.white,
            thickness: 0.8,
          ),
          const SizedBox(
            width: 5,
          ),
          !isgenrePage
              ? GestureDetector(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      context: context,
                      builder: (context) => Container(
                        height: deviceheight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.1, 1],
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() => moviecontroller.isloading.value
                                    ? const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.orange,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: deviceheight,
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 100),
                                            child: Column(
                                              children: [
                                                for (int index = 0;
                                                    index <
                                                        moviecontroller
                                                            .genreModel!
                                                            .videoStreamingApp
                                                            .length;
                                                    index++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(Movie_byGenreScreen(
                                                          movieId: moviecontroller
                                                              .genreModel!
                                                              .videoStreamingApp[
                                                                  index]
                                                              .genreId
                                                              .toString(),
                                                          genreName: moviecontroller
                                                              .genreModel!
                                                              .videoStreamingApp[
                                                                  index]
                                                              .genreName));
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      margin: index == 0
                                                          ? const EdgeInsets
                                                                  .only(
                                                              bottom: 15,
                                                              top: 200)
                                                          : const EdgeInsets
                                                              .only(bottom: 15),
                                                      child: Text(
                                                        moviecontroller
                                                            .genreModel!
                                                            .videoStreamingApp[
                                                                index]
                                                            .genreName,
                                                        style: GoogleFonts.inter(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                index == 0
                                                                    ? FontWeight
                                                                        .w500
                                                                    : FontWeight
                                                                        .w300),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                              ],
                            ),
                            GestureDetector(
                              onTap: (() => Navigator.pop(context)),
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(bottom: 10),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: const ImageIcon(AssetImage("assets/menulogo.png"),
                      color: Colors.white))
              : GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

// if (moviecontroller.exploremovieslength.value >
//                           moviecontroller.allMoviesModel!.videoStreamingApp
//                               .where((element) {
//                                 return (moviecontroller.year
//                                         .contains(element.release_date) ||
//                                     moviecontroller.genreId
//                                         .contains(element.movie_genre_id) ||
//                                     moviecontroller.country.contains(
//                                             element.country_of_origin) &&
//                                         element.movieTitle
//                                             .toLowerCase()
//                                             .contains(moviecontroller
//                                                 .assignStringExplore.value
//                                                 .toLowerCase()));
//                               })
//                               .toList()
//                               .length) {
//                         moviecontroller.exploremovieslength.value =
//                             moviecontroller.allMoviesModel!.videoStreamingApp
//                                 .where((element) {
//                                   return (moviecontroller.year
//                                           .contains(element.release_date) ||
//                                       moviecontroller.genreId
//                                           .contains(element.movie_genre_id) ||
//                                       moviecontroller.country.contains(
//                                               element.country_of_origin) &&
//                                           element.movieTitle
//                                               .toLowerCase()
//                                               .contains(moviecontroller
//                                                   .assignStringExplore.value
//                                                   .toLowerCase()));
//                                 })
//                                 .toList()
//                                 .length;

// // Assign total length
//                         moviecontroller.totalexploreMovies.value =
//                             moviecontroller.exploremovieslength.value;
//                         print("This One Run");
//                         print(moviecontroller.totalexploreMovies.value);
//                       } else {
//                         moviecontroller.totalexploreMovies.value =
//                             moviecontroller.allMoviesModel!.videoStreamingApp
//                                 .where((element) {
//                                   return (moviecontroller.year
//                                           .contains(element.release_date) ||
//                                       moviecontroller.genreId
//                                           .contains(element.movie_genre_id) ||
//                                       moviecontroller.country.contains(
//                                               element.country_of_origin) &&
//                                           element.movieTitle
//                                               .toLowerCase()
//                                               .contains(moviecontroller
//                                                   .assignStringExplore.value
//                                                   .toLowerCase()));
//                                 })
//                                 .toList()
//                                 .length;
//                         print("This One Run Else");
//                         print(moviecontroller.totalexploreMovies.value);
//                       }
