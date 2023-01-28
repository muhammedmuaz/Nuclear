import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/view/moviedetailPage.dart';

class MovieCardWidget extends StatelessWidget {
  int movieId;
  String imgurl;
  String title;
  String releasedate;

  MovieCardWidget(
      {required this.movieId,
      required this.title,
      required this.imgurl,
      required this.releasedate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(MovieDetail(
              movieId: movieId,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ExtendedImage.network(
                    fit: BoxFit.fill,
                    // imageUrl:
                    imgurl,
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return Shimmer.fromColors(
                          baseColor: boxColor,
                          highlightColor: Colors.white10,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: AutoSizeText(
                  title.length < 30 ? title : title.substring(0, 30),
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 15.0)),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: AutoSizeText("release date: $releasedate",
                  style: GoogleFonts.inter(
                      color: Colors.grey.withOpacity(0.8), fontSize: 12.0)),
            )
          ],
        ));
  }
}
