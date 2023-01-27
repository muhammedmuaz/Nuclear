// import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:testapp/controller/movie_controller.dart';
// import 'package:testapp/videoPlayer/video_player.dart';
// import 'package:testapp/widgets/movie_card.dart';
// import '../constants.dart';
// import '../widgets/custom_textfield.dart';

// class Explore extends StatefulWidget {
//   const Explore({super.key});

//   @override
//   State<Explore> createState() => _ExploreState();
// }

// class _ExploreState extends State<Explore> {
//   List<String> countries = countriesArray.values.toList();

//   // Current Year
//   int totalyears = DateTime.now().year;
//   bool isLoading = false;
//   int total = 5;
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final ScrollController _countriesscrollController = ScrollController();
//   final ScrollController _yearsscrollController = ScrollController();
//   final MovieController _movieController = Get.find();
//   StreamController<int> searchcontroller = StreamController<int>();
//   Stream<int> get _stream => searchcontroller.stream;
// // Search Tags

//   // bool issearchTagSelected = false;

//   // Scroll Listener

//   @override
//   Widget build(BuildContext context) {
//     double deviceheight = MediaQuery.of(context).size.height;
//     double devicewidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Container(
//         padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
//         child: SafeArea(child: Obx(() {
//           return NotificationListener(
//             onNotification: (t) {
//               if (t is ScrollEndNotification) {
//                 if (_scrollController.position.maxScrollExtent ==
//                     _scrollController.position.pixels) {
//                   // _movieController.fetchmoremovies();
//                 }
//                 if (_countriesscrollController.position.maxScrollExtent ==
//                     _countriesscrollController.position.pixels) {
//                   _movieController.fetchmorecountries(countries.length);
//                 }
//                 if (_yearsscrollController.position.maxScrollExtent ==
//                     _yearsscrollController.position.pixels) {
//                   _movieController.fetchmoreyears(totalyears);
//                 }
//               }
//               return true;
//             },
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // Text Field
//                   CustomTextField(
//                     isgenrePage: false,
//                     ishomePage: false,
//                   ),

//                   const SizedBox(height: 20),

//                   // Search by Tags
//                   const Text(
//                     "Search by tags",
//                     style: TextStyle(color: Colors.white, fontSize: 22),
//                   ),

//                   const SizedBox(height: 20),

//                   // Country Tag
//                   Obx(() {
//                     return SizedBox(
//                       height: 35,
//                       child: Row(
//                         children: [
//                           moviecontroller.isloading.value
//                               ? Expanded(
//                                   child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: 4,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return Shimmer.fromColors(
//                                           baseColor: boxColor,
//                                           highlightColor: Colors.white10,
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: boxColor),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                               : Expanded(
//                                   child: ListView.builder(
//                                       controller: _countriesscrollController,
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: _movieController
//                                           .countrieslength.value,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return InkWell(
//                                           onTap: () {
//                                             _movieController.issearchTagSelected
//                                                 .value = true;
//                                             if (index != 0) {
//                                               _movieController
//                                                   .allcountriesisActive
//                                                   .value = false;
//                                               if (_movieController
//                                                   .countryisactive
//                                                   .contains(index)) {
//                                                 int valueIndex =
//                                                     _movieController
//                                                         .countryisactive
//                                                         .indexOf(index);
//                                                 _movieController.countryisactive
//                                                     .removeAt(valueIndex);
//                                                 if (_movieController
//                                                         .country.length ==
//                                                     1) {
//                                                   if (_movieController.genreIdisactive.isEmpty &&
//                                                       _movieController
//                                                           .countryisactive
//                                                           .isEmpty &&
//                                                       _movieController
//                                                           .yearisactive
//                                                           .isEmpty) {
//                                                     _movieController
//                                                             .explorepageavailablenmovies
//                                                             .value =
//                                                         _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .length;
//                                                     _movieController
//                                                         .issearchTagSelected
//                                                         .value = false;
//                                                   }
//                                                 }
//                                                 _movieController.country.remove(
//                                                     countriesArray.keys
//                                                         .toList()[index]);
//                                               } else if (!_movieController
//                                                   .yearisactive
//                                                   .contains(index)) {
//                                                 _movieController.countryisactive
//                                                     .add(index);
//                                                 _movieController.country.add(
//                                                     countriesArray.keys
//                                                         .toList()[index]);
//                                               }
//                                             }
//                                             if (_movieController
//                                                 .countryisactive.isEmpty) {
//                                               _movieController
//                                                   .allcountriesisActive
//                                                   .value = true;
//                                             }

//                                             if (index == 0) {
//                                               _movieController
//                                                   .allcountriesisActive
//                                                   .value = true;
//                                               _movieController.countryisactive
//                                                   .clear();
//                                               if (_movieController
//                                                       .allyearisActive.value &&
//                                                   _movieController
//                                                       .allcountriesisActive
//                                                       .value &&
//                                                   _movieController
//                                                       .allgenreisActive.value) {
//                                                 _movieController
//                                                     .issearchTagSelected
//                                                     .value = false;
//                                               }
//                                               _movieController.country.clear();
//                                             }
//                                             setState(() {});
//                                           },
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: _movieController
//                                                             .allcountriesisActive
//                                                             .value &&
//                                                         index == 0
//                                                     ? const Color(0xffF5A754)
//                                                         .withOpacity(0.5)
//                                                     : _movieController
//                                                             .countryisactive
//                                                             .contains(index)
//                                                         ? const Color(
//                                                                 0xffF5A754)
//                                                             .withOpacity(0.5)
//                                                         : boxColor),
//                                             child: AutoSizeText(
//                                               countries[index],
//                                               textAlign: TextAlign.center,
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 12),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                         ],
//                       ),
//                     );
//                   }),

//                   const SizedBox(height: 15),

//                   // Genre Tag

//                   Obx(() {
//                     return SizedBox(
//                       height: 35,
//                       child: Row(
//                         children: [
//                           moviecontroller.isloading.value
//                               ? Expanded(
//                                   child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: 4,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return Shimmer.fromColors(
//                                           baseColor: boxColor,
//                                           highlightColor: Colors.white10,
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: boxColor),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                               : Expanded(
//                                   child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: moviecontroller.genreModel!
//                                               .videoStreamingApp.length +
//                                           1,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return InkWell(
//                                           onTap: () {
//                                             _movieController.issearchTagSelected
//                                                 .value = true;
//                                             if (index != 0) {
//                                               _movieController.allgenreisActive
//                                                   .value = false;
//                                               if (_movieController
//                                                   .genreIdisactive
//                                                   .contains(index)) {
//                                                 int valueIndex =
//                                                     _movieController
//                                                         .genreIdisactive
//                                                         .indexOf(index);
//                                                 _movieController.genreIdisactive
//                                                     .removeAt(valueIndex);
//                                                 if (_movieController
//                                                         .genreId.length ==
//                                                     1) {
//                                                   if (_movieController.genreIdisactive.isEmpty &&
//                                                       _movieController
//                                                           .countryisactive
//                                                           .isEmpty &&
//                                                       _movieController
//                                                           .yearisactive
//                                                           .isEmpty) {
//                                                     _movieController
//                                                             .explorepageavailablenmovies
//                                                             .value =
//                                                         _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .length;
//                                                     _movieController
//                                                         .issearchTagSelected
//                                                         .value = false;
//                                                   }
//                                                 }
//                                                 _movieController.genreId.remove(
//                                                     moviecontroller
//                                                         .genreModel!
//                                                         .videoStreamingApp[
//                                                             index - 1]
//                                                         .genreId
//                                                         .toString());
//                                               } else if (!_movieController
//                                                   .genreIdisactive
//                                                   .contains(index)) {
//                                                 _movieController.genreIdisactive
//                                                     .add(index);
//                                                 _movieController.genreId.add(
//                                                     moviecontroller
//                                                         .genreModel!
//                                                         .videoStreamingApp[
//                                                             index - 1]
//                                                         .genreId
//                                                         .toString());
//                                               }
//                                             }

//                                             if (_movieController
//                                                 .genreIdisactive.isEmpty) {
//                                               _movieController.allgenreisActive
//                                                   .value = true;
//                                             }

//                                             if (index == 0) {
//                                               _movieController.allgenreisActive
//                                                   .value = true;
//                                               _movieController.genreIdisactive
//                                                   .clear();
//                                               if (_movieController
//                                                       .allyearisActive.value &&
//                                                   _movieController
//                                                       .allcountriesisActive
//                                                       .value &&
//                                                   _movieController
//                                                       .allgenreisActive.value) {
//                                                 _movieController
//                                                     .issearchTagSelected
//                                                     .value = false;
//                                               }
//                                               _movieController.genreId.clear();
//                                             }
//                                             setState(() {});
//                                           },
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: _movieController
//                                                             .allgenreisActive
//                                                             .value &&
//                                                         index == 0
//                                                     ? const Color(0xffF5A754)
//                                                         .withOpacity(0.5)
//                                                     : _movieController
//                                                             .genreIdisactive
//                                                             .contains(index)
//                                                         ? const Color(
//                                                                 0xffF5A754)
//                                                             .withOpacity(0.5)
//                                                         : boxColor),
//                                             child: index == 0
//                                                 ? const AutoSizeText(
//                                                     "All Genre",
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 12),
//                                                   )
//                                                 : AutoSizeText(
//                                                     moviecontroller
//                                                         .genreModel!
//                                                         .videoStreamingApp[
//                                                             index - 1]
//                                                         .genreName,
//                                                     textAlign: TextAlign.center,
//                                                     style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 12),
//                                                   ),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                         ],
//                       ),
//                     );
//                   }),

//                   const SizedBox(height: 15),

//                   // Years Tag

