import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class SeasonWidget extends StatelessWidget {
  String seasonTitle;
  int seasonId;
  String Imgurl;

  SeasonWidget(
      {required this.seasonId,
      required this.seasonTitle,
      required this.Imgurl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xff1C1A2E),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  margin:
                      const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                        imageUrl: Imgurl,
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
                            ))),
                  ))),
          Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      seasonTitle.length < 30
                          ? seasonTitle
                          : seasonTitle.substring(0, 30),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // const VerticalDivider(
                        //   color: Colors.white,
                        //   thickness: 1.0,
                        //   width: 4,
                        // ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
