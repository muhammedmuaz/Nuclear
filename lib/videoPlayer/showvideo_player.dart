import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/controller/movie_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:subtitle/subtitle.dart' as sub;
import 'dart:io' show Platform;
import '../constants.dart';

class ShowVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String subtitleurl;
  final bool looping;
  final bool autoplay;

  const ShowVideoPlayer(
      {required this.videoPlayerController,
      required this.autoplay,
      required this.looping,
      required this.subtitleurl,
      super.key});

  @override
  State<ShowVideoPlayer> createState() => _ShowVideoPlayerState();
}

MovieController moviecontroller = Get.find();

// This is For Subtitle
var url = Uri.parse(
    'https://nuclearportal.webtestdemo.com/cxm-vtt-text-tracks/${subtitleUrl}');
var controller = sub.SubtitleController(
  provider: sub.SubtitleProvider.fromNetwork(url),
);

class _ShowVideoPlayerState extends State<ShowVideoPlayer> {
  ChewieController? _chewieController;

  bool isloading = true;

  List<Subtitle> subtitledata2 = [];

  Future<bool> getsubtitle() async {
    sub.SubtitleProvider provider = sub.NetworkSubtitle(url);
    sub.SubtitleObject object = await provider.getSubtitle();
    sub.SubtitleParser parser = sub.SubtitleParser(object);

    // ignore: non_constant_identifier_names
    List<sub.Subtitle> SubtitleFromSubtitle =
        parser.parsing(shouldNormalizeText: true);

    for (var i = 0; i < SubtitleFromSubtitle.length; i++) {
      subtitledata2.add(Subtitle(
          index: SubtitleFromSubtitle[i].index,
          start: SubtitleFromSubtitle[i].start,
          end: SubtitleFromSubtitle[i].end,
          text: SubtitleFromSubtitle[i].data));
    }

    setState(() {});
    return true;
  }

  // ignore: non_constant_identifier_names
  Future<void> run_getsubtitle() async {
    await getsubtitle().then((value) => {
          _chewieController = ChewieController(
            videoPlayerController: widget.videoPlayerController,
            additionalOptions: (context) {
              return <OptionItem>[
                OptionItem(
                  onTap: () {},
                  iconData: Icons.chat,
                  title: 'Subtitle',
                ),
              ];
            },
            aspectRatio: 16 / 9,
            autoInitialize: true,
            autoPlay: true,
            subtitle: Subtitles(subtitledata2),
            subtitleBuilder: (context, subtitle) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        });
    isloading = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    run_getsubtitle();
    widget.videoPlayerController.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
    _chewieController!.pause();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: Platform.isIOS
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                )
              : null,
          body: isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Chewie(controller: _chewieController!)),
    );
  }
}