//                   Obx(() {
//                     return SizedBox(
//                       height: 35,
//                       child: Row(
//                         children: [
//                           moviecontroller.isloading.value
//                               ? Expanded(
//                                   child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: 4,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return Shimmer.fromColors(
//                                           baseColor: boxColor,
//                                           highlightColor: Colors.white10,
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: boxColor),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                               : Expanded(
//                                   child: ListView.builder(
//                                       controller: _yearsscrollController,
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount:
//                                           _movieController.yearslength.value,
//                                       itemBuilder:
//                                           (BuildContext context, index) {
//                                         return InkWell(
//                                           onTap: () {
//                                             _movieController.issearchTagSelected
//                                                 .value = true;
//                                             if (index != 0) {
//                                               _movieController
//                                                       .explorepageavailablenmovies
//                                                       .value =
//                                                   _movieController
//                                                       .allMoviesModel!
//                                                       .videoStreamingApp
//                                                       .where((element) {
//                                                         return (_movieController
//                                                                 .year
//                                                                 .contains(element
//                                                                     .release_date) ||
//                                                             _movieController
//                                                                 .genreId
//                                                                 .contains(element
//                                                                     .movie_genre_id) ||
//                                                             _movieController
//                                                                 .country
//                                                                 .contains(element
//                                                                     .country_of_origin));
//                                                       })
//                                                       .toList()
//                                                       .length;
//                                               print("Total Length");
//                                               print(_movieController
//                                                   .explorepageavailablenmovies
//                                                   .value);

//                                               // Checking if lenght is less then 10 then assign total movies lenth to showable length
//                                               if (_movieController
//                                                       .explorepageavailablenmovies
//                                                       .value <
//                                                   10) {
//                                                 _movieController
//                                                         .exploremovieslength
//                                                         .value =
//                                                     _movieController
//                                                         .explorepageavailablenmovies
//                                                         .value;
//                                               }

//                                               setState(() {});

//                                               _movieController.allyearisActive
//                                                   .value = false;
//                                               if (_movieController.yearisactive
//                                                   .contains(index)) {
//                                                 int valueIndex =
//                                                     _movieController
//                                                         .yearisactive
//                                                         .indexOf(index);
//                                                 _movieController.yearisactive
//                                                     .removeAt(valueIndex);
//                                                 if (_movieController
//                                                         .year.length ==
//                                                     1) {
//                                                   if (_movieController.genreIdisactive.isEmpty &&
//                                                       _movieController
//                                                           .countryisactive
//                                                           .isEmpty &&
//                                                       _movieController
//                                                           .yearisactive
//                                                           .isEmpty) {
//                                                     _movieController
//                                                             .explorepageavailablenmovies
//                                                             .value =
//                                                         _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .length;
//                                                     setState(() {});

//                                                     _movieController
//                                                         .issearchTagSelected
//                                                         .value = false;
//                                                   }
//                                                 }
//                                                 _movieController.year.remove(
//                                                     (totalyears - index)
//                                                         .toString());
//                                               } else if (!_movieController
//                                                   .yearisactive
//                                                   .contains(index)) {
//                                                 _movieController.yearisactive
//                                                     .add(index);
//                                                 _movieController.year.add(
//                                                     (totalyears - index)
//                                                         .toString());
//                                               }
//                                             }

//                                             if (_movieController
//                                                 .yearisactive.isEmpty) {
//                                               _movieController
//                                                   .allyearisActive.value = true;
//                                             }

//                                             if (index == 0) {
//                                               _movieController
//                                                   .allyearisActive.value = true;
//                                               _movieController.yearisactive
//                                                   .clear();
//                                               if (_movieController
//                                                       .allyearisActive.value &&
//                                                   _movieController
//                                                       .allcountriesisActive
//                                                       .value &&
//                                                   _movieController
//                                                       .allgenreisActive.value) {
//                                                 _movieController
//                                                     .issearchTagSelected
//                                                     .value = false;
//                                               }
//                                               _movieController.year.clear();
//                                             }
//                                             setState(() {});
//                                           },
//                                           child: Container(
//                                             height: 35,
//                                             width: devicewidth * 0.25,
//                                             alignment: Alignment.center,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 5),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 color: _movieController
//                                                             .allyearisActive
//                                                             .value &&
//                                                         index == 0
//                                                     ? const Color(0xffF5A754)
//                                                         .withOpacity(0.5)
//                                                     : _movieController
//                                                             .yearisactive
//                                                             .contains(index)
//                                                         ? const Color(
//                                                                 0xffF5A754)
//                                                             .withOpacity(0.5)
//                                                         : boxColor),
//                                             child: index == 0
//                                                 ? const AutoSizeText(
//                                                     "All Years",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 12),
//                                                   )
//                                                 : AutoSizeText(
//                                                     (totalyears - index)
//                                                         .toString(),
//                                                     style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 12),
//                                                   ),
//                                           ),
//                                         );
//                                       }),
//                                 )
//                         ],
//                       ),
//                     );
//                   }),

//                   const SizedBox(height: 20),

//                   const AutoSizeText(
//                     "Movies",
//                     style: TextStyle(color: Colors.white, fontSize: 22),
//                   ),

//                   const SizedBox(height: 20),

//                   _movieController.ismoviesloading.value
//                       ? GridView(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   mainAxisSpacing: 5.0,
//                                   crossAxisSpacing: 10.0,
//                                   crossAxisCount: 2,
//                                   childAspectRatio: 100 / 140),
//                           children: List.generate(6, (index) {
//                             return Column(
//                               children: [
//                                 SizedBox(
//                                   height: 150,
//                                   child: Shimmer.fromColors(
//                                     baseColor: boxColor,
//                                     highlightColor: Colors.white10,
//                                     child: Container(
//                                       height: 150,
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                           color: boxColor,
//                                           borderRadius:
//                                               BorderRadius.circular(10.0)),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }))
//                       : 
//                           StreamBuilder(
//                             // stream: null,
//                             builder: (context, snapshot) {
//                               return Obx(() {
//                                   return GridView(
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                               mainAxisSpacing: 5.0,
//                                               crossAxisSpacing: 20.0,
//                                               crossAxisCount: 2,
//                                               childAspectRatio: deviceheight < 550
//                                                   ? 100 / 200
//                                                   : 100 / 150),
//                                       children: _movieController
//                                               .issearchTagSelected.value
//                                           ? _movieController
//                                                   .isUserSearchedinExplorePage.value
                                                        
//                                               // Movies with Searched Value
                                                        
//                                               ? List.generate(
//                                                   _movieController
//                                                       .exploremovieslength.value,
//                                                   (index) => MovieCardWidget(
//                                                         movieId: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return (_movieController
//                                                                           .year
//                                                                           .contains(element
//                                                                               .release_date) ||
//                                                                       _movieController
//                                                                           .genreId
//                                                                           .contains(element
//                                                                               .movie_genre_id) ||
//                                                                       _movieController
//                                                                           .country
//                                                                           .contains(element
//                                                                               .country_of_origin)) &&
//                                                                   element.movieTitle
//                                                                       .toLowerCase()
//                                                                       .contains(moviecontroller
//                                                                           .assignStringExplore
//                                                                           .value
//                                                                           .toLowerCase());
//                                                             })
//                                                             .toList()[index]
//                                                             .movieId,
//                                                         title: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return (_movieController
//                                                                           .year
//                                                                           .contains(element
//                                                                               .release_date) ||
//                                                                       _movieController
//                                                                           .genreId
//                                                                           .contains(element
//                                                                               .movie_genre_id) ||
//                                                                       _movieController
//                                                                           .country
//                                                                           .contains(element
//                                                                               .country_of_origin)) &&
//                                                                   element.movieTitle
//                                                                       .toLowerCase()
//                                                                       .contains(moviecontroller
//                                                                           .assignStringExplore
//                                                                           .value
//                                                                           .toLowerCase());
//                                                             })
//                                                             .toList()[index]
//                                                             .movieTitle,
//                                                         imgurl: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return (_movieController
//                                                                           .year
//                                                                           .contains(element
//                                                                               .release_date) ||
//                                                                       _movieController
//                                                                           .genreId
//                                                                           .contains(element
//                                                                               .movie_genre_id) ||
//                                                                       _movieController
//                                                                           .country
//                                                                           .contains(element
//                                                                               .country_of_origin)) &&
//                                                                   element.movieTitle
//                                                                       .toLowerCase()
//                                                                       .contains(moviecontroller
//                                                                           .assignStringExplore
//                                                                           .value
//                                                                           .toLowerCase());
//                                                             })
//                                                             .toList()[index]
//                                                             .moviePoster,
//                                                         releasedate: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return (_movieController
//                                                                           .year
//                                                                           .contains(element
//                                                                               .release_date) ||
//                                                                       _movieController
//                                                                           .genreId
//                                                                           .contains(element
//                                                                               .movie_genre_id) ||
//                                                                       _movieController
//                                                                           .country
//                                                                           .contains(element
//                                                                               .country_of_origin)) &&
//                                                                   element.movieTitle
//                                                                       .toLowerCase()
//                                                                       .contains(moviecontroller
//                                                                           .assignStringExplore
//                                                                           .value
//                                                                           .toLowerCase());
//                                                             })
//                                                             .toList()[index]
//                                                             .release_date,
//                                                       ))
//                                               :
                                                        
//                                               // Movies without searched value
                                                        
//                                               List.generate(
//                                                   _movieController
//                                                       .exploremovieslength.value,
//                                                   (index) => MovieCardWidget(
//                                                         movieId: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return (_movieController
//                                                                       .year
//                                                                       .contains(element
//                                                                           .release_date) ||
//                                                                   _movieController
//                                                                       .genreId
//                                                                       .contains(element
//                                                                           .movie_genre_id) ||
//                                                                   _movieController
//                                                                       .country
//                                                                       .contains(element
//                                                                           .country_of_origin));
//                                                             })
//                                                             .toList()[index]
//                                                             .movieId,
//                                                         title: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return _movieController.year.contains(element
//                                                                       .release_date) ||
//                                                                   _movieController
//                                                                       .genreId
//                                                                       .contains(element
//                                                                           .movie_genre_id) ||
//                                                                   _movieController
//                                                                       .country
//                                                                       .contains(element
//                                                                           .country_of_origin);
//                                                             })
//                                                             .toList()[index]
//                                                             .movieTitle,
//                                                         imgurl: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return _movieController.year.contains(element
//                                                                       .release_date) ||
//                                                                   _movieController
//                                                                       .genreId
//                                                                       .contains(element
//                                                                           .movie_genre_id) ||
//                                                                   _movieController
//                                                                       .country
//                                                                       .contains(element
//                                                                           .country_of_origin);
//                                                             })
//                                                             .toList()[index]
//                                                             .moviePoster,
//                                                         releasedate: _movieController
//                                                             .allMoviesModel!
//                                                             .videoStreamingApp
//                                                             .where((element) {
//                                                               return _movieController.year.contains(element
//                                                                       .release_date) ||
//                                                                   _movieController
//                                                                       .genreId
//                                                                       .contains(element
//                                                                           .movie_genre_id) ||
//                                                                   _movieController
//                                                                       .country
//                                                                       .contains(element
//                                                                           .country_of_origin);
//                                                             })
//                                                             .toList()[index]
//                                                             .release_date,
//                                                       ))
//                                           : _movieController
//                                                   .isUserSearchedinExplorePage.value
//                                               ? List.generate(
//                                                   _movieController.exploremovieslength
//                                                       .value, (index) {
//                                                   return MovieCardWidget(
//                                                     movieId: _movieController
//                                                         .allMoviesModel!
//                                                         .videoStreamingApp
//                                                         .where((element) {
//                                                           return element.movieTitle
//                                                               .toLowerCase()
//                                                               .contains(moviecontroller
//                                                                   .assignStringExplore
//                                                                   .value
//                                                                   .toLowerCase());
//                                                         })
//                                                         .toList()[index]
//                                                         .movieId,
//                                                     title: _movieController
//                                                         .allMoviesModel!
//                                                         .videoStreamingApp
//                                                         .where((element) {
//                                                           return element.movieTitle
//                                                               .toLowerCase()
//                                                               .contains(moviecontroller
//                                                                   .assignStringExplore
//                                                                   .value
//                                                                   .toLowerCase());
//                                                         })
//                                                         .toList()[index]
//                                                         .movieTitle,
//                                                     imgurl: _movieController
//                                                         .allMoviesModel!
//                                                         .videoStreamingApp
//                                                         .where((element) {
//                                                           return element.movieTitle
//                                                               .toLowerCase()
//                                                               .contains(moviecontroller
//                                                                   .assignStringExplore
//                                                                   .value
//                                                                   .toLowerCase());
//                                                         })
//                                                         .toList()[index]
//                                                         .moviePoster,
//                                                     releasedate: _movieController
//                                                         .allMoviesModel!
//                                                         .videoStreamingApp[index]
//                                                         .release_date,
//                                                   );
//                                                 })
//                                               : List.generate(
//                                                   _movieController.exploremovieslength
//                                                       .value, (index) {
//                                                   return MovieCardWidget(
//                                                       movieId: _movieController
//                                                           .allMoviesModel!
//                                                           .videoStreamingApp[index]
//                                                           .movieId,
//                                                       title: _movieController
//                                                           .allMoviesModel!
//                                                           .videoStreamingApp[index]
//                                                           .movieTitle,
//                                                       imgurl: _movieController
//                                                           .allMoviesModel!
//                                                           .videoStreamingApp[index]
//                                                           .moviePoster,
//                                                       releasedate: _movieController
//                                                           .allMoviesModel!
//                                                           .videoStreamingApp[index]
//                                                           .release_date);
//                                                 }));
//                                 }
//                               );
//                             }
//                           ),
                        

//                   _movieController.exploreisfetchingmoremovies.value
//                       ? Container(
//                           height: 50,
//                           width: double.infinity,
//                           alignment: Alignment.center,
//                           child: const CircularProgressIndicator(
//                             color: Colors.orangeAccent,
//                           ),
//                         )
//                       : const SizedBox()
//                 ],
//               ),
//             ),
//           );
//         })),
//       ),

//       // floatingActionButton: FloatingActionButton(onPressed: (() => print(deviceheight)))
//     );
//   }
// }












// // List.generate(
// //                                       _movieController
// //                                           .exploremovieslength.value,
// //                                       (index) => _movieController
// //                                               .isUserSearchedinExplorePage.value
// //                                           ? MovieCardWidget(
// //                                               movieId: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieId,
// //                                               title: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieTitle,
// //                                               imgurl: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .moviePoster)
// //                                           : MovieCardWidget(
// //                                               movieId: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(element
// //                                                             .release_date) ||
// //                                                         genreId.contains(element
// //                                                             .movie_genre_id) ||
// //                                                         country.contains(element
// //                                                             .country_of_origin));
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieId,
// //                                               title:
// //                                                   _movieController
// //                                                       .allMoviesModel!
// //                                                       .videoStreamingApp
// //                                                       .where((element) {
// //                                                         return year.contains(element.release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin);
// //                                                       })
// //                                                       .toList()[index]
// //                                                       .movieTitle,
// //                                               imgurl:
// //                                                   _movieController
// //                                                       .allMoviesModel!
// //                                                       .videoStreamingApp
// //                                                       .where((element) {
// //                                                         return year.contains(element.release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin);
// //                                                       })
// //                                                       .toList()[index]
// //                                                       .moviePoster))
                                  















// // Stream Started













// //                                   import 'dart:async';
// // import 'dart:ffi';

// // import 'package:auto_size_text/auto_size_text.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:shimmer/shimmer.dart';
// // import 'package:testapp/controller/movie_controller.dart';
// // import 'package:testapp/model/moviesmodel.dart';
// // import 'package:testapp/videoPlayer/video_player.dart';
// // import 'package:testapp/widgets/movie_card.dart';
// // import '../constants.dart';
// // import '../widgets/custom_textfield.dart';

// // StreamController<List<VideoStreamingApp>> streamController =
// //     StreamController<List<VideoStreamingApp>>.broadcast();
// // Stream<List<VideoStreamingApp>> get stream => streamController.stream;




// // class Explore extends StatefulWidget {
// //   const Explore({super.key});

// //   @override
// //   State<Explore> createState() => _ExploreState();
// // }

// // class _ExploreState extends State<Explore> {
// //   List<String> countries = countriesArray.values.toList();

// //   // Current Year
// //   int totalyears = DateTime.now().year;
// //   bool isLoading = false;
// //   int total = 5;
// //   final ScrollController _scrollController = ScrollController();
// //   final ScrollController _countriesscrollController = ScrollController();
// //   final ScrollController _yearsscrollController = ScrollController();
// //   final MovieController movieController = Get.find();

// // // Search Tags

// //   // bool issearchTagSelected = false;

// //   // Scroll Listener

// //   @override
// //   Widget build(BuildContext context) {
// //     double deviceheight = MediaQuery.of(context).size.height;
// //     double devicewidth = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       body: Container(
// //         padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
// //         child: SafeArea(
// //             child: NotificationListener(
// //           onNotification: (t) {
// //             if (t is ScrollEndNotification) {
// //               if (_scrollController.position.maxScrollExtent ==
// //                   _scrollController.position.pixels) {
// //                 movieController.fetchmoremovies();
// //                 setState(() {});
// //               }
// //               if (_countriesscrollController.position.maxScrollExtent ==
// //                   _countriesscrollController.position.pixels) {
// //                 movieController.fetchmorecountries(countries.length);
// //               }
// //               if (_yearsscrollController.position.maxScrollExtent ==
// //                   _yearsscrollController.position.pixels) {
// //                 movieController.fetchmoreyears(totalyears);
// //               }
// //             }
// //             return true;
// //           },
// //           child: SingleChildScrollView(
// //             controller: _scrollController,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               children: [
// //                 // Text Field
// //                 CustomTextField(
// //                   isgenrePage: false,
// //                   ishomePage: false,
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // Search by Tags
// //                 const Text(
// //                   "Search by tags",
// //                   style: TextStyle(color: Colors.white, fontSize: 22),
// //                 ),

// //                 const SizedBox(height: 20),

// //                 // Country Tag

// //                 Obx(() {
// //                   return SizedBox(
// //                     height: 35,
// //                     child: Row(
// //                       children: [
// //                         moviecontroller.isloading.value
// //                             ? Expanded(
// //                                 child: ListView.builder(
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount: 4,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return Shimmer.fromColors(
// //                                         baseColor: boxColor,
// //                                         highlightColor: Colors.white10,
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: boxColor),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                             : Expanded(
// //                                 child: ListView.builder(
// //                                     controller: _countriesscrollController,
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount:
// //                                         movieController.countrieslength.value,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return InkWell(
// //                                         onTap: () {
// //                                           movieController
// //                                               .issearchTagSelected.value = true;
// //                                           if (index != 0) {
// //                                             movieController.allcountriesisActive
// //                                                 .value = false;
// //                                             if (movieController.countryisactive
// //                                                 .contains(index)) {
// //                                               int valueIndex = movieController
// //                                                   .countryisactive
// //                                                   .indexOf(index);
// //                                               movieController.countryisactive
// //                                                   .removeAt(valueIndex);
// //                                               if (movieController
// //                                                       .country.length ==
// //                                                   1) {
// //                                                 if (movieController.genreIdisactive.isEmpty &&
// //                                                     movieController
// //                                                         .countryisactive
// //                                                         .isEmpty &&
// //                                                     movieController
// //                                                         .yearisactive.isEmpty) {
// //                                                   movieController
// //                                                           .explorepageavailablenmovies
// //                                                           .value =
// //                                                       movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .length;
// //                                                   movieController
// //                                                       .issearchTagSelected
// //                                                       .value = false;
// //                                                 }
// //                                               }
// //                                               movieController.country.remove(
// //                                                   countriesArray.keys
// //                                                       .toList()[index]);
// //                                             } else if (!movieController
// //                                                 .yearisactive
// //                                                 .contains(index)) {
// //                                               movieController.countryisactive
// //                                                   .add(index);
// //                                               movieController.country.add(
// //                                                   countriesArray.keys
// //                                                       .toList()[index]);
// //                                             }
// //                                           }
// //                                           if (movieController
// //                                               .countryisactive.isEmpty) {
// //                                             movieController.allcountriesisActive
// //                                                 .value = true;
// //                                           }

// //                                           if (index == 0) {
// //                                             movieController.allcountriesisActive
// //                                                 .value = true;
// //                                             movieController.countryisactive
// //                                                 .clear();
// //                                             if (movieController
// //                                                     .allyearisActive.value &&
// //                                                 movieController
// //                                                     .allcountriesisActive
// //                                                     .value &&
// //                                                 movieController
// //                                                     .allgenreisActive.value) {
// //                                               movieController
// //                                                   .issearchTagSelected
// //                                                   .value = false;
// //                                             }
// //                                             movieController.country.clear();
// //                                           }
// //                                           setState(() {});
// //                                         },
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: movieController
// //                                                           .allcountriesisActive
// //                                                           .value &&
// //                                                       index == 0
// //                                                   ? const Color(0xffF5A754)
// //                                                       .withOpacity(0.5)
// //                                                   : movieController
// //                                                           .countryisactive
// //                                                           .contains(index)
// //                                                       ? const Color(0xffF5A754)
// //                                                           .withOpacity(0.5)
// //                                                       : boxColor),
// //                                           child: AutoSizeText(
// //                                             countries[index],
// //                                             textAlign: TextAlign.center,
// //                                             style: const TextStyle(
// //                                                 color: Colors.white,
// //                                                 fontSize: 12),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                       ],
// //                     ),
// //                   );
// //                 }),

// //                 const SizedBox(height: 15),

// //                 // Genre Tag

// //                 Obx(() {
// //                   return SizedBox(
// //                     height: 35,
// //                     child: Row(
// //                       children: [
// //                         moviecontroller.isloading.value
// //                             ? Expanded(
// //                                 child: ListView.builder(
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount: 4,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return Shimmer.fromColors(
// //                                         baseColor: boxColor,
// //                                         highlightColor: Colors.white10,
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: boxColor),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                             : Expanded(
// //                                 child: ListView.builder(
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount: moviecontroller.genreModel!
// //                                             .videoStreamingApp.length +
// //                                         1,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return InkWell(
// //                                         onTap: () {
// //                                           movieController
// //                                               .issearchTagSelected.value = true;
// //                                           if (index != 0) {
// //                                             movieController
// //                                                 .allgenreisActive.value = false;
// //                                             if (movieController.genreIdisactive
// //                                                 .contains(index)) {
// //                                               int valueIndex = movieController
// //                                                   .genreIdisactive
// //                                                   .indexOf(index);
// //                                               movieController.genreIdisactive
// //                                                   .removeAt(valueIndex);
// //                                               if (movieController
// //                                                       .genreId.length ==
// //                                                   1) {
// //                                                 if (movieController.genreIdisactive.isEmpty &&
// //                                                     movieController
// //                                                         .countryisactive
// //                                                         .isEmpty &&
// //                                                     movieController
// //                                                         .yearisactive.isEmpty) {
// //                                                   movieController
// //                                                           .explorepageavailablenmovies
// //                                                           .value =
// //                                                       movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .length;
// //                                                   movieController
// //                                                       .issearchTagSelected
// //                                                       .value = false;
// //                                                 }
// //                                               }
// //                                               movieController.genreId.remove(
// //                                                   moviecontroller
// //                                                       .genreModel!
// //                                                       .videoStreamingApp[
// //                                                           index - 1]
// //                                                       .genreId
// //                                                       .toString());
// //                                             } else if (!movieController
// //                                                 .genreIdisactive
// //                                                 .contains(index)) {
// //                                               movieController.genreIdisactive
// //                                                   .add(index);
// //                                               movieController.genreId.add(
// //                                                   moviecontroller
// //                                                       .genreModel!
// //                                                       .videoStreamingApp[
// //                                                           index - 1]
// //                                                       .genreId
// //                                                       .toString());
// //                                             }
// //                                           }

// //                                           if (movieController
// //                                               .genreIdisactive.isEmpty) {
// //                                             movieController
// //                                                 .allgenreisActive.value = true;
// //                                           }

// //                                           if (index == 0) {
// //                                             movieController
// //                                                 .allgenreisActive.value = true;
// //                                             movieController.genreIdisactive
// //                                                 .clear();
// //                                             if (movieController
// //                                                     .allyearisActive.value &&
// //                                                 movieController
// //                                                     .allcountriesisActive
// //                                                     .value &&
// //                                                 movieController
// //                                                     .allgenreisActive.value) {
// //                                               movieController
// //                                                   .issearchTagSelected
// //                                                   .value = false;
// //                                             }
// //                                             movieController.genreId.clear();
// //                                           }
// //                                           setState(() {});
// //                                         },
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: movieController
// //                                                           .allgenreisActive
// //                                                           .value &&
// //                                                       index == 0
// //                                                   ? const Color(0xffF5A754)
// //                                                       .withOpacity(0.5)
// //                                                   : movieController
// //                                                           .genreIdisactive
// //                                                           .contains(index)
// //                                                       ? const Color(0xffF5A754)
// //                                                           .withOpacity(0.5)
// //                                                       : boxColor),
// //                                           child: index == 0
// //                                               ? const AutoSizeText(
// //                                                   "All Genre",
// //                                                   textAlign: TextAlign.center,
// //                                                   style: TextStyle(
// //                                                       color: Colors.white,
// //                                                       fontSize: 12),
// //                                                 )
// //                                               : AutoSizeText(
// //                                                   moviecontroller
// //                                                       .genreModel!
// //                                                       .videoStreamingApp[
// //                                                           index - 1]
// //                                                       .genreName,
// //                                                   textAlign: TextAlign.center,
// //                                                   style: const TextStyle(
// //                                                       color: Colors.white,
// //                                                       fontSize: 12),
// //                                                 ),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                       ],
// //                     ),
// //                   );
// //                 }),

// //                 const SizedBox(height: 15),

// //                 // Years Tag

// //                 Obx(() {
// //                   return SizedBox(
// //                     height: 35,
// //                     child: Row(
// //                       children: [
// //                         moviecontroller.isloading.value
// //                             ? Expanded(
// //                                 child: ListView.builder(
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount: 4,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return Shimmer.fromColors(
// //                                         baseColor: boxColor,
// //                                         highlightColor: Colors.white10,
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: boxColor),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                             : Expanded(
// //                                 child: ListView.builder(
// //                                     controller: _yearsscrollController,
// //                                     scrollDirection: Axis.horizontal,
// //                                     itemCount:
// //                                         movieController.yearslength.value,
// //                                     itemBuilder: (BuildContext context, index) {
// //                                       return InkWell(
// //                                         onTap: () {
// //                                           movieController
// //                                               .issearchTagSelected.value = true;
// //                                           if (index != 0) {
// //                                             movieController
// //                                                     .explorepageavailablenmovies
// //                                                     .value =
// //                                                 movieController.allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) ||
// //                                                           movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) ||
// //                                                           movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                     })
// //                                                     .toList()
// //                                                     .length;
// //                                             print("Total Length");
// //                                             print(movieController
// //                                                 .explorepageavailablenmovies
// //                                                 .value);

// //                                             // Checking if lenght is less then 10 then assign total movies lenth to showable length
// //                                             if (movieController
// //                                                     .explorepageavailablenmovies
// //                                                     .value <
// //                                                 10) {
// //                                               movieController
// //                                                       .exploremovieslength
// //                                                       .value =
// //                                                   movieController
// //                                                       .explorepageavailablenmovies
// //                                                       .value;
// //                                             }

// //                                             setState(() {});

// //                                             movieController
// //                                                 .allyearisActive.value = false;
// //                                             if (movieController.yearisactive
// //                                                 .contains(index)) {
// //                                               int valueIndex = movieController
// //                                                   .yearisactive
// //                                                   .indexOf(index);
// //                                               movieController.yearisactive
// //                                                   .removeAt(valueIndex);
// //                                               if (movieController.year.length ==
// //                                                   1) {
// //                                                 if (movieController.genreIdisactive.isEmpty &&
// //                                                     movieController
// //                                                         .countryisactive
// //                                                         .isEmpty &&
// //                                                     movieController
// //                                                         .yearisactive.isEmpty) {
// //                                                   movieController
// //                                                           .explorepageavailablenmovies
// //                                                           .value =
// //                                                       movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .length;
// //                                                   setState(() {});

// //                                                   movieController
// //                                                       .issearchTagSelected
// //                                                       .value = false;
// //                                                 }
// //                                               }
// //                                               movieController.year.remove(
// //                                                   (totalyears - index)
// //                                                       .toString());
// //                                             } else if (!movieController
// //                                                 .yearisactive
// //                                                 .contains(index)) {
// //                                               movieController.yearisactive
// //                                                   .add(index);
// //                                               movieController.year.add(
// //                                                   (totalyears - index)
// //                                                       .toString());
// //                                             }
// //                                           }

// //                                           if (movieController
// //                                               .yearisactive.isEmpty) {
// //                                             movieController
// //                                                 .allyearisActive.value = true;
// //                                           }

// //                                           if (index == 0) {
// //                                             movieController
// //                                                 .allyearisActive.value = true;
// //                                             movieController.yearisactive
// //                                                 .clear();
// //                                             if (movieController
// //                                                     .allyearisActive.value &&
// //                                                 movieController
// //                                                     .allcountriesisActive
// //                                                     .value &&
// //                                                 movieController
// //                                                     .allgenreisActive.value) {
// //                                               movieController
// //                                                   .issearchTagSelected
// //                                                   .value = false;
// //                                             }
// //                                             movieController.year.clear();
// //                                           }
// //                                           setState(() {});
// //                                         },
// //                                         child: Container(
// //                                           height: 35,
// //                                           width: devicewidth * 0.25,
// //                                           alignment: Alignment.center,
// //                                           margin: const EdgeInsets.symmetric(
// //                                               horizontal: 5),
// //                                           decoration: BoxDecoration(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                               color: movieController
// //                                                           .allyearisActive
// //                                                           .value &&
// //                                                       index == 0
// //                                                   ? const Color(0xffF5A754)
// //                                                       .withOpacity(0.5)
// //                                                   : movieController.yearisactive
// //                                                           .contains(index)
// //                                                       ? const Color(0xffF5A754)
// //                                                           .withOpacity(0.5)
// //                                                       : boxColor),
// //                                           child: index == 0
// //                                               ? const AutoSizeText(
// //                                                   "All Years",
// //                                                   style: TextStyle(
// //                                                       color: Colors.white,
// //                                                       fontSize: 12),
// //                                                 )
// //                                               : AutoSizeText(
// //                                                   (totalyears - index)
// //                                                       .toString(),
// //                                                   style: const TextStyle(
// //                                                       color: Colors.white,
// //                                                       fontSize: 12),
// //                                                 ),
// //                                         ),
// //                                       );
// //                                     }),
// //                               )
// //                       ],
// //                     ),
// //                   );
// //                 }),

// //                 const SizedBox(height: 20),

// //                 const AutoSizeText(
// //                   "Movies",
// //                   style: TextStyle(color: Colors.white, fontSize: 22),
// //                 ),

// //                 const SizedBox(height: 20),

// //                 Obx(() {
// //                   return movieController.ismoviesloading.value
// //                       ? const Center(
// //                           child: CircularProgressIndicator(),
// //                         )
// //                       : StreamBuilder<List<VideoStreamingApp>>(
// //                           initialData:
// //                               movieController.allMoviesModel!.videoStreamingApp,
// //                           stream: stream,
// //                           builder: (BuildContext ctx,
// //                               AsyncSnapshot<List<VideoStreamingApp>>
// //                                   streamSnapshot) {
// //                             // if (streamSnapshot.connectionState ==
// //                             //     ConnectionState.waiting) {
// //                             //   return const Center(
// //                             //       child: CircularProgressIndicator(
// //                             //     color: Colors.orangeAccent,
// //                             //   ));
// //                             // }

// //                             return GridView(
// //                               physics: const NeverScrollableScrollPhysics(),
// //                               shrinkWrap: true,
// //                               gridDelegate:
// //                                   const SliverGridDelegateWithFixedCrossAxisCount(
// //                                       mainAxisSpacing: 5.0,
// //                                       crossAxisSpacing: 10.0,
// //                                       crossAxisCount: 2,
// //                                       childAspectRatio: 100 / 140),
// //                               children: List.generate(
// //                                   20,  
// //                                   (index) => MovieCardWidget(
// //                                       movieId:
// //                                           streamSnapshot.data![index].movieId,
// //                                       title: streamSnapshot
// //                                           .data![index].movieTitle,
// //                                       imgurl: streamSnapshot
// //                                           .data![index].moviePoster,
// //                                       releasedate: streamSnapshot
// //                                           .data![index].release_date)),
// //                             );
// //                           });
// //                 }),

                
// //               ],

// //             ),
// //           ),
// //         )),
// //       ),

// //       // floatingActionButton: FloatingActionButton(onPressed: (() => print(deviceheight)))
// //     );
// //   }
// // }

































// // Stream Builder Sectopn end




























// // GridView(
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       shrinkWrap: true,
// //                       gridDelegate:
// //                           const SliverGridDelegateWithFixedCrossAxisCount(
// //                               mainAxisSpacing: 5.0,
// //                               crossAxisSpacing: 10.0,
// //                               crossAxisCount: 2,
// //                               childAspectRatio: 100 / 140),
// //                       children: List.generate(
// //                           streamSnapshot.data!.length,
// //                           (index) => MovieCardWidget(
// //                               movieId: movieId,
// //                               title: title,
// //                               imgurl: imgurl,
// //                               releasedate: releasedate)),
// //                     );



// // GridView(
// //                           physics: const NeverScrollableScrollPhysics(),
// //                           shrinkWrap: true,
// //                           gridDelegate:
// //                               const SliverGridDelegateWithFixedCrossAxisCount(
// //                                   mainAxisSpacing: 5.0,
// //                                   crossAxisSpacing: 10.0,
// //                                   crossAxisCount: 2,
// //                                   childAspectRatio: 100 / 140),








// // List.generate(
// //                                       movieController
// //                                           .exploremovieslength.value,
// //                                       (index) => movieController
// //                                               .isUserSearchedinExplorePage.value
// //                                           ? MovieCardWidget(
// //                                               movieId: movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieId,
// //                                               title: movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieTitle,
// //                                               imgurl: movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(
// //                                                                 element
// //                                                                     .release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin)) &&
// //                                                         element.movieTitle
// //                                                             .toLowerCase()
// //                                                             .contains(moviecontroller
// //                                                                 .assignStringExplore
// //                                                                 .value
// //                                                                 .toLowerCase());
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .moviePoster)
// //                                           : MovieCardWidget(
// //                                               movieId: movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp
// //                                                   .where((element) {
// //                                                     return (year.contains(element
// //                                                             .release_date) ||
// //                                                         genreId.contains(element
// //                                                             .movie_genre_id) ||
// //                                                         country.contains(element
// //                                                             .country_of_origin));
// //                                                   })
// //                                                   .toList()[index]
// //                                                   .movieId,
// //                                               title:
// //                                                   movieController
// //                                                       .allMoviesModel!
// //                                                       .videoStreamingApp
// //                                                       .where((element) {
// //                                                         return year.contains(element.release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin);
// //                                                       })
// //                                                       .toList()[index]
// //                                                       .movieTitle,
// //                                               imgurl:
// //                                                   movieController
// //                                                       .allMoviesModel!
// //                                                       .videoStreamingApp
// //                                                       .where((element) {
// //                                                         return year.contains(element.release_date) ||
// //                                                             genreId.contains(element
// //                                                                 .movie_genre_id) ||
// //                                                             country.contains(element
// //                                                                 .country_of_origin);
// //                                                       })
// //                                                       .toList()[index]
// //                                                       .moviePoster))
                                  











//                                   // Text Editing Page





















// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// // import 'package:testapp/model/moviesmodel.dart';
// // import 'package:testapp/view/explore.dart';
// // import 'package:testapp/view/movie_byGenre.dart';
// // import '../controller/movie_controller.dart';

// // // ignore: must_be_immutable
// // class CustomTextField extends StatelessWidget {
// //   bool isgenrePage;
// //   bool ishomePage;
// //   CustomTextField(
// //       {required this.isgenrePage, required this.ishomePage, super.key});
// //   // ScrollController? _scrollController;
// //   final MovieController moviecontroller = Get.find();
// //   @override
// //   Widget build(BuildContext context) {
// //     // Movie Controller

// //     // Device Pixels
// //     double deviceheight = MediaQuery.of(context).size.height;
// //     double devicewidth = MediaQuery.of(context).size.width;
// //     return Container(
// //       height: 51,
// //       color: const Color(0xff1C1A2E),
// //       padding: const EdgeInsets.all(8.0),
// //       child: Row(
// //         children: [
// //           Expanded(child: Obx(() {
// //             return TextField(
// //                 style: const TextStyle(color: Colors.white),
// //                 controller: isgenrePage
// //                     ? moviecontroller.genrePageController.value
// //                     : ishomePage
// //                         ? moviecontroller.homePageController.value
// //                         : moviecontroller.explorePageController.value,
// //                 maxLengthEnforcement: MaxLengthEnforcement.enforced,
// //                 cursorColor: Colors.transparent,
// //                 onChanged: ((value) {
// //                   if (moviecontroller
// //                       .homePageController.value.text.isNotEmpty) {
// //                     moviecontroller.isUserSearchedinHomePage.value = true;
// //                     moviecontroller.assignString.value = value;
// //                     if (moviecontroller.allMoviesModel!.videoStreamingApp
// //                             .where((element) {
// //                           return element.movieTitle.toLowerCase().contains(
// //                               moviecontroller.assignString.value.toLowerCase());
// //                         }).length <
// //                         8) {
// //                       moviecontroller.homePagemovieslength.value =
// //                           moviecontroller.allMoviesModel!.videoStreamingApp
// //                               .where((element) {
// //                         return element.movieTitle.toLowerCase().contains(
// //                             moviecontroller.assignString.value.toLowerCase());
// //                       }).length;
// //                     }
// //                   }

// //                   if (moviecontroller
// //                       .explorePageController.value.text.isNotEmpty) {
// //                     moviecontroller.isUserSearchedinExplorePage.value = true;
// //                     moviecontroller.assignStringExplore.value = value;

// //                     List<VideoStreamingApp> filterlist = moviecontroller
// //                         .allMoviesModel!.videoStreamingApp
// //                         .where((element) {
// //                       return element.movieTitle.toLowerCase().contains(
// //                           moviecontroller.assignStringExplore.value
// //                               .toLowerCase());
// //                     }).toList();

// //                     // moviecontroller.initialmovieslength.value =
// //                     //     filterlist.length;

// //                     streamController.sink.add(filterlist);

// //                     if (moviecontroller.allMoviesModel!.videoStreamingApp
// //                             .where((element) {
// //                           return element.movieTitle.toLowerCase().contains(
// //                               moviecontroller.assignStringExplore.value
// //                                   .toLowerCase());
// //                         }).length <
// //                         10) {
// //                       moviecontroller.exploremovieslength.value =
// //                           moviecontroller.allMoviesModel!.videoStreamingApp
// //                               .where((element) {
// //                         return element.movieTitle.toLowerCase().contains(
// //                             moviecontroller.assignStringExplore.value
// //                                 .toLowerCase());
// //                       }).length;
// //                     }
// //                   }

// //                   if (moviecontroller
// //                       .genrePageController.value.text.isNotEmpty) {
// //                     print("Editing Genre");
// //                     moviecontroller.isUserSearchedinGenrePage.value = true;
// //                     moviecontroller.assignStringGenre.value = value;
// //                     moviecontroller.genremoviesdisplaylength.value =
// //                         moviecontroller.genremovie_detail!.videoStreamingApp
// //                             .where((element) {
// //                       return element.movieTitle.toLowerCase().contains(
// //                           moviecontroller.assignStringGenre.value
// //                               .toLowerCase());
// //                     }).length;
// //                   }

// //                   if (value.isEmpty) {
// //                     if (moviecontroller.homePageController.value.text.isEmpty) {
// //                       moviecontroller.isUserSearchedinHomePage.value = false;
// //                     }
// //                     if (moviecontroller
// //                         .explorePageController.value.text.isEmpty) {
// //                       moviecontroller.isUserSearchedinExplorePage.value = false;
// //                       moviecontroller.exploremovieslength.value = 8;
// //                       List<VideoStreamingApp> filterlist =
// //                           moviecontroller.allMoviesModel!.videoStreamingApp;
// //                       moviecontroller.initialmovieslength.value =
// //                         filterlist.length;    
// //                       streamController.sink.add(filterlist);
// //                     }

// //                     if (moviecontroller
// //                         .genrePageController.value.text.isEmpty) {
// //                       moviecontroller.isUserSearchedinGenrePage.value = false;
// //                     }
// //                   }
// //                 }),
// //                 decoration: const InputDecoration(
// //                     filled: false,
// //                     fillColor: Color(0xff1E2030),
// //                     focusColor: Colors.transparent,
// //                     hoverColor: Colors.transparent,
// //                     hintText: 'What are you watching today',
// //                     hintTextDirection: TextDirection.ltr,
// //                     hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
// //                     contentPadding: EdgeInsets.symmetric(horizontal: 10),
// //                     border: InputBorder.none));
// //           })),

// //           const VerticalDivider(
// //             color: Colors.white,
// //             thickness: 0.8,
// //           ),

// //           const SizedBox(
// //             width: 5,
// //           ),

// //           !isgenrePage
// //               ? GestureDetector(
// //                   onTap: () {
// //                     showMaterialModalBottomSheet(
// //                       backgroundColor: Colors.black.withOpacity(0.6),
// //                       context: context,
// //                       builder: (context) => Container(
// //                         height: deviceheight,
// //                         padding: const EdgeInsets.symmetric(horizontal: 20),
// //                         decoration: const BoxDecoration(
// //                           gradient: LinearGradient(
// //                             colors: [
// //                               Colors.black,
// //                               Colors.transparent,
// //                             ],
// //                             begin: Alignment.bottomCenter,
// //                             end: Alignment.topCenter,
// //                             stops: [0.1, 1],
// //                           ),
// //                         ),
// //                         child: Stack(
// //                           alignment: Alignment.bottomCenter,
// //                           children: [
// //                             Column(
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               mainAxisAlignment: MainAxisAlignment.end,
// //                               children: [
// //                                 Obx(() => moviecontroller.isloading.value
// //                                     ? const SizedBox(
// //                                         child: Center(
// //                                           child: CircularProgressIndicator(
// //                                             color: Colors.orange,
// //                                           ),
// //                                         ),
// //                                       )
// //                                     : SizedBox(
// //                                         height: deviceheight,
// //                                         width: double.infinity,
// //                                         child:
// //                                             // Row(
// //                                             //   children: [
// //                                             //     Expanded(
// //                                             // child:

// //                                             SingleChildScrollView(
// //                                           // controller: _scrollController,
// //                                           child: Container(
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 vertical: 100),
// //                                             child: Column(
// //                                               children: [
// //                                                 for (int index = 0;
// //                                                     index <
// //                                                         moviecontroller
// //                                                             .genreModel!
// //                                                             .videoStreamingApp
// //                                                             .length;
// //                                                     index++)
// //                                                   GestureDetector(
// //                                                     onTap: () {
// //                                                       // print(
// //                                                       //   moviecontroller
// //                                                       //       .genreModel!
// //                                                       //       .videoStreamingApp[
// //                                                       //           index]
// //                                                       //       .genreId
// //                                                       //       .toString(),
// //                                                       // );
// //                                                       Get.to(Movie_byGenreScreen(
// //                                                           movieId: moviecontroller
// //                                                               .genreModel!
// //                                                               .videoStreamingApp[
// //                                                                   index]
// //                                                               .genreId
// //                                                               .toString(),
// //                                                           genreName: moviecontroller
// //                                                               .genreModel!
// //                                                               .videoStreamingApp[
// //                                                                   index]
// //                                                               .genreName));
// //                                                     },
// //                                                     child: Container(
// //                                                       // height: 35,
// //                                                       // width: devicewidth * 0.25,
// //                                                       alignment:
// //                                                           Alignment.center,
// //                                                       padding:
// //                                                           const EdgeInsets.all(
// //                                                               5.0),
// //                                                       margin: index == 0
// //                                                           ? const EdgeInsets
// //                                                                   .only(
// //                                                               bottom: 15,
// //                                                               top: 200)
// //                                                           : const EdgeInsets
// //                                                               .only(bottom: 15),
// //                                                       child: Text(
// //                                                         moviecontroller
// //                                                             .genreModel!
// //                                                             .videoStreamingApp[
// //                                                                 index]
// //                                                             .genreName,
// //                                                         style: TextStyle(
// //                                                             color: Colors.white,
// //                                                             fontSize: 22,
// //                                                             fontWeight:
// //                                                                 index == 0
// //                                                                     ? FontWeight
// //                                                                         .w500
// //                                                                     : FontWeight
// //                                                                         .w300),
// //                                                         textAlign:
// //                                                             TextAlign.center,
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       )),
// //                               ],
// //                             ),
// //                             GestureDetector(
// //                               onTap: (() => Navigator.pop(context)),
// //                               child: Container(
// //                                 height: 70,
// //                                 width: 70,
// //                                 margin: const EdgeInsets.only(bottom: 10),
// //                                 alignment: Alignment.center,
// //                                 decoration: const BoxDecoration(
// //                                     color: Colors.white,
// //                                     shape: BoxShape.circle),
// //                                 child: const Icon(
// //                                   Icons.close,
// //                                   color: Colors.black,
// //                                   size: 40,
// //                                 ),
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: const ImageIcon(AssetImage("assets/menulogo.png"),
// //                       color: Colors.white))
// //               : GestureDetector(
// //                   onTap: () {},
// //                   child: const Icon(
// //                     Icons.search,
// //                     color: Colors.white,
// //                   )),
// //           // FaIcon(
// //           //   Icons.menu,
// //           //   color: Colors.white,
// //           // ),
// //           const SizedBox(
// //             width: 5,
// //           ),
// //         ],
// //       ),
// //     );
// //     // Card(
// //     //   margin: EdgeInsets.symmetric(horizontal: 24),
// //     //   color: Color(0xff1C1A2E),
// //     //   elevation: 1,
// //     //   child:
// //     //   TextField(
// //     //     decoration: InputDecoration(
// //     //       focusColor:Color(0xff1C1A2E) ,
// //     //       fillColor: Color(0xff1C1A2E),
// //     //       suffixIcon: Icon(Icons.search, color: Colors.white,),
// //     //       iconColor: Colors.white,
// //     //       enabledBorder: OutlineInputBorder(

// //     //         borderRadius: BorderRadius.circular(10)), //<-- SEE HERE
// //     //       ),

// //     //   // ),
// //     // );
// //   }
// // }




















// // Controller







// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/cupertino.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:get/get.dart';
// // import 'package:testapp/model/PopularMovies_Model.dart';
// // import 'package:testapp/model/genre_model.dart';
// // import 'package:testapp/model/movie_detail_model.dart';
// // import 'package:testapp/model/moviegenre_detailmodel.dart';
// // import 'package:testapp/model/moviesmodel.dart';
// // import '../constants.dart';

// // class MovieController extends GetxController {
// //   RxBool isloading = true.obs;
// //   RxBool ismoviesloading = true.obs;
// //   RxBool isloadingpopularmovies = true.obs;
// //   RxBool isloadingdetailmovies = true.obs;
// //   RxBool isloadingdetailgenremovies = true.obs;
// //   // ignore: non_constant_identifier_names
// //   RxBool ismovieavailablein_genremovies = true.obs;
// //   RxBool isloadingplatestmovies = true.obs;
// //   RxInt isActiveGenreColor = 0.obs;
// //   RxInt isActiveGenreSelectedExplorePageColor = 0.obs;
// //   RxString movieurl = ''.obs;
// //   RxString subtitleurl = ''.obs;

// //   GenreModel? genreModel;
// //   MoviegenreDetailmodel? genremovie_detail;
// //   PopularMoviesModel? popularMoviesModel;
// //   PopularMoviesModel? latestMoviesModel;
// //   // ignore: non_constant_identifier_names
// //   MovieDetailModel? movie_detail_Model;
// //   MoviesModel? allMoviesModel;
// //   // MoviesModel? allMoviesModelcheck;
// //   List<AllMoviesModelExplore>? allMoviesModelExplore;
// // //  List loading circular logics
// // //  for movies
// //   RxInt exploremovieslength = 0.obs;

// //   RxInt explorepageavailablenmovies = 0.obs;
// //   RxInt homePagemovieslength = 8.obs;
// //   // RxInt displaymovies = 1.obs;
// //   RxBool exploreisfetchingmoremovies = false.obs;
// // // for countries search tags
// //   RxInt countrieslength = 8.obs;
// // // for countries search tags
// //   RxInt yearslength = 8.obs;

// // // Search Text Editing Controller

// //   final homePageController = TextEditingController().obs;
// //   final explorePageController = TextEditingController().obs;
// //   final genrePageController = TextEditingController().obs;

// // // checking variable

// //   RxBool isUserSearchedinHomePage = false.obs;
// //   RxBool isUserSearchedinExplorePage = false.obs;
// //   RxBool isUserSearchedinGenrePage = false.obs;

// // // checking variable

// //   RxString assignString = ''.obs;
// //   RxString assignStringExplore = ''.obs;
// //   RxString assignStringGenre = ''.obs;

// // // Genre Page movies

// //   RxInt genremovieslength = 0.obs;
// //   RxInt genremoviesdisplaylength = 0.obs;
// //   RxBool isloadingmoreGenrePagemovies = false.obs;

// // // Explore Page Fixings
// //   RxBool issearchTagSelected = false.obs;

// //   // Year
// //   RxList year = [].obs;
// //   // For Coloring
// //   RxList yearisactive = [].obs;
// //   RxBool allyearisActive = true.obs;
// //   // Genre
// //   RxList genreId = [].obs;
// //   RxList genreIdisactive = [].obs;
// //   RxBool allgenreisActive = true.obs;
// //   // Country
// //   RxList country = [].obs;
// //   RxList countryisactive = [].obs;
// //   RxBool allcountriesisActive = true.obs;
// //   RxInt initialmovieslength = 8.obs;

// //   // Variable just for update UI on the Explore Page Screen values
// //   RxInt updateUi = 0.obs;
// //   // Fetch More Movies Genre Page
// //   void fetchmoregenremovies() {
// //     isloadingmoreGenrePagemovies(true);
// //     Future.delayed(const Duration(seconds: 2), () {
// //       if (genremovieslength.value - genremoviesdisplaylength.value < 10) {
// //         genremoviesdisplaylength = genremovieslength;
// //       } else {
// //         genremoviesdisplaylength = genremoviesdisplaylength + 4;
// //       }
// //       isloadingmoreGenrePagemovies(false);
// //     });
// //   }

// // // for years
// //   void fetchmoreyears(int length) {
// //     if (yearslength < length) {
// //       yearslength = yearslength + 10;
// //     }
// //   }

// // // for countries
// //   void fetchmorecountries(int length) {
// //     if (countrieslength < length) {
// //       countrieslength = countrieslength + 10;
// //     }
// //   }

// // // Fetch Movies
// //   void fetchmoremovies() {
// //     exploreisfetchingmoremovies(true);
// //     if (initialmovieslength + 8 < exploremovieslength.value) {
// //         initialmovieslength.value = initialmovieslength.value + 8;
// //       } else {
// //         initialmovieslength.value = exploremovieslength.value;
// //       }
// //     exploreisfetchingmoremovies(false);
// //   }

// // // Checklist
// //   Future checklist(String Name, String Id) async {
// //     genreModel!.videoStreamingApp.clear();
// //     await MoviebygenreIdList(Id, "limit");
// //   }

// // // Fetch Genre List
// //   Future<bool> FetchgenreList() async {
// //     try {
// //       var response = await http.get(Uri.parse("$siteurl/genres"), headers: {
// //         'Authorization': 'Bearer $Usertoken',
// //         'token': Usertoken.toString()
// //       });

// //       genreModel = genreModelFromJson(response.body);
// //       isloading(false);
// //       return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       isloadingpopularmovies(false);
// //       ErrorSnackBar(e.toString());
// //       return false;
// //     }
// //   }

// // // Movie by Genre List
// //   Future<void> MoviebygenreIdList(String movieId, String filter) async {
// //     isloadingdetailgenremovies(true);
// //     ismovieavailablein_genremovies(true);
// //     try {
// //       var response =
// //           await http.post(Uri.parse("$siteurl/movies_by_genre"), headers: {
// //         'Authorization': 'Bearer $Usertoken',
// //         'token': Usertoken.toString()
// //       }, body: {
// //         "genre_id": movieId,
// //         "filter": 'all',
// //       });
// //       var jsonResponse = jsonDecode(response.body);
// //       List jsonlist = jsonResponse["VIDEO_STREAMING_APP"];
// //       if (jsonlist.isEmpty || jsonlist.length == 1) {
// //         ismovieavailablein_genremovies(false);
// //       } else {
// //         genremovie_detail = moviegenreDetailmodelFromJson(response.body);
// //       }
// //       isloadingdetailgenremovies(false);
// //       // return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       throw Get.defaultDialog(
// //               title: "Sorry",
// //               content: const Text("We are facing some issues at the moment"))
// //           .then((value) => {Get.back()});
// //     }
// //   }

// // // Update Color

// //   updatecolor(int index) {
// //     isActiveGenreColor(index);
// //   }

// //   updatecolorExplorePage(int index) {
// //     isActiveGenreSelectedExplorePageColor.value = index;
// //     // update();
// //   }

// // // Popular movies List

// //   Future<bool> PopularMoviesList() async {
// //     try {
// //       var response = await http.post(Uri.parse("$siteurl/popular_movies"),
// //           headers: {
// //             'Authorization': 'Bearer $Usertoken',
// //             'token': Usertoken.toString()
// //           });

// //       popularMoviesModel = popularMoviesModelFromJson(response.body);

// //       isloadingpopularmovies(false);
// //       return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       isloadingpopularmovies(false);
// //       ErrorSnackBar(e.toString());

// //       return false;
// //     }
// //   }

// // // Latest movies List

// // // Latest movies list using popular modal because its Same

// //   Future<bool> LatestMoviesList() async {
// //     isloadingplatestmovies(true);
// //     try {
// //       var response = await http.post(Uri.parse("$siteurl/latest_movies"),
// //           headers: {
// //             'Authorization': 'Bearer $Usertoken',
// //             'token': Usertoken.toString()
// //           });

// //       latestMoviesModel = popularMoviesModelFromJson(response.body);
// //       isloadingplatestmovies(false);
// //       return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       isloadingplatestmovies(false);
// //       ErrorSnackBar(e.toString());

// //       return false;
// //     }
// //   }

// // // Movie Detail

// //   Future<bool> MovieDetails(String movieId) async {
// //     try {
// //       isloadingdetailmovies(true);
// //       var response = await http.post(Uri.parse("$siteurl/movies_details"),
// //           headers: {
// //             'Authorization': 'Bearer $Usertoken',
// //             'token': Usertoken.toString()
// //           },
// //           body: {
// //             "movie_id": movieId,
// //             "user_id": userId
// //           });
// //       movie_detail_Model = movieDetailModelFromJson(response.body);
// //       isloadingdetailmovies(false);
// //       return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       isloadingdetailmovies(false);
// //       ErrorSnackBar(e.toString());

// //       return false;
// //     }
// //   }

// // // Movie Play

// //   Future<bool> MoviePlay(String movie, String subtitle) async {
// //     movieurl.value = movie;
// //     subtitleurl.value = subtitle;
// //     // subtitleurl = this.subtitleurl as String;
// //     return true;
// //   }

// // // Fetch all Movies

// //   Future<bool> Fetchallmovies() async {
// //     try {
// //       var response = await http.post(Uri.parse("$siteurl/movies"), headers: {
// //         'Authorization': 'Bearer $Usertoken',
// //         'token': Usertoken.toString(),
// //       }, body: {
// //         "filter": "all",
// //       });
// //       allMoviesModel = moviesModelFromJson(response.body);
// //       explorepageavailablenmovies.value = allMoviesModel!.totalRecords;

// //       // Assigning movies length
// //       exploremovieslength.value = allMoviesModel!.videoStreamingApp.length;
// //       if (exploremovieslength.value > 8) {
// //         initialmovieslength.value = 8;
// //       } else {
// //         initialmovieslength.value = exploremovieslength.value;
// //       }

// //       allMoviesModelExplore =
// //           allMoviesModel!.videoStreamingApp.cast<AllMoviesModelExplore>();
// //       ismoviesloading(false);
// //       return true;
// //     } on SocketException {
// //       throw Get.defaultDialog();
// //     } on TimeoutException {
// //       throw Get.defaultDialog();
// //     } catch (e) {
// //       ismoviesloading(false);
// //       ErrorSnackBar(e.toString());
// //       return false;
// //     }
// //   }

// // // Fetch Movies bt Tags

// //   void fetchmoviesbyTags(String year) {
// //     // allMoviesModel = allMoviesModelcheck;

// //     // allMoviesModel!.videoStreamingApp
// //     //     .where((element) => element.release_date.toLowerCase() == year)
// //     //     .toList();
// //     exploremovieslength.value = 8;
// //     fetchmoremovies();
// //   }

// //   @override
// //   void onInit() async {
// //     super.onInit();
// //     await PopularMoviesList();
// //     await FetchgenreList();
// //     await LatestMoviesList();
// //     await Fetchallmovies();
// //   }
// // }








// // Updated EXPLORE








// // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ///// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









// // import 'dart:async';

// // import 'package:auto_size_text/auto_size_text.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:shimmer/shimmer.dart';
// // import 'package:testapp/controller/movie_controller.dart';
// // import 'package:testapp/videoPlayer/video_player.dart';
// // import 'package:testapp/widgets/movie_card.dart';
// // import '../constants.dart';
// // import '../widgets/custom_textfield.dart';

// // class Explore extends StatefulWidget {
// //   const Explore({super.key});

// //   @override
// //   State<Explore> createState() => _ExploreState();
// // }

// // class _ExploreState extends State<Explore> {
// //   List<String> countries = countriesArray.values.toList();

// //   // Current Year
// //   int totalyears = DateTime.now().year;
// //   bool isLoading = false;
// //   int total = 5;
// //   final TextEditingController _controller = TextEditingController();
// //   final ScrollController _scrollController = ScrollController();
// //   final ScrollController _countriesscrollController = ScrollController();
// //   final ScrollController _yearsscrollController = ScrollController();
// //   final MovieController _movieController = Get.find();
// //   StreamController<int> controller = StreamController<int>();
  

// // // Search Tags

// //   // bool issearchTagSelected = false;

// //   // Scroll Listener

// //   void addmorefuturemovies() {
// //     if (_movieController.exploremovieslength.value <=
// //         _movieController.totalexploreMovies.value - 2) {
// //       _movieController.exploremovieslength.value =
// //           _movieController.exploremovieslength.value + 2;
// //     } else {
// //       _movieController.exploremovieslength.value =
// //           _movieController.totalexploreMovies.value;
// //     }
// //   }

// //   void addmoremovies() {
// //     // Future.delayed(const Duration(milliseconds: 300), () {
// //     addmorefuturemovies();
// //     // });
// //   }

// //   // Future<bool> addmorefuturemovies() async {
// //   //   if (_movieController.exploremovieslength.value <
// //   //       _movieController.totalexploreMovies.value) {
// //   //     Future.delayed(const Duration(seconds: 1), () {
// //   //       int timecheck = 0;
// //   //       Future.delayed(const Duration(milliseconds: 300), () {
// //   //         _movieController.exploremovieslength.value =
// //   //             _movieController.exploremovieslength.value + 6;
// //   //       });
// //   //       print("Total length");
// //   //       print(_movieController.exploremovieslength.value);
// //   //       // setState(() {});
// //   //     });
// //   //   } else {
// //   //     // _movieController.exploremovieslength.value =
// //   //     //     _movieController.totalexploreMovies.value;
// //   //   }
// //   //   return true;
// //   // }

// //   // void addmoremovies() async {
// //   //   await addmorefuturemovies();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     double deviceheight = MediaQuery.of(context).size.height;
// //     double devicewidth = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       body: Container(
// //         padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
// //         child: SafeArea(child: Obx(() {
// //           return NotificationListener(
// //             onNotification: (t) {
// //               if (t is ScrollEndNotification) {
// //                 if (_scrollController.position.maxScrollExtent ==
// //                     _scrollController.position.pixels) {
// //                   addmoremovies();
// //                 }
// //                 if (_countriesscrollController.position.maxScrollExtent ==
// //                     _countriesscrollController.position.pixels) {
// //                   _movieController.fetchmorecountries(countries.length);
// //                 }
// //                 if (_yearsscrollController.position.maxScrollExtent ==
// //                     _yearsscrollController.position.pixels) {
// //                   _movieController.fetchmoreyears(totalyears);
// //                 }
// //               }
// //               return true;
// //             },
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.vertical,
// //               controller: _scrollController,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   // Text Field
// //                   CustomTextField(
// //                     isgenrePage: false,
// //                     ishomePage: false,
// //                   ),

// //                   const SizedBox(height: 20),

// //                   // Search by Tags
// //                   const Text(
// //                     "Search by tags",
// //                     style: TextStyle(color: Colors.white, fontSize: 22),
// //                   ),

// //                   const SizedBox(height: 20),

// //                   // Country Tag
// //                   Obx(() {
// //                     return SizedBox(
// //                       height: 35,
// //                       child: Row(
// //                         children: [
// //                           moviecontroller.isloading.value
// //                               ? Expanded(
// //                                   child: ListView.builder(
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount: 4,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return Shimmer.fromColors(
// //                                           baseColor: boxColor,
// //                                           highlightColor: Colors.white10,
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: boxColor),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                               : Expanded(
// //                                   child: ListView.builder(
// //                                       controller: _countriesscrollController,
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount: _movieController
// //                                           .countrieslength.value,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return InkWell(
// //                                           onTap: () async {
// //                                             if (index != 0) {
// //                                               _movieController
// //                                                   .allcountriesisActive
// //                                                   .value = false;
// //                                               if (_movieController
// //                                                   .countryisactive
// //                                                   .contains(index)) {
// //                                                 int valueIndex =
// //                                                     _movieController
// //                                                         .countryisactive
// //                                                         .indexOf(index);
// //                                                 _movieController.countryisactive
// //                                                     .removeAt(valueIndex);
// //                                                 if (_movieController
// //                                                         .country.length ==
// //                                                     1) {
// //                                                   if (_movieController.genreIdisactive.isEmpty &&
// //                                                       _movieController
// //                                                           .countryisactive
// //                                                           .isEmpty &&
// //                                                       _movieController
// //                                                           .yearisactive
// //                                                           .isEmpty) {
// //                                                     _movieController
// //                                                         .exploremovieslength
// //                                                         .value = 8;
// //                                                     _movieController
// //                                                         .issearchTagSelected
// //                                                         .value = false;
// //                                                   }
// //                                                 }
// //                                                 _movieController.country.remove(
// //                                                     countriesArray.keys
// //                                                         .toList()[index]);

// // // Start

// // // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// // // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }
                                                        
// // // End                                                        
// //                                               } else if (!_movieController
// //                                                   .countryisactive
// //                                                   .contains(index)) {
// //                                                 _movieController.countryisactive
// //                                                     .add(index);
// //                                                 _movieController.country.add(
// //                                                     countriesArray.keys
// //                                                         .toList()[index]);

// // // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 setState(() {});
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = true;
// //                                               }
// //                                             }
// //                                             if (_movieController
// //                                                 .countryisactive.isEmpty) {
// //                                               _movieController
// //                                                   .allcountriesisActive
// //                                                   .value = true;
// //                                               // Checking and if any other tag activated then assing different length

// //                                               if (_movieController
// //                                                           .allyearisActive
// //                                                           .value !=
// //                                                       true &&
// //                                                   _movieController
// //                                                           .allgenreisActive
// //                                                           .value !=
// //                                                       true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;
// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }

// //                                               // For Year
// //                                               else if (_movieController
// //                                                       .allyearisActive.value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                               // For Genre
// //                                               else if (_movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                             }

// //                                             if (index == 0) {
// //                                               _movieController
// //                                                   .allcountriesisActive
// //                                                   .value = true;
// //                                               _movieController.countryisactive
// //                                                   .clear();
// //                                               if (_movieController
// //                                                       .allyearisActive.value &&
// //                                                   _movieController
// //                                                       .allcountriesisActive
// //                                                       .value &&
// //                                                   _movieController
// //                                                       .allgenreisActive.value) {
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = false;
// //                                               }
// //                                               _movieController.country.clear();
// //                                             }
// //                                             setState(() {});
// //                                           },
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: _movieController
// //                                                             .allcountriesisActive
// //                                                             .value &&
// //                                                         index == 0
// //                                                     ? const Color(0xffF5A754)
// //                                                         .withOpacity(0.5)
// //                                                     : _movieController
// //                                                             .countryisactive
// //                                                             .contains(index)
// //                                                         ? const Color(
// //                                                                 0xffF5A754)
// //                                                             .withOpacity(0.5)
// //                                                         : boxColor),
// //                                             child: AutoSizeText(
// //                                               countries[index],
// //                                               textAlign: TextAlign.center,
// //                                               style: const TextStyle(
// //                                                   color: Colors.white,
// //                                                   fontSize: 12),
// //                                             ),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                         ],
// //                       ),
// //                     );
// //                   }),

// //                   const SizedBox(height: 15),

// //                   // Genre Tag

// //                   Obx(() {
// //                     return SizedBox(
// //                       height: 35,
// //                       child: Row(
// //                         children: [
// //                           moviecontroller.isloading.value
// //                               ? Expanded(
// //                                   child: ListView.builder(
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount: 4,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return Shimmer.fromColors(
// //                                           baseColor: boxColor,
// //                                           highlightColor: Colors.white10,
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: boxColor),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                               : Expanded(
// //                                   child: ListView.builder(
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount: moviecontroller.genreModel!
// //                                               .videoStreamingApp.length +
// //                                           1,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return InkWell(
// //                                           onTap: () async {
// //                                             if (index != 0) {
// //                                               _movieController.allgenreisActive
// //                                                   .value = false;
// //                                               if (_movieController
// //                                                   .genreIdisactive
// //                                                   .contains(index)) {
// //                                                 int valueIndex =
// //                                                     _movieController
// //                                                         .genreIdisactive
// //                                                         .indexOf(index);
// //                                                 _movieController.genreIdisactive
// //                                                     .removeAt(valueIndex);

// //                                                 if (_movieController
// //                                                         .genreId.length ==
// //                                                     1) {
// //                                                   if (_movieController.genreIdisactive.isEmpty &&
// //                                                       _movieController
// //                                                           .countryisactive
// //                                                           .isEmpty &&
// //                                                       _movieController
// //                                                           .yearisactive
// //                                                           .isEmpty) {
// //                                                     _movieController
// //                                                         .exploremovieslength
// //                                                         .value = 8;
// //                                                     _movieController
// //                                                         .issearchTagSelected
// //                                                         .value = false;
// //                                                     setState(() {});
// //                                                   }
// //                                                 }
// //                                                 _movieController.genreId.remove(
// //                                                     moviecontroller
// //                                                         .genreModel!
// //                                                         .videoStreamingApp[
// //                                                             index - 1]
// //                                                         .genreId
// //                                                         .toString());
// // // Start

// // // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// // // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }
                                                        
// // // End
// //                                               } else if (!_movieController
// //                                                   .genreIdisactive
// //                                                   .contains(index)) {
// //                                                 _movieController.genreIdisactive
// //                                                     .add(index);
// //                                                 _movieController.genreId.add(
// //                                                     moviecontroller
// //                                                         .genreModel!
// //                                                         .videoStreamingApp[
// //                                                             index - 1]
// //                                                         .genreId
// //                                                         .toString());

// // // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// // // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 setState(() {});
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = true;
// //                                               }
// //                                             }

// //                                             if (_movieController
// //                                                 .genreIdisactive.isEmpty) {
// //                                               _movieController.allgenreisActive
// //                                                   .value = true;

// //                                               // Checking and if any other tag activated then assing different length

// //                                               // For Both Year / Country
// //                                               if (_movieController
// //                                                           .allyearisActive
// //                                                           .value !=
// //                                                       true &&
// //                                                   _movieController
// //                                                           .allcountriesisActive
// //                                                           .value !=
// //                                                       true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;
// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }

// //                                               // For Year
// //                                               else if (_movieController
// //                                                       .allyearisActive.value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                               // For Country
// //                                               else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                             }

// //                                             if (index == 0) {
// //                                               _movieController.allgenreisActive
// //                                                   .value = true;
// //                                               _movieController.genreIdisactive
// //                                                   .clear();
// //                                               if (_movieController
// //                                                       .allyearisActive.value &&
// //                                                   _movieController
// //                                                       .allcountriesisActive
// //                                                       .value &&
// //                                                   _movieController
// //                                                       .allgenreisActive.value) {
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = false;
// //                                               }
// //                                               _movieController.genreId.clear();
// //                                             }
// //                                             setState(() {});
// //                                           },
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: _movieController
// //                                                             .allgenreisActive
// //                                                             .value &&
// //                                                         index == 0
// //                                                     ? const Color(0xffF5A754)
// //                                                         .withOpacity(0.5)
// //                                                     : _movieController
// //                                                             .genreIdisactive
// //                                                             .contains(index)
// //                                                         ? const Color(
// //                                                                 0xffF5A754)
// //                                                             .withOpacity(0.5)
// //                                                         : boxColor),
// //                                             child: index == 0
// //                                                 ? const AutoSizeText(
// //                                                     "All Genre",
// //                                                     textAlign: TextAlign.center,
// //                                                     style: TextStyle(
// //                                                         color: Colors.white,
// //                                                         fontSize: 12),
// //                                                   )
// //                                                 : AutoSizeText(
// //                                                     moviecontroller
// //                                                         .genreModel!
// //                                                         .videoStreamingApp[
// //                                                             index - 1]
// //                                                         .genreName,
// //                                                     textAlign: TextAlign.center,
// //                                                     style: const TextStyle(
// //                                                         color: Colors.white,
// //                                                         fontSize: 12),
// //                                                   ),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                         ],
// //                       ),
// //                     );
// //                   }),

// //                   const SizedBox(height: 15),

// //                   // Years Tag

// //                   Obx(() {
// //                     return SizedBox(
// //                       height: 35,
// //                       child: Row(
// //                         children: [
// //                           moviecontroller.isloading.value
// //                               ? Expanded(
// //                                   child: ListView.builder(
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount: 4,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return Shimmer.fromColors(
// //                                           baseColor: boxColor,
// //                                           highlightColor: Colors.white10,
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: boxColor),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                               : Expanded(
// //                                   child: ListView.builder(
// //                                       controller: _yearsscrollController,
// //                                       scrollDirection: Axis.horizontal,
// //                                       itemCount:
// //                                           _movieController.yearslength.value,
// //                                       itemBuilder:
// //                                           (BuildContext context, index) {
// //                                         return InkWell(
// //                                           onTap: () async {
// //                                             if (index != 0) {
// //                                               _movieController.allyearisActive
// //                                                   .value = false;

// //                                               if (_movieController.yearisactive
// //                                                   .contains(index)) {
// //                                                 int valueIndex =
// //                                                     _movieController
// //                                                         .yearisactive
// //                                                         .indexOf(index);

// //                                                 _movieController.yearisactive
// //                                                     .removeAt(valueIndex);

// //                                                 if (_movieController
// //                                                         .year.length ==
// //                                                     1) {
// //                                                   if (_movieController.genreIdisactive.isEmpty &&
// //                                                       _movieController
// //                                                           .countryisactive
// //                                                           .isEmpty &&
// //                                                       _movieController
// //                                                           .yearisactive
// //                                                           .isEmpty) {
// //                                                     _movieController
// //                                                         .exploremovieslength
// //                                                         .value = 8;
// //                                                     _movieController
// //                                                         .issearchTagSelected
// //                                                         .value = false;
// //                                                   }
// //                                                 }
// //                                                 _movieController.year.remove(
// //                                                     (totalyears - index)
// //                                                         .toString());

// // // Start

// // // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// // // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }
                                                        
// // // End
                                                        
// //                                               } else if (!_movieController
// //                                                   .yearisactive
// //                                                   .contains(index)) {
// //                                                 _movieController.yearisactive
// //                                                     .add(index);
// //                                                 _movieController.year.add(
// //                                                     (totalyears - index)
// //                                                         .toString());

// //                                                 // Checking and Assigning length before its important for exception

// //                                                 if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// // // All Values availabe
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Year / Country
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 // Year / Genre

// //                                                 else if (_movieController
// //                                                             .allyearisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) &&
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                     // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) &&
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 //  Country / Genre
// //                                                 else if (_movieController
// //                                                             .allcountriesisActive
// //                                                             .value !=
// //                                                         true &&
// //                                                     _movieController
// //                                                             .allgenreisActive
// //                                                             .value !=
// //                                                         true) {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) &&
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) &&
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 } else {
// //                                                   if (_movieController
// //                                                           .exploremovieslength
// //                                                           .value >
// //                                                       _movieController
// //                                                           .allMoviesModel!
// //                                                           .videoStreamingApp
// //                                                           .where((element) {
// //                                                             return (_movieController
// //                                                                     .year
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .release_date) ||
// //                                                                 _movieController
// //                                                                     .genreId
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .movie_genre_id) ||
// //                                                                 _movieController
// //                                                                     .country
// //                                                                     .contains(
// //                                                                         element
// //                                                                             .country_of_origin));
// //                                                           })
// //                                                           .toList()
// //                                                           .length) {
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;

// //                                                     // Assign total length
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .exploremovieslength
// //                                                             .value;
// //                                                   } else {
// //                                                     _movieController
// //                                                             .totalexploreMovies
// //                                                             .value =
// //                                                         _movieController
// //                                                             .allMoviesModel!
// //                                                             .videoStreamingApp
// //                                                             .where((element) {
// //                                                               return (_movieController
// //                                                                       .year
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .release_date) ||
// //                                                                   _movieController
// //                                                                       .genreId
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .movie_genre_id) ||
// //                                                                   _movieController
// //                                                                       .country
// //                                                                       .contains(
// //                                                                           element
// //                                                                               .country_of_origin));
// //                                                             })
// //                                                             .toList()
// //                                                             .length;
// //                                                   }
// //                                                 }

