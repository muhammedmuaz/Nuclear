import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/view/Shows/allshowspage.dart';
import 'package:testapp/view/Shows/showdetailPage.dart';
import '../controller/movie_controller.dart';
import '../controller/shows_controller.dart';
import '../widgets/textWidget.dart';

class TVshow extends StatelessWidget {
  const TVshow({required Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MovieController moviecontroller = Get.find();
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    final showsController _showsController = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: moviecontroller.homePage_networkError.value
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [TextWidget(text: "Network Error")],
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 20.0),
                    child: SafeArea(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText("TV Shows",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500)

                                // TextStyle(
                                // color: Colors.white,
                                // fontSize: 24,
                                // fontWeight: FontWeight.w500),
                                ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Now Playing",
                                style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(const AllshowsPage()),
                              child: AutoSizeText(
                                "See all",
                                style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        moviecontroller.isloadinghomepageApi.value
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  height: 180.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 0.8,
                                ),
                                items: [1, 2, 3].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                            : moviecontroller.homepagemovies!.videoStreamingApp
                                    .latestShows.isNotEmpty
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
                                          _showsController
                                              .showpagesliderpoint(index);
                                        })),
                                    items: moviecontroller.homepagemovies!
                                        .videoStreamingApp.latestShows
                                        .map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: (() {
                                              Get.to(ShowDetailPage(
                                                  showId: i.showId));
                                            }),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: boxColor,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            i.showPoster),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  )
                                : Container(),
                        const SizedBox(height: 10),

                        // Carousel Dots

                        Obx(
                          () => moviecontroller.isloadinghomepageApi.value
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int x = 0;
                                        x <
                                            moviecontroller
                                                .homepagemovies!
                                                .videoStreamingApp
                                                .latestShows
                                                .length;
                                        x++)
                                      Container(
                                        height: 8,
                                        width: 8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _showsController
                                                        .showpagesliderpoint
                                                        .value ==
                                                    x
                                                ? Colors.white
                                                : Colors.grey),
                                      ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        moviecontroller.isloadinghomepageApi.value
                            ? const SizedBox(height: 20)
                            : moviecontroller.homepagemovies!.videoStreamingApp
                                    .popularShows.isNotEmpty
                                ? AutoSizeText(
                                    "Popular Shows",
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 18),
                                  )
                                : const SizedBox(),

// Popular Shows list
                        moviecontroller.isloadinghomepageApi.value
                            ? const SizedBox(height: 20)
                            : moviecontroller.homepagemovies!.videoStreamingApp
                                    .popularShows.isNotEmpty
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
                                            height: 148,
                                            width: 223,
                                            margin: const EdgeInsets.symmetric(
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
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 148,
                                                      width: 223,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: [
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
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Container(
                                                                height: 32.80,
                                                                width: 32.80,
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7,
                                                                        bottom:
                                                                            7),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.1)),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 23.95,
                                                              width: 23.95,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 15,
                                                                      bottom:
                                                                          15),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        15.95,
                                                                    width:
                                                                        15.95,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/tile.png",
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    AutoSizeText(
                                                        moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .popularShows[index]
                                                            .showTitle,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.0)),
                                                  ],
                                                )),
                                          );
                                        }),
                                  )
                                : const SizedBox(),

// Latest Shows
                        moviecontroller.isloadinghomepageApi.value
                            ? const SizedBox(height: 20)
                            : moviecontroller.homepagemovies!.videoStreamingApp
                                    .latestShows.isNotEmpty
                                ? AutoSizeText(
                                    "Latest Shows",
                                    style: GoogleFonts.inter(
                                        color: Colors.white, fontSize: 18),
                                  )
                                : const SizedBox(),

                        moviecontroller.isloadinghomepageApi.value
                            ? const SizedBox(height: 20)
                            : moviecontroller.homepagemovies!.videoStreamingApp
                                    .latestShows.isNotEmpty
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
                                            height: 148,
                                            width: 223,
                                            margin: const EdgeInsets.symmetric(
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
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 148,
                                                      width: 223,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          ClipRRect(
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
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              height: 32.80,
                                                              width: 32.80,
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 7,
                                                                      bottom:
                                                                          7),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.1)),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 23.95,
                                                            width: 23.95,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15,
                                                                    bottom: 15),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  height: 15.95,
                                                                  width: 15.95,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/tile.png",
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    AutoSizeText(
                                                        moviecontroller
                                                            .homepagemovies!
                                                            .videoStreamingApp
                                                            .latestShows[index]
                                                            .showTitle,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.0)),
                                                  ],
                                                )),
                                          );
                                        }),
                                  )
                                : const SizedBox(),
                      ],
                    )),
                  ),
                ),
        );
      }),
    );
  }
}
