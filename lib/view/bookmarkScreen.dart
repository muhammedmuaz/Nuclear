import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/bookmark_controller.dart';
import 'package:testapp/widgets/textWidget.dart';

import '../widgets/movie_card.dart';

class BookmarkScreen extends StatefulWidget {
  BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final BookmarkController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.Fetchbookmarklist();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: TextWidget(text: "Bookmark"),
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leadingWidth: 100,
          toolbarHeight: 100,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: controller.isemptyBookmark.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "No Bookmarks Added Yet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: controller.isloading.value
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            )))
                        : GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 20.0,
                                    crossAxisCount: 2,
                                    childAspectRatio: 100 / 140),
                            children: List.generate(
                                controller.bookmarkModel!.videoStreamingApp!
                                    .length, (index) {
                              return MovieCardWidget(
                                movieId: controller.bookmarkModel!
                                    .videoStreamingApp![index]!.movieId!,
                                title: controller.bookmarkModel!
                                    .videoStreamingApp![index]!.movieTitle!,
                                imgurl: controller.bookmarkModel!
                                    .videoStreamingApp![index]!.moviePoster!,
                                releasedate: controller.bookmarkModel!
                                    .videoStreamingApp![index]!.releaseDate!,
                              );
                            }))),
              ),
      );
    });
  }
}