// //                                                 setState(() {});
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = true;
// //                                               }
// //                                             }

// //                                             if (_movieController
// //                                                 .yearisactive.isEmpty) {
// //                                               _movieController
// //                                                   .allyearisActive.value = true;
// //                                               // Checking and if any other tag activated then assing different length

// //                                               // For Both Genre / Country
// //                                               if (_movieController
// //                                                           .allgenreisActive
// //                                                           .value !=
// //                                                       true &&
// //                                                   _movieController
// //                                                           .allcountriesisActive
// //                                                           .value !=
// //                                                       true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;
// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }

// //                                               // For Year
// //                                               else if (_movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                               // For Country
// //                                               else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true) {
// //                                                 _movieController
// //                                                         .totalexploreMovies
// //                                                         .value =
// //                                                     _movieController
// //                                                         .allMoviesModel!
// //                                                         .videoStreamingApp
// //                                                         .where((element) {
// //                                                           return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                         })
// //                                                         .toList()
// //                                                         .length;

// //                                                 if (_movieController
// //                                                         .totalexploreMovies
// //                                                         .value >
// //                                                     _movieController
// //                                                             .exploremovieslength
// //                                                             .value +
// //                                                         8) {
// //                                                   _movieController
// //                                                       .exploremovieslength
// //                                                       .value = 8;
// //                                                 } else {
// //                                                   _movieController
// //                                                           .exploremovieslength
// //                                                           .value =
// //                                                       _movieController
// //                                                           .totalexploreMovies
// //                                                           .value;
// //                                                 }
// //                                               }
// //                                             }

