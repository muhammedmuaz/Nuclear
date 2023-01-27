import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/shows_controller.dart';
import 'package:testapp/videoPlayer/showvideo_player.dart';
import 'package:testapp/widgets/textWidget.dart';
import 'package:video_player/video_player.dart';

class SeasonDetailPage extends StatefulWidget {
  int seasonId;

  SeasonDetailPage({required this.seasonId, super.key});

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  final showsController showcontroller = Get.find();

  // final MovieController controller = Get.put(MovieController());

  // ignore: non_constant_identifier_names
  Future<void> fetch_season(String seasonId) async {
    print(seasonId);
    await showcontroller.Fetchseasondetail(seasonId);
  }

  @override
  void initState() {
    super.initState();
    fetch_season(widget.seasonId.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.1;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: backgroundColor,
        body: GetBuilder<showsController>(
          init: showcontroller,
          builder: ((controller) => controller.isloadingseasonDetail.value
              ? Container()
              : SingleChildScrollView(
                  child: Column(
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
                              imageUrl: controller
                                  .showdetail!.videoStreamingApp.showPoster,
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
                                        image:
                                            AssetImage("assets/errorImg.jpg"),
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      // Get.back();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: TextWidget(text: episodeName),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Flexible(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                controller
                                                    .showdetail!
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
                                                              .showdetail!
                                                              .videoStreamingApp
                                                              .genreList[index]
                                                              .genreName,
                                                          style:
                                                              GoogleFonts.inter(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                        ),
                                                        controller
                                                                    .showdetail!
                                                                    .videoStreamingApp
                                                                    .genreList
                                                                    .length >
                                                                1
                                                            ? const SizedBox(
                                                                width: 5,
                                                              )
                                                            : const SizedBox(),
                                                        controller
                                                                    .showdetail!
                                                                    .videoStreamingApp
                                                                    .genreList
                                                                    .length >
                                                                1
                                                            ? const CircleAvatar(
                                                                radius: 2,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ))),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Flexible(
                                        flex: 4,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // subtitleUrl = controller
                                                //     .seasondetail!
                                                //     .videoStreamingApp
                                                //     .first
                                                //     .episodeSubtitle
                                                //     .first
                                                //     .toString();
                                                // setState(() {});
                                                Get.to(ShowVideoPlayer(
                                                  videoPlayerController:
                                                      VideoPlayerController
                                                          .network(
                                                    episodevideoUrl,
                                                  ),
                                                  autoplay: true,
                                                  looping: true,
                                                  subtitleurl: subtitleUrl,
                                                ));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: devicewidth * 0.75,
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Colors.orangeAccent,
                                                          Colors.orange,
                                                        ],
                                                            stops: [
                                                          0.4,
                                                          0.6,
                                                        ],
                                                            begin: Alignment
                                                                .bottomLeft,
                                                            end: Alignment
                                                                .topRight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                    ),
                                                    AutoSizeText(
                                                      'Watch Full Episode',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            GestureDetector(
                                              onTap: () {
                                                Share.share(
                                                    'check out Nuclear Home Video $siteurl/series/${controller.showdetail!.videoStreamingApp.showName}+/${controller.showdetail!.videoStreamingApp.showId}');
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Icon(
                                                  Icons.share,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                controller.seasondetail!.videoStreamingApp.first
                                    .description,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.isrelatedActive.value = false;
                                    },
                                    child: SizedBox(
                                        height: 50,
                                        width: 150,
                                        child: ListTile(
                                          title: const AutoSizeText(
                                            "Episodes",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          subtitle:
                                              controller.isrelatedActive.value
                                                  ? null
                                                  : const Divider(
                                                      thickness: 2,
                                                      color: Colors.amber,
                                                    ),
                                        )),
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 20),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .seasondetail!.videoStreamingApp.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          print("This is Touching");
                                          episodeName = controller
                                              .seasondetail!
                                              .videoStreamingApp[index]
                                              .episodeTitle;
                                          episodevideoUrl = controller
                                              .seasondetail!
                                              .videoStreamingApp[index]
                                              .videoUrl;
                                          subtitleUrl = controller
                                              .seasondetail!
                                              .videoStreamingApp[index]
                                              .episodeSubtitle
                                              .first
                                              .toString();
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: const Color(0xff1C1A2E),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              bottom: 10.0,
                                                              left: 8.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl: controller
                                                                    .seasondetail!
                                                                    .videoStreamingApp[
                                                                        index]
                                                                    .episodeImage,
                                                                fit:
                                                                    BoxFit.fill,
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Container(
                                                                          height:
                                                                              double.infinity,
                                                                          width:
                                                                              double.infinity,
                                                                          decoration: BoxDecoration(
                                                                              color: boxColor,
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                              image: const DecorationImage(image: AssetImage("assets/errorImg.jpg"), fit: BoxFit.fill)),
                                                                        ),
                                                                placeholder: (context, url) => Shimmer
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
                                                                          width:
                                                                              double.infinity,
                                                                          decoration: BoxDecoration(
                                                                              color: boxColor,
                                                                              borderRadius: BorderRadius.circular(10.0)),
                                                                        ))),
                                                      ))),
                                              Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        AutoSizeText(
                                                          controller
                                                                      .seasondetail!
                                                                      .videoStreamingApp[
                                                                          index]
                                                                      .episodeTitle
                                                                      .length <
                                                                  30
                                                              ? controller
                                                                  .seasondetail!
                                                                  .videoStreamingApp[
                                                                      index]
                                                                  .episodeTitle
                                                              : controller
                                                                  .seasondetail!
                                                                  .videoStreamingApp[
                                                                      index]
                                                                  .episodeTitle
                                                                  .substring(
                                                                      0, 30),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Card(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      (index +
                                                                              1)
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const VerticalDivider(
                                                              color:
                                                                  Colors.white,
                                                              thickness: 1.0,
                                                              width: 4,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          margin:
                                                              const EdgeInsets.all(
                                                                  10.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          child: const Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        )),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
