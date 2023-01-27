import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/view/StartScreens/paymentsurvery_screen.dart';
import 'package:testapp/view/StartScreens/signin.dart';

// class StartSlider extends StatelessWidget {
//   const StartSlider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double deviceheight = MediaQuery.of(context).size.height;
//     double devicewidth = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         body: CarouselSlider(
//           options: CarouselOptions(
//             height: MediaQuery.of(context).size.height,
//             // enlargeCenterPage: true,
//             autoPlay: true,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             viewportFraction: 1,
//           ),
//           items: [
//             "https://i.pinimg.com/originals/da/bf/1a/dabf1ab24a2dd21ef6262520b0f5597d.jpg",
//             "https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/pushpa--the-rise-et00129538-08-12-2021-01-21-46.jpg",
//           ].map((i) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return GestureDetector(
//                     // onTap: () => Get.to(MovieDetail(
//                     //   movieId: i.movieId,
//                     // )),
//                     child: Container(
//                   width: double.infinity,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
//                   decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                           image: NetworkImage(i),
//                           onError: ((exception, stackTrace) =>
//                               print("Error Here")),
//                           fit: BoxFit.fill)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Expanded(
//                           child: AutoSizeText(
//                         "Nuclear App",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 28),
//                       )),
//                       Expanded(
//                           child: Container(
//                         width: double.infinity,
//                         // foregroundDecoration: BoxDecoration(
//                         //   gradient: LinearGradient(
//                         //     colors: [
//                         //       Colors.black.withOpacity(0.7),
//                         //       Colors.transparent,
//                         //     ],
//                         //     begin: Alignment.bottomCenter,
//                         //     end: Alignment.topCenter,
//                         //     stops: const [0.1, 1],
//                         //   ),
//                         // ),
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const AutoSizeText(
//       "Nuclear App",
//       style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w800,
//           fontSize: 34),
//     ),
//     const SizedBox(height: 10),
//     Container(
//       width: devicewidth * 0.35,
//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 12,
//             width: 12,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white),
//           ),
//           Container(
//             height: 12,
//             width: 12,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey),
//           ),
//           Container(
//             height: 12,
//             width: 12,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey),
//           ),
//           Container(
//             height: 12,
//             width: 12,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey),
//           ),
//           Container(
//             height: 12,
//             width: 12,
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey),
//           ),
//         ],
//       ),
//     ),
// const SizedBox(height: 10),
// const AutoSizeText(
//   "Try it free.",
//   style:
//       TextStyle(color: Colors.white, fontSize: 14),
//   textAlign: TextAlign.center,
// ),
// const AutoSizeText(
//   "Plans start at \$4.99/month. Cancel anytime.",
//   style:
//       TextStyle(color: Colors.white, fontSize: 14),
//   textAlign: TextAlign.center,
// ),
// const SizedBox(height: 20),

// // First Button

// GestureDetector(
//   onTap: () => {},
//   child: Container(
//     alignment: Alignment.center,
//     height: 50,
//     width: double.infinity,
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//           colors: [
//             Colors.orangeAccent,
//             Colors.orange,
//           ],
//           stops: [
//             0.4,
//             0.6,
//           ],
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight),
//     ),
//     child: const Text(
//       'SIGN UP FOR NUCLEAR',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w600),
//     ),
//   ),
// ),
// const SizedBox(height: 10),

// //                             GestureDetector(
// //                               onTap: () => {},
// //                               child: Container(
// //                                 alignment: Alignment.center,
// //                                 height: 50,
// //                                 width: double.infinity,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.transparent,
// //                                     border: Border.all(
// //                                         color: Colors.black, width: 2)),
// //                                 child: const Text(
// //                                   'WATCH FREE EPISODES',
// //                                   textAlign: TextAlign.center,
// //                                   style: TextStyle(
// //                                       color: Colors.white,
// //                                       fontSize: 18,
// //                                       fontWeight: FontWeight.w600),
// //                                 ),
// //                               ),
// //                             ),

// //                             const SizedBox(height: 10),

// // Second Button

// GestureDetector(
//   onTap: () => {},
//   child: Container(
//     alignment: Alignment.center,
//     height: 50,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: Colors.transparent,
//         border: Border.all(
//             color: Colors.black, width: 2)),
//     child: const Text(
//       'SIGN IN',
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w600),
//     ),
//   ),
// ),
//                           ],
//                         ),
//                       ))
//                     ],
//                   ),
//                 ));
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

class StartSlider extends StatefulWidget {
  const StartSlider({super.key});

  @override
  State<StartSlider> createState() => _StartSliderState();
}

class _StartSliderState extends State<StartSlider> {
  int page_no = 0;
  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => await Get.defaultDialog(
          title: "Alert",
          content: Text(
            "Are you you want to exit",
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          confirmTextColor: Colors.white,
          cancelTextColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          backgroundColor: backgroundColor,
          buttonColor: Colors.red,
          textConfirm: "Yes",
          textCancel: "No",
          onConfirm: () => SystemNavigator.pop(),
          onCancel: () => false),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      page_no = index;
                    });
                  }),
              items: [
                "assets/cover.jpg",
                "assets/cover3.jpg",
                "assets/cover6.jpg",
                "assets/cover5.jpg",
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: deviceheight,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(i),
                              onError: ((exception, stackTrace) =>
                                  print("Error Here")),
                              fit: BoxFit.fill)),
                    );
                  },
                );
              }).toList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                    child: AutoSizeText(
                  "Nuclear App",
                  style: TextStyle(
                      color: Colors.transparent,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                )),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.1, 1],
                      )),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText(
                              "Nuclear App",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 34),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: devicewidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int x = 0; x < 4; x++)
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: page_no == x
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            const AutoSizeText(
                              "Try it free.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const AutoSizeText(
                              "Plans start at \$6.99/month. Cancel anytime.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 25),
                            GestureDetector(
                              onTap: () => Get.to(const PaymentSurverScreen()),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.orangeAccent,
                                        Colors.orange,
                                      ],
                                      stops: [
                                        0.4,
                                        0.6,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                ),
                                child: const Text(
                                  'SIGN UP FOR NUCLEAR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => Get.to(const SignInScreen()),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(
                                  //     color: Colors.black, width: 2)
                                ),
                                child: const Text(
                                  'SIGN IN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ])),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
