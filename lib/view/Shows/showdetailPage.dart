import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/shows_controller.dart';
import 'package:testapp/view/Shows/SeasonDetailPage.dart';
import 'package:testapp/widgets/textWidget.dart';
import '../../widgets/showEpisodeWidget.dart';

class ShowDetailPage extends StatefulWidget {
  int showId;

  ShowDetailPage({required this.showId, super.key});

  @override
  State<ShowDetailPage> createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  final showsController showcontroller = Get.find();

  // ignore: non_constant_identifier_names
  Future<void> fetch_movie_detail(String showId) async {
    // print(widget.showId.toString());
    await showcontroller.Fetchshowdetail(showId);
  }

  @override
  void initState() {
    super.initState();
    fetch_movie_detail(widget.showId.toString());
    showcontroller.update();
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
                    child: GetBuilder<showsController>(
          init: showcontroller,
          builder: ((controller) => controller.isloadingdetailPage.value
              ? Container(
                  height: deviceheight,
                  width: devicewidth,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: isActiveColor,
                    ),
                  ),
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
                            ),
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
                                        'check out Nuclear Home Video $mainsiteurl');
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
                                height: deviceheight * 0.15,
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
                                        text: controller.showdetail!
                                            .videoStreamingApp.showName),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          '${controller.showdetail!.videoStreamingApp.seasonList.length} Seasons | ${controller.showdetail!.videoStreamingApp.showLang} |',
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        Row(
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
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
                              controller.showdetail!.videoStreamingApp.showInfo,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isrelatedActive.value = false;
                                    },
                                    child: SizedBox(
                                        height: 50,
                                        // width: 150,
                                        child: ListTile(
                                          title: const AutoSizeText(
                                            "Seasons",
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
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isrelatedActive.value = true;
                                    },
                                    child: SizedBox(
                                        height: 50,
                                        width: 170,
                                        child: ListTile(
                                            title: const AutoSizeText(
                                              "Related Shows",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle:
                                                controller.isrelatedActive.value
                                                    ? const Divider(
                                                        thickness: 2,
                                                        color: Colors.amber,
                                                      )
                                                    : null)),
                                  ),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(height: 20),
                          Obx(() => controller.isrelatedActive.value
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.showdetail!
                                      .videoStreamingApp.relatedShows.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            controller
                                                .isloadingdetailPage(true);
                                            setState(() {});
                                            await fetch_movie_detail(controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .relatedShows[index]
                                                .showId
                                                .toString());
                                            controller
                                                .isloadingdetailPage(false);
                                            setState(() {});
                                          },
                                          child: SeasonWidget(
                                            seasonTitle: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .relatedShows[index]
                                                .showTitle,
                                            Imgurl: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .relatedShows[index]
                                                .showPoster,
                                            seasonId: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .relatedShows[index]
                                                .showId,
                                          ),
                                        ),
                                      );
                                    }
                                  })
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.showdetail!
                                      .videoStreamingApp.seasonList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(SeasonDetailPage(
                                                seasonId: controller
                                                    .showdetail!
                                                    .videoStreamingApp
                                                    .seasonList[index]
                                                    .seasonId));
                                          },
                                          child: SeasonWidget(
                                            seasonTitle: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .seasonList[index]
                                                .seasonName,
                                            Imgurl: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .seasonList[index]
                                                .seasonPoster,
                                            seasonId: controller
                                                .showdetail!
                                                .videoStreamingApp
                                                .seasonList[index]
                                                .seasonId,
                                          ),
                                        ),
                                      );
                                    }
                                  })),
                        ],
                      ),
                    )
                  ],
                )),
        )))));
  }
}