// //                                             if (index == 0) {
// //                                               _movieController
// //                                                   .allyearisActive.value = true;
// //                                               _movieController.yearisactive
// //                                                   .clear();
// //                                               if (_movieController
// //                                                       .allyearisActive.value &&
// //                                                   _movieController
// //                                                       .allcountriesisActive
// //                                                       .value &&
// //                                                   _movieController
// //                                                       .allgenreisActive.value) {
// //                                                 _movieController
// //                                                     .issearchTagSelected
// //                                                     .value = false;
// //                                               }
// //                                               _movieController.year.clear();
// //                                             }
// //                                             setState(() {});
// //                                           },
// //                                           child: Container(
// //                                             height: 35,
// //                                             width: devicewidth * 0.25,
// //                                             alignment: Alignment.center,
// //                                             margin: const EdgeInsets.symmetric(
// //                                                 horizontal: 5),
// //                                             decoration: BoxDecoration(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                                 color: _movieController
// //                                                             .allyearisActive
// //                                                             .value &&
// //                                                         index == 0
// //                                                     ? const Color(0xffF5A754)
// //                                                         .withOpacity(0.5)
// //                                                     : _movieController
// //                                                             .yearisactive
// //                                                             .contains(index)
// //                                                         ? const Color(
// //                                                                 0xffF5A754)
// //                                                             .withOpacity(0.5)
// //                                                         : boxColor),
// //                                             child: index == 0
// //                                                 ? const AutoSizeText(
// //                                                     "All Years",
// //                                                     style: TextStyle(
// //                                                         color: Colors.white,
// //                                                         fontSize: 12),
// //                                                   )
// //                                                 : AutoSizeText(
// //                                                     (totalyears - index)
// //                                                         .toString(),
// //                                                     style: const TextStyle(
// //                                                         color: Colors.white,
// //                                                         fontSize: 12),
// //                                                   ),
// //                                           ),
// //                                         );
// //                                       }),
// //                                 )
// //                         ],
// //                       ),
// //                     );
// //                   }),

