import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:testapp/controller/movie_controller.dart';
import 'package:testapp/view/moviedetailPage.dart';
import 'package:testapp/view/Shows/showdetailPage.dart';
import 'package:testapp/widgets/custom_textfield.dart';
import 'package:testapp/widgets/textWidget.dart';
import '../constants.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: non_constant_identifier_names
int carousel_index = 0;

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  final MovieController moviecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        leading: Container(),
        title: const AutoSizeText(
          "NHV",
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   Stack(
        //     children: [
        //       IconButton(
        //         onPressed: () => Get.to(const NotificationScreen()),
        //         icon: const FaIcon(FontAwesomeIcons.bell),
        //         color: Colors.white,
        //       ),
        //       Positioned(
        //         right: 11,
        //         top: 11,
        //         child: Container(
        //           padding: const EdgeInsets.all(2),
        //           decoration: BoxDecoration(
        //             color: Colors.red,
        //             borderRadius: BorderRadius.circular(6),
        //           ),
        //           constraints: const BoxConstraints(
        //             minWidth: 14,
        //             minHeight: 14,
        //           ),
        //           child: const Text(
        //             '12',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 8,
        //             ),
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ],
      ),
      body: SafeArea(child: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: moviecontroller.homePage_networkError.value
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [TextWidget(text: "Network Error")],
                  ),
                )
              : moviecontroller.isUserSearchedinHomePage.value

                  // If user searched

                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text Field
                          CustomTextField(
                            isgenrePage: false,
                            ishomePage: true,
                          ),
                          const SizedBox(height: 20),
                          moviecontroller.ismoviesloading.value
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
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );

                                    // GestureDetector(
                                    //     onTap: () => Get.to(MovieDetail(
                                    //           movieId: 3,
                                    //         )),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       mainAxisAlignment: MainAxisAlignment.start,
                                    //       children: [
                                    //         Container(
                                    //           height: 150,
                                    //           width: double.infinity,
                                    //           margin: const EdgeInsets.symmetric(
                                    //               vertical: 10),
                                    //           decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             // image: DecorationImage(
                                    //             //     image: CachedNetworkImageProvider(
                                    //             //         _movieController
                                    //             //             .popularMoviesModel!
                                    //             //             .videoStreamingApp[index]
                                    //             //             .moviePoster),
                                    //             //     fit: BoxFit.fill)
                                    //           ),
                                    //           child: CachedNetworkImage(
                                    //             fit: BoxFit.fill,
                                    //             imageUrl: _movieController
                                    //                 .popularMoviesModel!
                                    //                 .videoStreamingApp[index]
                                    //                 .moviePoster,
                                    //             placeholder: (context, url) {
                                    //               return Shimmer.fromColors(
                                    //                 baseColor: boxColor,
                                    //                 highlightColor: Colors.white10,
                                    //                 child: Container(
                                    //                   height: double.infinity,
                                    //                   width: double.infinity,
                                    //                   decoration: BoxDecoration(
                                    //                       color: boxColor,
                                    //                       borderRadius:
                                    //                           BorderRadius.circular(
                                    //                               10.0)),
                                    //                 ),
                                    //               );
                                    //             },
                                    //           ),
                                    //         ),
                                    //         const SizedBox(height: 5),
                                    //         AutoSizeText(
                                    //             _movieController
                                    //                 .popularMoviesModel!
                                    //                 .videoStreamingApp[index]
                                    //                 .movieTitle,
                                    //             style: const TextStyle(
                                    //                 color: Colors.white,
                                    //                 fontSize: 15.0)),
                                    //         const SizedBox(height: 5),
                                    //         AutoSizeText("1h 15min | Sci-Fi",
                                    //             style: TextStyle(
                                    //                 color:
                                    //                     Colors.grey.withOpacity(0.8),
                                    //                 fontSize: 12.0))
                                    //       ],
                                    //     ));
                                  }))
                              : GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 5.0,
                                          crossAxisSpacing: 20.0,
                                          crossAxisCount: 2,
                                          childAspectRatio: 100 / 150),
                                  children: List.generate(
                                      moviecontroller
                                          .homePagemovieslength.value, (index) {
                                    return MovieCardWidget(
                                        movieId: moviecontroller
                                            .allMoviesModel!.videoStreamingApp
                                            .where((element) {
                                              return element.movieTitle
                                                  .toLowerCase()
                                                  .contains(moviecontroller
                                                      .assignString.value
                                                      .toLowerCase());
                                            })
                                            .toList()[index]
                                            .movieId,
                                        title: moviecontroller
                                            .allMoviesModel!.videoStreamingApp
                                            .where((element) {
                                              return element.movieTitle
                                                  .toLowerCase()
                                                  .contains(moviecontroller
                                                      .assignString.value
                                                      .toLowerCase());
                                            })
                                            .toList()[index]
                                            .movieTitle,
                                        imgurl: moviecontroller
                                            .allMoviesModel!.videoStreamingApp
                                            .where((element) {
                                              return element.movieTitle
                                                  .toLowerCase()
                                                  .contains(moviecontroller
                                                      .assignString.value
                                                      .toLowerCase());
                                            })
                                            .toList()[index]
                                            .moviePoster,
                                        releasedate: moviecontroller
                                            .allMoviesModel!
                                            .videoStreamingApp[index]
                                            .release_date);
                                  }))
                        ],
                      ),
                    )

                  // If user not searched

                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(builder: (context) {
                            return CustomTextField(
                              ishomePage: true,
                              isgenrePage: false,
                            );
                          }),
                          const SizedBox(height: 20),

                          Obx(
                            () => moviecontroller.isloadinghomepageApi.value
                                ? CarouselSlider(
                                    options: CarouselOptions(
                                        height: 300.0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        aspectRatio: 16 / 9,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enableInfiniteScroll: true,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        viewportFraction: 0.8,
                                        onPageChanged: ((index, reason) {
                                          setState(() {
                                            carousel_index = index;
                                          });
                                        })),
                                    items: [1, 2, 3].map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Shimmer.fromColors(
                                                baseColor: boxColor,
                                                highlightColor: Colors.white10,
                                                child: Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: boxColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                ),
                                              ));
                                        },
                                      );
                                    }).toList(),
                                  )
                                : CarouselSlider(
                                    options: CarouselOptions(
                                        height: 300.0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        aspectRatio: 16 / 9,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enableInfiniteScroll: true,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        viewportFraction: 0.8,
                                        onPageChanged: ((index, reason) {
                                          setState(() {
                                            carousel_index = index;
                                          });
                                        })),
                                    items: moviecontroller.homepagemovies!
                                        .videoStreamingApp.popularMovies
                                        .map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () => Get.to(MovieDetail(
                                              movieId: i.movieId,
                                            )),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  SizedBox(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: i.moviePoster,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        fit: BoxFit.fill,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              color: boxColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              image: const DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/errorImg.jpg"),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        ),
                                                        placeholder:
                                                            (context, url) {
                                                          return Shimmer
                                                              .fromColors(
                                                            baseColor: boxColor,
                                                            highlightColor:
                                                                Colors.white10,
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      boxColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 25),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.asset(
                                                            "assets/tile.png",
                                                            fit: BoxFit.contain,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                          ),
                          const SizedBox(height: 10),

                          // Carousel Dots

                          Obx(
                            () => moviecontroller.isloadinghomepageApi.value
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      for (int x = 0;
                                          x <
                                              moviecontroller
                                                  .homepagemovies!
                                                  .videoStreamingApp
                                                  .popularMovies
                                                  .length;
                                          x++)
                                        Container(
                                          height: 8,
                                          width: 8,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: carousel_index == x
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 20),
// Recently Watched Section
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .recentlyWatched
                                      .isNotEmpty
                                  ? TextWidget(text: "Recently Watched")
                                  : const SizedBox(),

                          moviecontroller.isloadinghomepageApi.value
                              ? SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Container(
                                          width: 220,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: GestureDetector(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: 155,
                                                  width: 220,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Shimmer.fromColors(
                                                    baseColor: boxColor,
                                                    highlightColor:
                                                        Colors.white10,
                                                    child: Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: boxColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                    ),
                                                  )),
                                              const SizedBox(height: 5),
                                            ],
                                          )),
                                        );
                                      }),
                                )
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .recentlyWatched
                                      .isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .recentlyWatched
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .recentlyWatched[
                                                                index]
                                                            .videoId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 155,
                                                            width: 182,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                imageUrl: moviecontroller
                                                                    .homepagemovies!
                                                                    .videoStreamingApp
                                                                    .recentlyWatched[
                                                                        index]
                                                                    .videoThumbImage,
                                                                placeholder:
                                                                    (context,
                                                                        url) {
                                                                  return Shimmer
                                                                      .fromColors(
                                                                    baseColor:
                                                                        boxColor,
                                                                    highlightColor:
                                                                        Colors
                                                                            .white10,
                                                                    child:
                                                                        Container(
                                                                      height: double
                                                                          .infinity,
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              boxColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0)),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                              height: 182,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(
                                                                    value: index ==
                                                                            1
                                                                        ? 0.9
                                                                        : index ==
                                                                                2
                                                                            ? 0.2
                                                                            : 0.7,
                                                                    color: index ==
                                                                            1
                                                                        ? Colors
                                                                            .green
                                                                        : index ==
                                                                                2
                                                                            ? Colors.red
                                                                            : Colors.orange,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(0xff74737E).withOpacity(
                                                                            0.7),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    // alignment: Alignment.center,
                                                                    child:
                                                                        const ImageIcon(
                                                                      AssetImage(
                                                                          "assets/tile.png"),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      AutoSizeText(
                                                          moviecontroller
                                                              .homepagemovies!
                                                              .videoStreamingApp
                                                              .recentlyWatched[
                                                                  index]
                                                              .movieName,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.0)),
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),
                          const SizedBox(height: 20),

// Latest Movies
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.latestMovies.isNotEmpty
                                  ? TextWidget(text: "Latest Movies")
                                  : const SizedBox(),

                          // const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          // Fetching Latest Movies List
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.latestMovies.isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .latestMovies
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .latestMovies[index]
                                                            .movieId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .latestMovies[
                                                                      index]
                                                                  .moviePoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .latestMovies[
                                                                    index]
                                                                .movieTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// Latest Shows
                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.latestShows.isNotEmpty
                                  ? TextWidget(text: "Latest Shows")
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.latestShows.isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .latestShows
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(ShowDetailPage(
                                                        showId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .latestShows[index]
                                                            .showId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .latestShows[
                                                                      index]
                                                                  .showPoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .latestShows[
                                                                    index]
                                                                .showTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// Popular Movies

                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .popularMovies
                                      .isNotEmpty
                                  ? TextWidget(text: "Popular Movies")
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .popularMovies
                                      .isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .popularMovies
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .popularMovies[
                                                                index]
                                                            .movieId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .popularMovies[
                                                                      index]
                                                                  .moviePoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .popularMovies[
                                                                    index]
                                                                .movieTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// Popular Shows

                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.popularShows.isNotEmpty
                                  ? TextWidget(text: "Popular Shows")
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller.homepagemovies!
                                      .videoStreamingApp.popularShows.isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .popularShows
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(ShowDetailPage(
                                                        showId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .popularShows[index]
                                                            .showId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .popularShows[
                                                                      index]
                                                                  .showPoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .popularShows[
                                                                    index]
                                                                .showTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// Englosh Movies

                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections3
                                      .isNotEmpty
                                  ? TextWidget(
                                      text: moviecontroller.homepagemovies!
                                          .videoStreamingApp.homeSections3Title)
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections3
                                      .isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .homeSections3
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .homeSections3[
                                                                index]
                                                            .movieId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              child:
                                                                  ExtendedImage
                                                                      .network(
                                                                fit:
                                                                    BoxFit.fill,
                                                                // imageUrl:
                                                                moviecontroller
                                                                    .homepagemovies!
                                                                    .videoStreamingApp
                                                                    .homeSections3[
                                                                        index]
                                                                    .moviePoster,
                                                                loadStateChanged:
                                                                    (state) {
                                                                  if (state
                                                                          .extendedImageLoadState ==
                                                                      LoadState
                                                                          .loading) {
                                                                    return Shimmer
                                                                        .fromColors(
                                                                      baseColor:
                                                                          boxColor,
                                                                      highlightColor:
                                                                          Colors
                                                                              .white10,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            double.infinity,
                                                                        width: double
                                                                            .infinity,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                boxColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0)),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              )
                                                              //     CachedNetworkImage(
                                                              //   fit: BoxFit.fill,
                                                              //   imageUrl: ,
                                                              //   placeholder:
                                                              //       (context, url) {
                                                              //     return Shimmer
                                                              //         .fromColors(
                                                              //       baseColor:
                                                              //           boxColor,
                                                              //       highlightColor:
                                                              //           Colors
                                                              //               .white10,
                                                              //       child:
                                                              //           Container(
                                                              //         height: double
                                                              //             .infinity,
                                                              //         width: double
                                                              //             .infinity,
                                                              //         decoration: BoxDecoration(
                                                              //             color:
                                                              //                 boxColor,
                                                              //             borderRadius:
                                                              //                 BorderRadius.circular(
                                                              //                     10.0)),
                                                              //       ),
                                                              //     );
                                                              //   },
                                                              // ),
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .homeSections3[
                                                                    index]
                                                                .movieTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// Spanish Series

                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections4
                                      .isNotEmpty
                                  ? TextWidget(
                                      text: moviecontroller.homepagemovies!
                                          .videoStreamingApp.homeSections4Title)
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections4
                                      .isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .homeSections4
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .homeSections4[
                                                                index]
                                                            .movieId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .homeSections4[
                                                                      index]
                                                                  .moviePoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .homeSections4[
                                                                    index]
                                                                .movieTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),

// French Movies

                          const SizedBox(height: 20),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections5
                                      .isNotEmpty
                                  ? TextWidget(
                                      text: moviecontroller.homepagemovies!
                                          .videoStreamingApp.homeSections5Title)
                                  : const SizedBox(),
                          moviecontroller.isloadinghomepageApi.value
                              ? const SizedBox(height: 20)
                              : moviecontroller
                                      .homepagemovies!
                                      .videoStreamingApp
                                      .homeSections5
                                      .isNotEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: moviecontroller
                                              .homepagemovies!
                                              .videoStreamingApp
                                              .homeSections5
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              width: 182,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      Get.to(MovieDetail(
                                                        movieId: moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .homeSections5[
                                                                index]
                                                            .movieId,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          height: 155,
                                                          width: 182,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: moviecontroller
                                                                  .homepagemovies!
                                                                  .videoStreamingApp
                                                                  .homeSections5[
                                                                      index]
                                                                  .moviePoster,
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      boxColor,
                                                                  highlightColor:
                                                                      Colors
                                                                          .white10,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            boxColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            moviecontroller
                                                                .homepagemovies!
                                                                .videoStreamingApp
                                                                .homeSections5[
                                                                    index]
                                                                .movieTitle,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15.0)),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                            "1h 15min | Sci-Fi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize:
                                                                    12.0)),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),
                        ],
                      ),
                    ),
        );
      })),
    );
  }
}
