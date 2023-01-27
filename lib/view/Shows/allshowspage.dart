import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/controller/shows_controller.dart';
import 'package:testapp/widgets/custom_textfieldshow.dart';
import 'package:testapp/widgets/showcardWidget.dart';
import '../../constants.dart';
import 'dart:io' show Platform;

class AllshowsPage extends StatefulWidget {
  const AllshowsPage({super.key});

  @override
  State<AllshowsPage> createState() => _AllshowsPageState();
}

class _AllshowsPageState extends State<AllshowsPage> {
  List<String> countries = countriesArray.values.toList();

  // Current Year
  int totalyears = DateTime.now().year;
  bool isLoading = false;
  int total = 5;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _countriesscrollController = ScrollController();
  final ScrollController _yearsscrollController = ScrollController();
  final showsController _showsController = Get.find();
  StreamController<int> controller = StreamController<int>();

// Search Tags

  // Scroll Listener

  void addmorefuturemovies() {
    if (_showsController.showsdisplaylength.value <=
        _showsController.showstotallength.value - 2) {
      _showsController.showsdisplaylength.value =
          _showsController.showsdisplaylength.value + 2;
    } else {
      _showsController.showsdisplaylength.value =
          _showsController.showstotallength.value;
    }
  }

  void addmoremovies() {
    addmorefuturemovies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: Platform.isIOS
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            )
          : null,
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
                  const showtextfield(),

                  const SizedBox(height: 20),
                  const AutoSizeText(
                    "Shows",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),

                  const SizedBox(height: 20),

                  _showsController.isloading.value
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
                      : _showsController.assignString.isNotEmpty
                          ? Obx(() {
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
                                  children: List.generate(
                                      _showsController.showsdisplaylength.value,
                                      (index) {
                                    return ShowCardWidget(
                                      showId: _showsController
                                          .allshows!.videoStreamingApp
                                          .where((element) => element.showTitle!
                                              .toLowerCase()
                                              .contains(_showsController
                                                  .assignString.value
                                                  .toLowerCase()))
                                          .toList()[index]
                                          .showId!,
                                      title: _showsController
                                          .allshows!.videoStreamingApp
                                          .where((element) => element.showTitle!
                                              .toLowerCase()
                                              .contains(_showsController
                                                  .assignString.value
                                                  .toLowerCase()))
                                          .toList()[index]
                                          .showTitle!,
                                      imgurl: _showsController
                                          .allshows!.videoStreamingApp
                                          .where((element) => element.showTitle!
                                              .toLowerCase()
                                              .contains(_showsController
                                                  .assignString.value
                                                  .toLowerCase()))
                                          .toList()[index]
                                          .showPoster!,
                                    );
                                  }));
                            })
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
                                  children: List.generate(
                                      _showsController.showsdisplaylength.value,
                                      (index) {
                                    return ShowCardWidget(
                                      showId: _showsController.allshows!
                                          .videoStreamingApp[index].showId!,
                                      title: _showsController.allshows!
                                          .videoStreamingApp[index].showTitle!,
                                      imgurl: _showsController.allshows!
                                          .videoStreamingApp[index].showPoster!,
                                    );
                                  }));
                            }),
                ],
              ),
            ),
          );
        })),
      ),
    );
  }
}
