import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/movie_controller.dart';
import 'package:testapp/videoPlayer/video_player.dart';
import 'package:testapp/widgets/EpisodeWidget.dart';
import 'package:testapp/widgets/textWidget.dart';
import 'package:video_player/video_player.dart';

import '../controller/bookmark_controller.dart';

class MovieDetail extends StatefulWidget {
  int movieId;

  MovieDetail({required this.movieId, super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieController controller = Get.find();
  final BookmarkController subscriptioncontroller =
      Get.put(BookmarkController());

  // ignore: non_constant_identifier_names
  Future<void> fetch_movie_detail() async {
    await controller.MovieDetails(widget.movieId.toString());
  }

  @override
  void initState() {
    super.initState();
    fetch_movie_detail();
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.1;
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Obx(() => controller.isloadingdetailmovies.value
              ? Container(
                  height: deviceheight,
                  width: devicewidth,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: isActiveColor,
                        ),
                      ]),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: deviceheight * 0.5,
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: controller.movie_detail_Model!
                                .videoStreamingApp.movieImage,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            errorWidget: (context, url, error) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: boxColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/errorImg.jpg"),
                                      fit: BoxFit.fill)),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: boxColor,
                              highlightColor: Colors.white10,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: boxColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              // loadingBuilder: (context, child, loadingProgress) {
                              // if (loadingProgress == null) return child;
                              // return Shimmer.fromColors(
                              //   baseColor: boxColor,
                              //   highlightColor: Colors.white10,
                              //   child: Container(
                              //     height: double.infinity,
                              //     width: double.infinity,
                              //     decoration: BoxDecoration(
                              //         color: boxColor,
                              //         borderRadius:
                              //             BorderRadius.circular(10.0)),
                              //   ),
                            ),
                            // },
                            // errorBuilder: (context, error, stackTrace) {
                            // return const Center(
                            //   child: AutoSizeText(
                            //     "Error loading Image",
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // );
                            // },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color: Colors.grey.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Share.share(
                                        'check out Nuclear Home Video ${mainsiteurl}single-movie-one/${controller.movie_detail_Model!.videoStreamingApp.movieId}');
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            // child:
                            //  BackdropFilter(
                            //   filter: ImageFilter.blur(
                            //       sigmaX: 0, sigmaY: 0),

                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                              child: Container(
                                alignment: Alignment.center,
                                height: deviceheight * 0.18,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                  color: backgroundColor.withOpacity(0.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        text: controller.movie_detail_Model!
                                            .videoStreamingApp.movieTitle),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            controller
                                                .movie_detail_Model!
                                                .videoStreamingApp
                                                .genreList
                                                .length,
                                            (index) => Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    AutoSizeText(
                                                      controller
                                                          .movie_detail_Model!
                                                          .videoStreamingApp
                                                          .genreList[index]
                                                          .genreName,
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                    controller
                                                                .movie_detail_Model!
                                                                .videoStreamingApp
                                                                .genreList
                                                                .length >
                                                            1
                                                        ? const SizedBox(
                                                            width: 5,
                                                          )
                                                        : const SizedBox(),
                                                    controller
                                                                .movie_detail_Model!
                                                                .videoStreamingApp
                                                                .genreList
                                                                .length >
                                                            1
                                                        ? const CircleAvatar(
                                                            radius: 2,
                                                            backgroundColor:
                                                                Colors.white,
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                ))

                                        // [

                                        // AutoSizeText(
                                        //   "Action",
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 14),
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // CircleAvatar(
                                        //   radius: 2,
                                        //   backgroundColor: Colors.white,
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // AutoSizeText(
                                        //   "Thriller",
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 14),
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // CircleAvatar(
                                        //   radius: 2,
                                        //   backgroundColor: Colors.white,
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // AutoSizeText(
                                        //   "Drama",
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 14),
                                        // ),
                                        // SizedBox(
                                        //   width: 5,
                                        // ),
                                        // ],
                                        ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await controller.MoviePlay(
                                                controller.movie_detail_Model!
                                                    .videoStreamingApp.videoUrl,
                                                controller
                                                    .movie_detail_Model!
                                                    .videoStreamingApp
                                                    .moviesSubtitle
                                                    .first);
                                            Get.to(VideoItem(
                                              videoPlayerController:
                                                  VideoPlayerController.network(
                                                controller.movieurl.value,
                                              ),
                                              autoplay: true,
                                              looping: true,
                                              ismovie: true,
                                            ));
                                          },
                                          child: Container(
                                            // alignment: Alignment.center,
                                            height: 40,
                                            width: devicewidth * 0.65,
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.orangeAccent,
                                                      Colors.orange,
                                                    ],
                                                    stops: [
                                                      0.4,
                                                      0.6,
                                                    ],
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.topRight),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                AutoSizeText(
                                                  'Watch Movie',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),

                                        // subscriptioncontroller.bookmarkModel

                                        subscriptioncontroller
                                                .isAddingbookmark.value
                                            ? Container(
                                                height: 40,
                                                width: 40,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: isActiveColor,
                                                ))
                                            : subscriptioncontroller
                                                        .bookmarkModel !=
                                                    null
                                                ? subscriptioncontroller
                                                        .bookmarkModel!
                                                        .videoStreamingApp!
                                                        .any(
                                                    (element) =>
                                                        element!.movieId ==
                                                        controller
                                                            .movie_detail_Model!
                                                            .videoStreamingApp
                                                            .movieId,
                                                  )
                                                    ? Container(
                                                        width: 40,
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .orangeAccent,
                                                                    Colors
                                                                        .orange,
                                                                  ],
                                                                  stops: [
                                                                    0.4,
                                                                    0.6,
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomLeft,
                                                                  end: Alignment
                                                                      .topRight,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                        child: const Icon(
                                                          Icons
                                                              .bookmark_add_outlined,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          subscriptioncontroller
                                                              .Addbookmark(
                                                                  "movie",
                                                                  controller
                                                                      .movie_detail_Model!
                                                                      .videoStreamingApp
                                                                      .movieId);
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Icon(
                                                            Icons
                                                                .bookmark_add_outlined,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                : GestureDetector(
                                                    onTap: () {
                                                      subscriptioncontroller
                                                          .Addbookmark(
                                                              "movie",
                                                              controller
                                                                  .movie_detail_Model!
                                                                  .videoStreamingApp
                                                                  .movieId);
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Icon(
                                                        Icons
                                                            .bookmark_add_outlined,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                        const SizedBox(width: 8.0),
                                        GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'check out Nuclear Home Video ${mainsiteurl}single-movie-one/${controller.movie_detail_Model!.videoStreamingApp.movieId}');
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const AutoSizeText("Story Line",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 10,
                          ),
                          AutoSizeText(
                              controller.movie_detail_Model!.videoStreamingApp
                                  .description,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          // const AutoSizeText("More Info",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w500)),
                          // const SizedBox(
                          //   height: 10,
                          // ),

                          // SizedBox(
                          //   height: deviceheight * 0.1,
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Expanded(
                          //           child: ListView.builder(
                          //               scrollDirection: Axis.horizontal,
                          //               itemCount: peopleList.length,
                          //               itemBuilder:
                          //                   (BuildContext context, int index) {
                          //                 return SizedBox(
                          //                   width: devicewidth * 0.55,
                          //                   child: ListTile(
                          //                     leading: CircleAvatar(
                          //                       radius: 30,
                          //                       backgroundImage: AssetImage(
                          //                           peopleList[index].ImgUrl),
                          //                     ),
                          //                     title: AutoSizeText(
                          //                       peopleList[index].title,
                          //                       style: const TextStyle(
                          //                           color: Colors.white,
                          //                           fontSize: 16,
                          //                           fontWeight:
                          //                               FontWeight.w300),
                          //                     ),
                          //                     subtitle: AutoSizeText(
                          //                       peopleList[index].subtitle,
                          //                       style: const TextStyle(
                          //                           color: Colors.white,
                          //                           fontSize: 16,
                          //                           fontWeight:
                          //                               FontWeight.w500),
                          //                     ),
                          //                   ),
                          //                 );
                          //               }))
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: ListTile(
                                    title: AutoSizeText(
                                      "Related Movies",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Divider(
                                      thickness: 2,
                                      color: Colors.amber,
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.movie_detail_Model!
                                  .videoStreamingApp.relatedMovies.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await controller.MovieDetails(controller
                                          .movie_detail_Model!
                                          .videoStreamingApp
                                          .relatedMovies[index]
                                          .movieId
                                          .toString());
                                    },
                                    child: EpisodeWidget(
                                      episodeTitle: controller
                                          .movie_detail_Model!
                                          .videoStreamingApp
                                          .relatedMovies[index]
                                          .movieTitle,
                                      EpisodeNumber: controller
                                          .movie_detail_Model!
                                          .videoStreamingApp
                                          .relatedMovies[index]
                                          .movieDuration
                                          .toString(),
                                      Imgurl: controller
                                          .movie_detail_Model!
                                          .videoStreamingApp
                                          .relatedMovies[index]
                                          .moviePoster,
                                      movieId: controller
                                          .movie_detail_Model!
                                          .videoStreamingApp
                                          .relatedMovies[index]
                                          .movieId,
                                    ),
                                  ),
                                );
                              }),

                          // for (int i = 0;
                          //     i <
                          //         controller.movie_detail_Model!
                          //             .videoStreamingApp.relatedMovies.length;
                          //     i++)
                          //   Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(vertical: 10.0),
                          //     child: EpisodeWidget(
                          //       episodeTitle: controller
                          //           .movie_detail_Model!
                          //           .videoStreamingApp
                          //           .relatedMovies[i]
                          //           .movieTitle,
                          //       EpisodeNumber: controller
                          //           .movie_detail_Model!
                          //           .videoStreamingApp
                          //           .relatedMovies[i]
                          //           .movieDuration
                          //           .toString(),
                          //       Imgurl: controller
                          //           .movie_detail_Model!
                          //           .videoStreamingApp
                          //           .relatedMovies[i]
                          //           .moviePoster,
                          //       movieId: controller.movie_detail_Model!
                          //           .videoStreamingApp.relatedMovies[i].movieId,
                          //     ),
                          //   ),

                          // EpisodeWidget(
                          //   episodeTitle: 'Matt Max: Fury Way',
                          //   EpisodeNumber: 'Episode 1',
                          //   Imgurl: 'assets/download7.png',
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // EpisodeWidget(
                          //   episodeTitle: 'Matt Max: Fury Way',
                          //   EpisodeNumber: 'Episode 2',
                          //   Imgurl: 'assets/download7.png',
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // EpisodeWidget(
                          //   episodeTitle: 'Matt Max: Fury Way',
                          //   EpisodeNumber: 'Episode 3',
                          //   Imgurl: 'assets/download7.png',
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // EpisodeWidget(
                          //   episodeTitle: 'Matt Max: Fury Way',
                          //   EpisodeNumber: 'Episode 4',
                          //   Imgurl: 'assets/download7.png',
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // EpisodeWidget(
                          //   episodeTitle: 'Matt Max: Fury Way',
                          //   EpisodeNumber: 'Episode 5',
                          //   Imgurl: 'assets/download7.png',
                          // ),
                        ],
                      ),
                    )
                  ],
                )),
        ),
      )),
    );
  }
}




// Image.network(
//                                         i.moviePoster,
//                                         height: double.infinity,
//                                         width: double.infinity,
//                                         fit: BoxFit.fill,
//                                         loadingBuilder:
//                                             (context, child, loadingProgress) {
//                                           if (loadingProgress == null)
//                                             return child;
//                                           return Shimmer.fromColors(
//                                             baseColor: boxColor,
//                                             highlightColor: Colors.white10,
//                                             child: Container(
//                                               height: double.infinity,
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                   color: boxColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10.0)),
//                                             ),
//                                           )

                                              // Center(
                                              //   child: CircularProgressIndicator(
                                              //     color: Colors.white,
                                              //     value: loadingProgress
                                              //                 .expectedTotalBytes !=
                                              //             null
                                              //         ? loadingProgress
                                              //                 .cumulativeBytesLoaded /
                                              //             loadingProgress
                                              //                 .expectedTotalBytes!
                                              //         : null,
                                              //   ),
                                              // )

                                      //         ;
                                      //   },
                                      // ),