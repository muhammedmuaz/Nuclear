import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/movie_controller.dart';
import '../widgets/movie_card.dart';
import '../widgets/textWidget.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final MovieController _movieController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextWidget(text: "History"),
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
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: _movieController.isloadinghomepageApi.value
                ? const Center(child: CircularProgressIndicator())
                : GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 20.0,
                        crossAxisCount: 2,
                        childAspectRatio: 100 / 140),
                    children: List.generate(
                        _movieController.homepagemovies!.videoStreamingApp
                            .recentlyWatched.length, (index) {
                      return MovieCardWidget(
                        movieId: _movieController.homepagemovies!
                            .videoStreamingApp.recentlyWatched[index].videoId,
                        title: _movieController.homepagemovies!
                            .videoStreamingApp.recentlyWatched[index].movieName,
                        imgurl: _movieController.homepagemovies!.videoStreamingApp
                            .recentlyWatched[index].videoThumbImage,
                        releasedate: '',
                      );
                    }))),
      ),
    );
  }
}
