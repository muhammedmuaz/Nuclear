import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/movie_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/movie_card.dart';
import '../widgets/textWidget.dart';

class Movie_byGenreScreen extends StatefulWidget {
  String movieId;
  String genreName;
  Movie_byGenreScreen(
      {this.genreName = "Popular Movies", required this.movieId, super.key});

  @override
  State<Movie_byGenreScreen> createState() => _Movie_byGenreScreenState();
}

// ignore: camel_case_types
class _Movie_byGenreScreenState extends State<Movie_byGenreScreen> {
  final MovieController _movieController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _movieController.MoviebygenreIdList(widget.movieId, "all").then((value) => {
          _movieController.genremovieslength.value =
              _movieController.genremovie_detail!.totalRecords,
          if (_movieController.genremovie_detail!.totalRecords < 10)
            _movieController.genremoviesdisplaylength.value =
                _movieController.genremovie_detail!.totalRecords
          else
            _movieController.genremoviesdisplaylength.value = 8
        });
  }

  @override
  void dispose() {
    super.dispose();
    _movieController.genremovie_detail!.videoStreamingApp.clear();
    _movieController.genrePageController.value.clear();
    _movieController.genremoviesdisplaylength.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: NotificationListener(
        onNotification: (t) {
          if (t is ScrollEndNotification) {
            if (_scrollController.position.maxScrollExtent ==
                    _scrollController.position.pixels &&
                _movieController.genremoviesdisplaylength.value <
                    _movieController.genremovieslength.value) {
              _movieController.fetchmoregenremovies();
            }
          }
          return false;
        },
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Obx(() {
                    return _movieController.isloadingdetailgenremovies.value
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 80,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      TextWidget(text: "Movies")
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  ishomePage: false,
                                  isgenrePage: true,
                                  // controller: _controller,
                                ),
                                const SizedBox(height: 20),
                                TextWidget(text: widget.genreName),
                                const SizedBox(height: 20),
                                _movieController
                                        .ismovieavailablein_genremovies.value
                                    ? _movieController
                                            .isUserSearchedinGenrePage.value
                                        ? GridView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 5.0,
                                                    crossAxisSpacing: 20.0,
                                                    crossAxisCount: 2,
                                                    childAspectRatio: deviceheight <
                                                            550
                                                        ? 100 / 200
                                                        : deviceheight < 750
                                                            ? 100 / 160
                                                            : deviceheight <
                                                                        750 &&
                                                                    devicewidth >
                                                                        250
                                                                ? 380 / 200
                                                                : 100 / 140),
                                            children: List.generate(
                                                _movieController
                                                    .genremoviesdisplaylength
                                                    .value, (index) {
                                              return MovieCardWidget(
                                                movieId: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return element.movieTitle
                                                          .toLowerCase()
                                                          .contains(_movieController
                                                              .assignStringGenre
                                                              .value
                                                              .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .movieId,
                                                title: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return element.movieTitle
                                                          .toLowerCase()
                                                          .contains(_movieController
                                                              .assignStringGenre
                                                              .value
                                                              .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp
                                                    .where((element) {
                                                      return element.movieTitle
                                                          .toLowerCase()
                                                          .contains(_movieController
                                                              .assignStringGenre
                                                              .value
                                                              .toLowerCase());
                                                    })
                                                    .toList()[index]
                                                    .moviePoster,
                                                releasedate: '',
                                              );
                                            }))
                                        : GridView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 5.0,
                                                    crossAxisSpacing: 20.0,
                                                    crossAxisCount: 2,
                                                    childAspectRatio: deviceheight <
                                                            550
                                                        ? 100 / 200
                                                        : deviceheight < 750
                                                            ? 100 / 160
                                                            : deviceheight <
                                                                        750 &&
                                                                    devicewidth >
                                                                        250
                                                                ? 380 / 200
                                                                : 100 / 140),
                                            children: List.generate(
                                                _movieController
                                                    .genremoviesdisplaylength
                                                    .value, (index) {
                                              return MovieCardWidget(
                                                movieId: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp[index]
                                                    .movieId,
                                                title: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp[index]
                                                    .movieTitle,
                                                imgurl: _movieController
                                                    .genremovie_detail!
                                                    .videoStreamingApp[index]
                                                    .moviePoster,
                                                releasedate: '',
                                              );
                                            }))
                                    : const AutoSizeText(
                                        "No Movie available in this Genre",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                _movieController
                                        .isloadingmoreGenrePagemovies.value
                                    ? Container(
                                        height: 50,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: const CircularProgressIndicator(
                                          color: Colors.orangeAccent,
                                        ),
                                      )
                                    : const SizedBox()
                              ]);
                  }),
                ))),
      ),
    );
  }
}
