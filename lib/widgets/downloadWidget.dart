import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testapp/constants.dart';

class DownloadWidget extends StatelessWidget {
  String ImgUrl;
  String Title;
  String Time;
  double Ratings;
  double Downloadvalue;
  bool isdownloaded;
  DownloadWidget(
      {required this.ImgUrl,
      required this.Ratings,
      required this.Time,
      required this.Title,
      required this.Downloadvalue,
      this.isdownloaded = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: double.infinity,
      child: Row(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImgUrl), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15.0)),
              )),
          Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      Title,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: Colors.grey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              AutoSizeText(
                                Ratings.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),

                        AutoSizeText(
                          Time,
                          style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        ),

                        const SizedBox(
                          width: 3,
                        ),

                        // Container(
                        //   height: 10,
                        //   child: VerticalDivider(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     thickness: 1.0,
                        //     width: 4,
                        //   ),
                        // ),

                        // const SizedBox(
                        //   width: 3,
                        // ),

                        // AutoSizeText(
                        //   "Actions",
                        //   style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        // ),

                        // AutoSizeText("Action", style: TextStyle(color: Colors.grey.withOpacity(0.5)),)

                        // Container(
                        //   height: 25,
                        //   width: 40,
                        //   padding: EdgeInsets.all(8.0),
                        //   alignment: Alignment.center,
                        //   color: Colors.grey,
                        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                        //   child:
                        // )
                      ],
                    )
                  ],
                ),
              )),
          Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isdownloaded
                      ? Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: boxColor,
                              // image: DecorationImage(
                              //     image: AssetImage("assets/download.png"),
                              //     fit: BoxFit.contain,
                              //     scale: 0.1),
                              borderRadius: BorderRadius.circular(20.0)),
                          // color: Colors.amber,
                          child: Image.asset("assets/downloadedicon.png"))
                      : Container(
                          margin: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/download.png"),
                                  fit: BoxFit.contain,
                                  scale: 0.1),
                              borderRadius: BorderRadius.circular(10.0)),
                          // color: Colors.amber,
                          child: CircularProgressIndicator(
                            value: Downloadvalue,
                            strokeWidth: 2,
                          )),
                ],
              ))
        ],
      ),
    );
  }
}