// //                   const SizedBox(height: 20),

// //                   const AutoSizeText(
// //                     "Movies",
// //                     style: TextStyle(color: Colors.white, fontSize: 22),
// //                   ),

// //                   const SizedBox(height: 20),

// //                   _movieController.ismoviesloading.value
// //                       ? GridView(
// //                           physics: const NeverScrollableScrollPhysics(),
// //                           shrinkWrap: true,
// //                           gridDelegate:
// //                               const SliverGridDelegateWithFixedCrossAxisCount(
// //                                   mainAxisSpacing: 5.0,
// //                                   crossAxisSpacing: 10.0,
// //                                   crossAxisCount: 2,
// //                                   childAspectRatio: 100 / 140),
// //                           children: List.generate(6, (index) {
// //                             return Column(
// //                               children: [
// //                                 SizedBox(
// //                                   height: 150,
// //                                   child: Shimmer.fromColors(
// //                                     baseColor: boxColor,
// //                                     highlightColor: Colors.white10,
// //                                     child: Container(
// //                                       height: 150,
// //                                       width: double.infinity,
// //                                       decoration: BoxDecoration(
// //                                           color: boxColor,
// //                                           borderRadius:
// //                                               BorderRadius.circular(10.0)),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             );
// //                           }))
// //                       : Obx(() {
// //                           return GridView(
// //                               physics: const NeverScrollableScrollPhysics(),
// //                               shrinkWrap: true,
// //                               gridDelegate:
// //                                   SliverGridDelegateWithFixedCrossAxisCount(
// //                                       mainAxisSpacing: 5.0,
// //                                       crossAxisSpacing: 20.0,
// //                                       crossAxisCount: 2,
// //                                       childAspectRatio: deviceheight < 550
// //                                           ? 100 / 200
// //                                           : 100 / 150),
// //                               children: _movieController
// //                                       .issearchTagSelected.value
// //                                   ? _movieController
// //                                           .isUserSearchedinExplorePage.value

// //                                       // Movies with Searched Value

// //                                       ? List.generate(
// //                                           _movieController.exploremovieslength
// //                                               .value, (index) {
// //                                           if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allyearisActive.value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }
// //                                           //  Year / Country
// //                                           else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allyearisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return ((_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) &&
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }

// //                                           // Year / Genre

// //                                           else if (_movieController
// //                                                       .allyearisActive.value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return ((_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase())));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }

// //                                           //  Country / Genre
// //                                           else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return ((_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase())));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           } else {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return ((_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) ||
// //                                                               _movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id) ||
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase()));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) ||
// //                                                               _movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id) ||
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) ||
// //                                                               _movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id) ||
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                                   .year
// //                                                                   .contains(element
// //                                                                       .release_date) ||
// //                                                               _movieController
// //                                                                   .genreId
// //                                                                   .contains(element
// //                                                                       .movie_genre_id) ||
// //                                                               _movieController
// //                                                                   .country
// //                                                                   .contains(element
// //                                                                       .country_of_origin)) &&
// //                                                           element.movieTitle
// //                                                               .toLowerCase()
// //                                                               .contains(moviecontroller
// //                                                                   .assignStringExplore
// //                                                                   .value
// //                                                                   .toLowerCase());
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }
// //                                         })
// //                                       :

// //                                       // Movies without searched value
// //                                       List.generate(
// //                                           _movieController.exploremovieslength
// //                                               .value, (index) {
// //                                           if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allyearisActive.value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }

// //                                           //  Year / Country
// //                                           else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allyearisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }

// //                                           // Year / Genre

// //                                           else if (_movieController
// //                                                       .allyearisActive.value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) &&
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }

// //                                           //  Country / Genre
// //                                           else if (_movieController
// //                                                       .allcountriesisActive
// //                                                       .value !=
// //                                                   true &&
// //                                               _movieController
// //                                                       .allgenreisActive.value !=
// //                                                   true) {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) &&
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           } else {
// //                                             return MovieCardWidget(
// //                                                 movieId: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return (_movieController
// //                                                               .year
// //                                                               .contains(element
// //                                                                   .release_date) ||
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) ||
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin));
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieId,
// //                                                 title: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) ||
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) ||
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .movieTitle,
// //                                                 imgurl: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) ||
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) ||
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .moviePoster,
// //                                                 releasedate: _movieController
// //                                                     .allMoviesModel!
// //                                                     .videoStreamingApp
// //                                                     .where((element) {
// //                                                       return _movieController.year.contains(element
// //                                                               .release_date) ||
// //                                                           _movieController
// //                                                               .genreId
// //                                                               .contains(element
// //                                                                   .movie_genre_id) ||
// //                                                           _movieController
// //                                                               .country
// //                                                               .contains(element
// //                                                                   .country_of_origin);
// //                                                     })
// //                                                     .toList()[index]
// //                                                     .release_date);
// //                                           }
// //                                         })
// //                                   : _movieController
// //                                           .isUserSearchedinExplorePage.value
// //                                       ? List.generate(
// //                                           _movieController.exploremovieslength
// //                                               .value, (index) {
// //                                           return MovieCardWidget(
// //                                             movieId: _movieController
// //                                                 .allMoviesModel!
// //                                                 .videoStreamingApp
// //                                                 .where((element) {
// //                                                   return element.movieTitle
// //                                                       .toLowerCase()
// //                                                       .contains(moviecontroller
// //                                                           .assignStringExplore
// //                                                           .value
// //                                                           .toLowerCase());
// //                                                 })
// //                                                 .toList()[index]
// //                                                 .movieId,
// //                                             title: _movieController
// //                                                 .allMoviesModel!
// //                                                 .videoStreamingApp
// //                                                 .where((element) {
// //                                                   return element.movieTitle
// //                                                       .toLowerCase()
// //                                                       .contains(moviecontroller
// //                                                           .assignStringExplore
// //                                                           .value
// //                                                           .toLowerCase());
// //                                                 })
// //                                                 .toList()[index]
// //                                                 .movieTitle,
// //                                             imgurl: _movieController
// //                                                 .allMoviesModel!
// //                                                 .videoStreamingApp
// //                                                 .where((element) {
// //                                                   return element.movieTitle
// //                                                       .toLowerCase()
// //                                                       .contains(moviecontroller
// //                                                           .assignStringExplore
// //                                                           .value
// //                                                           .toLowerCase());
// //                                                 })
// //                                                 .toList()[index]
// //                                                 .moviePoster,
// //                                             releasedate: _movieController
// //                                                 .allMoviesModel!
// //                                                 .videoStreamingApp[index]
// //                                                 .release_date,
// //                                           );
// //                                         })
// //                                       : List.generate(
// //                                           _movieController.exploremovieslength
// //                                               .value, (index) {
// //                                           return MovieCardWidget(
// //                                               movieId: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp[index]
// //                                                   .movieId,
// //                                               title: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp[index]
// //                                                   .movieTitle,
// //                                               imgurl: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp[index]
// //                                                   .moviePoster,
// //                                               releasedate: _movieController
// //                                                   .allMoviesModel!
// //                                                   .videoStreamingApp[index]
// //                                                   .release_date);
// //                                         }));
// //                         }),

// //                   _movieController.exploreisfetchingmoremovies.value
// //                       ? Container(
// //                           height: 50,
// //                           width: double.infinity,
// //                           alignment: Alignment.center,
// //                           child: const CircularProgressIndicator(
// //                             color: Colors.orangeAccent,
// //                           ),
// //                         )
// //                       : const SizedBox()
// //                 ],
// //               ),
// //             ),
// //           );
// //         })),
// //       ),

// //       // floatingActionButton: FloatingActionButton(onPressed: (() => print(deviceheight)))
// //     );
// //   }
// // }
