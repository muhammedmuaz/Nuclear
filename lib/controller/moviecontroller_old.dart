// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:testapp/model/PopularMovies_Model.dart';
// import 'package:testapp/model/allshowsmodel.dart';
// import 'package:testapp/model/genre_model.dart';
// import 'package:testapp/model/homepage_model.dart';
// import 'package:testapp/model/movie_detail_model.dart';
// import 'package:testapp/model/moviegenre_detailmodel.dart';
// import 'package:testapp/model/moviesmodel.dart';
// import '../constants.dart';

// //  await homepagesection();
// //     await PopularMoviesList();
// //     await FetchgenreList();
// //     await LatestMoviesList();
// //     await Fetchallmovies();
// //     await Fetchallshows();

// class MovieController extends GetxController {
//   RxBool isloading = true.obs;
//   RxBool ismoviesloading = true.obs;
//   RxBool isloadingpopularmovies = true.obs;
//   RxBool isloadingdetailmovies = true.obs;
//   RxBool isloadingdetailgenremovies = true.obs;
//   // ignore: non_constant_identifier_names
//   RxBool ismovieavailablein_genremovies = true.obs;
//   RxBool isloadingplatestmovies = true.obs;
//   RxBool isloadingpshows = true.obs;
//   RxInt isActiveGenreColor = 0.obs;
//   RxInt isActiveGenreSelectedExplorePageColor = 0.obs;
//   RxString movieurl = ''.obs;
//   RxString subtitleurl = ''.obs;

//   GenreModel? genreModel;
//   MoviegenreDetailmodel? genremovie_detail;
//   PopularMoviesModel? popularMoviesModel;
//   PopularMoviesModel? latestMoviesModel;
//   HomePageModel? homepagemovies;
//   AllShowsModel? allshows;
//   // ignore: non_constant_identifier_names
//   MovieDetailModel? movie_detail_Model;
//   MoviesModel? allMoviesModel;
//   // MoviesModel? allMoviesModelcheck;
//   List<AllMoviesModelExplore>? allMoviesModelExplore;
// //  List loading circular logics
// //  for movies
//   RxInt exploremovieslength = 8.obs;
//   RxInt explorepageavailablenmovies = 0.obs;
//   RxInt homePagemovieslength = 8.obs;
//   // RxInt displaymovies = 1.obs;
//   RxBool exploreisfetchingmoremovies = false.obs;
// // for countries search tags
//   RxInt countrieslength = 8.obs;
// // for countries search tags
//   RxInt yearslength = 8.obs;

// // Search Text Editing Controller

//   final homePageController = TextEditingController().obs;
//   final explorePageController = TextEditingController().obs;
//   final genrePageController = TextEditingController().obs;
//   final showPageController = TextEditingController().obs;

// // checking variable

//   RxBool isUserSearchedinHomePage = false.obs;
//   RxBool isUserSearchedinExplorePage = false.obs;
//   RxBool isUserSearchedinGenrePage = false.obs;
//   RxBool isUserSearchedinShowPage = false.obs;

// // checking variable

//   RxString assignString = ''.obs;
//   RxString assignStringExplore = ''.obs;
//   RxString assignStringGenre = ''.obs;

// // Genre Page movies

//   RxInt genremovieslength = 0.obs;
//   RxInt genremoviesdisplaylength = 0.obs;
//   RxBool isloadingmoreGenrePagemovies = false.obs;

// // Explore Page Fixings
//   RxBool issearchTagSelected = false.obs;

//   // Year
//   RxList year = [].obs;
//   // For Coloring
//   RxList yearisactive = [].obs;
//   RxBool allyearisActive = true.obs;
//   // Genre
//   RxList genreId = [].obs;
//   RxList genreIdisactive = [].obs;
//   RxBool allgenreisActive = true.obs;
//   // Country
//   RxList country = [].obs;
//   RxList countryisactive = [].obs;
//   RxBool allcountriesisActive = true.obs;
//   // Variable just for update UI on the Explore Page Screen values
//   RxInt updateUi = 0.obs;

//   // for countries search tags
//   RxInt totalexploreMovies = 0.obs;

//   // Checking Network Connection
//   RxBool isnetworkConnected = false.obs;

//   // HomePage fetch data circular condition
//   RxBool isloadinghomepageApi = true.obs;
//   RxBool isloadingmodal_active = false.obs;

//   RxBool isexception_thrown = false.obs;
// // Is Tried
//   RxBool istried = true.obs;

//   // Fetch More Movies Genre Page
//   void fetchmoregenremovies() {
//     isloadingmoreGenrePagemovies(true);
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (genremovieslength.value - genremoviesdisplaylength.value < 10) {
//         genremoviesdisplaylength = genremovieslength;
//       } else {
//         genremoviesdisplaylength = genremoviesdisplaylength + 2;
//       }
//       isloadingmoreGenrePagemovies(false);
//     });
//   }

// // for years
//   void fetchmoreyears(int length) {
//     if (yearslength < length) {
//       yearslength = yearslength + 10;
//     }
//   }

// // for countries
//   void fetchmorecountries(int length) {
//     if (countrieslength < length) {
//       countrieslength = countrieslength + 10;
//     }
//   }

// // Fetch Movies
//   void fetchmoremovies(int totalmovies) {
//     exploreisfetchingmoremovies(true);
//     Future.delayed(const Duration(seconds: 1), () {
//       if (exploremovieslength < totalmovies &&
//           exploremovieslength < explorepageavailablenmovies.value) {
//         if (exploremovieslength.value + 10 >
//             explorepageavailablenmovies.value) {
//           exploremovieslength.value = explorepageavailablenmovies.value;
//         } else {
//           exploremovieslength = exploremovieslength + 8;
//           homePagemovieslength = homePagemovieslength + 8;
//         }
//       }
//       exploreisfetchingmoremovies(false);
//     });
//   }

// // Checklist
//   Future checklist(String Name, String Id) async {
//     genreModel!.videoStreamingApp.clear();
//     await MoviebygenreIdList(Id, "limit");
//   }

// // Fetch Genre List
//   Future<bool> FetchgenreList() async {
//     try {
//       var response = await http.get(Uri.parse("$siteurl/genres"), headers: {
//         'Authorization': 'Bearer $Usertoken',
//         'token': Usertoken.toString()
//       });

//       genreModel = genreModelFromJson(response.body);
//       isloading(false);
//       return true;
//     } on SocketException {
//       if (!isexception_thrown.value) {
//         isexception_thrown.value = true;
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                         // colorFilter:
//                         //     ColorFilter.mode(isActiveColor, BlendMode.srcIn)
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             try {
//               isexception_thrown(false);
//               isloadingmodal_active(true);
//               await homepagesection();
//               await PopularMoviesList();
//               await FetchgenreList();
//               await LatestMoviesList();
//               await Fetchallmovies();
//               await Fetchallshows();
//               isloadingmodal_active(false);
//               Navigator.of(Get.overlayContext!).pop();
//               return;
//             } catch (e) {
//               isexception_thrown(false);
//               isloadingmodal_active(false);
//             }
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       isloadingpopularmovies(false);
//       ErrorSnackBar(e.toString());
//       return false;
//     }
//   }

// // Movie by Genre List
//   Future<void> MoviebygenreIdList(String movieId, String filter) async {
//     isloadingdetailgenremovies(true);
//     ismovieavailablein_genremovies(true);
//     try {
//       var response =
//           await http.post(Uri.parse("$siteurl/movies_by_genre"), headers: {
//         'Authorization': 'Bearer $Usertoken',
//         'token': Usertoken.toString()
//       }, body: {
//         "genre_id": movieId,
//         "filter": 'all',
//       });
//       var jsonResponse = jsonDecode(response.body);
//       List jsonlist = jsonResponse["VIDEO_STREAMING_APP"];
//       if (jsonlist.isEmpty || jsonlist.length == 1) {
//         ismovieavailablein_genremovies(false);
//       } else {
//         genremovie_detail = moviegenreDetailmodelFromJson(response.body);
//       }
//       isloadingdetailgenremovies(false);
//     } on SocketException {
//       throw Get.defaultDialog();
//     } catch (e) {
//       throw Get.defaultDialog(
//               title: "Sorry",
//               content: const Text("We are facing some issues at the moment"))
//           .then((value) => {Get.back()});
//     }
//   }

// // Update Color

//   updatecolor(int index) {
//     isActiveGenreColor(index);
//   }

//   updatecolorExplorePage(int index) {
//     isActiveGenreSelectedExplorePageColor.value = index;
//     // update();
//   }

// // Popular movies List

//   Future<bool> PopularMoviesList() async {
//     try {
//       var response = await http.post(Uri.parse("$siteurl/popular_movies"),
//           headers: {
//             'Authorization': 'Bearer $Usertoken',
//             'token': Usertoken.toString()
//           });

//       popularMoviesModel = popularMoviesModelFromJson(response.body);

//       isloadingpopularmovies(false);
//       return true;
//     } on SocketException {
//       if (!isexception_thrown.value) {
//         isexception_thrown.value = true;
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                         // colorFilter:
//                         //     ColorFilter.mode(isActiveColor, BlendMode.srcIn)
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             isexception_thrown(false);
//             isloadingmodal_active(true);
//             await homepagesection();
//             await PopularMoviesList();
//             await FetchgenreList();
//             await LatestMoviesList();
//             await Fetchallmovies();
//             await Fetchallshows();
//             isloadingmodal_active(false);
//             Navigator.of(Get.overlayContext!).pop();
//             return;
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       isloadingpopularmovies(false);
//       ErrorSnackBar(e.toString());
//       return false;
//     }
//   }

// // Latest movies List

// // Latest movies list using popular modal because its Same

//   Future<bool> LatestMoviesList() async {
//     isloadingplatestmovies(true);
//     try {
//       var response = await http.post(Uri.parse("$siteurl/latest_movies"),
//           headers: {
//             'Authorization': 'Bearer $Usertoken',
//             'token': Usertoken.toString()
//           });

//       latestMoviesModel = popularMoviesModelFromJson(response.body);
//       isloadingplatestmovies(false);
//       return true;
//     } on SocketException {
//       if (!isexception_thrown.value) {
//         isexception_thrown.value = true;
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                         // colorFilter:
//                         //     ColorFilter.mode(isActiveColor, BlendMode.srcIn)
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             isexception_thrown(false);
//             isloadingmodal_active(true);
//             await homepagesection();
//             await PopularMoviesList();
//             await FetchgenreList();
//             await LatestMoviesList();
//             await Fetchallmovies();
//             await Fetchallshows();
//             isloadingmodal_active(false);
//             Navigator.of(Get.overlayContext!).pop();
//             return;
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       isloadingplatestmovies(false);
//       ErrorSnackBar(e.toString());

//       return false;
//     }
//   }

// // Movie Detail

//   Future<bool> MovieDetails(String movieId) async {
//     try {
//       isloadingdetailmovies(true);
//       var response = await http.post(Uri.parse("$siteurl/movies_details"),
//           headers: {
//             'Authorization': 'Bearer $Usertoken',
//             'token': Usertoken.toString()
//           },
//           body: {
//             "movie_id": movieId,
//             "user_id": userId
//           });
//       movie_detail_Model = movieDetailModelFromJson(response.body);
//       isloadingdetailmovies(false);
//       return true;
//     } on SocketException {
//       throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: isActiveColor,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: isActiveColor, width: 1.0),
//                     image: DecorationImage(
//                         image: const AssetImage("assets/error.png"),
//                         scale: 2,
//                         colorFilter:
//                             ColorFilter.mode(isActiveColor, BlendMode.srcIn))),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(
//                 "Error!",
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text("Network Error",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: Colors.black,
//                   )),
//             ],
//           ));
//     } catch (e) {
//       isloadingdetailmovies(false);
//       ErrorSnackBar(e.toString());

//       return false;
//     }
//   }

// // Movie Play

//   Future<bool> MoviePlay(String movie, String subtitle) async {
//     movieurl.value = movie;
//     subtitleurl.value = subtitle;
//     return true;
//   }

// // Fetch all Movies

//   Future<bool> Fetchallmovies() async {
//     try {
//       var response = await http.post(Uri.parse("$siteurl/movies"), headers: {
//         'Authorization': 'Bearer $Usertoken',
//         'token': Usertoken.toString(),
//       }, body: {
//         "filter": "all",
//       });
//       allMoviesModel = moviesModelFromJson(response.body);
//       explorepageavailablenmovies.value = allMoviesModel!.totalRecords;
//       allMoviesModelExplore =
//           allMoviesModel!.videoStreamingApp.cast<AllMoviesModelExplore>();
//       totalexploreMovies.value = allMoviesModel!.totalRecords;
//       ismoviesloading(false);
//       return true;
//     } on SocketException {
//       if (!isexception_thrown.value) {
//         isexception_thrown.value = true;
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             isexception_thrown(false);
//             isloadingmodal_active(true);
//             await homepagesection();
//             await PopularMoviesList();
//             await FetchgenreList();
//             await LatestMoviesList();
//             await Fetchallmovies();
//             await Fetchallshows();
//             isloadingmodal_active(false);
//             Navigator.of(Get.overlayContext!).pop();
//             return;
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       ismoviesloading(false);
//       ErrorSnackBar(e.toString());
//       return false;
//     }
//   }

// // Fetch all Shows

//   Future<bool> Fetchallshows() async {
//     try {
//       isloadingpshows(true);
//       var response = await http.post(Uri.parse("$siteurl/shows"), headers: {
//         'Authorization': 'Bearer $Usertoken',
//         'token': Usertoken.toString(),
//       });
//       allshows = allShowsModelFromJson(response.body);
//       isloadingpshows(false);
//       return true;
//     } on SocketException {
//       if (!isexception_thrown.value) {
//         isexception_thrown.value = true;
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             isexception_thrown(false);
//             isloadingmodal_active(true);
//             await homepagesection();
//             await PopularMoviesList();
//             await FetchgenreList();
//             await LatestMoviesList();
//             await Fetchallmovies();
//             await Fetchallshows();
//             isloadingmodal_active(false);
//             Navigator.of(Get.overlayContext!).pop();
//             return;
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       isloadingpshows(false);
//       ErrorSnackBar(e.toString());
//       return false;
//     }
//   }

// // Fetch Movies bt Tags

//   void fetchmoviesbyTags(String year) {
//     exploremovieslength.value = 8;
//     fetchmoremovies(allMoviesModel!.videoStreamingApp.length);
//   }

// // Fetch HomePage Movies

//   Future<bool> homepagesection() async {
//     try {
//       isloadinghomepageApi(true);
//       var response = await http.post(Uri.parse("$siteurl/home"), headers: {
//         'Authorization': 'Bearer $Usertoken',
//         'token': Usertoken.toString(),
//       }, body: {
//         "user_id": userId,
//       });
//       homepagemovies = homePageModelFromJson(response.body);
//       isloadinghomepageApi(false);
//       return true;
//     } on SocketException {
//       isexception_thrown(true);
//       void changeistried() {
//         istried(false);
//       }

//       if (isexception_thrown.value) {
//         throw Get.defaultDialog(
//           title: "",
//           radius: 50,
//           backgroundColor: const Color(0xff707070).withOpacity(0.93),
//           content: Obx(() {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: isActiveColor,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: isActiveColor, width: 1.0),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/error.png"),
//                         scale: 2,
//                         // colorFilter:
//                         //     ColorFilter.mode(isActiveColor, BlendMode.srcIn)
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   "Error!",
//                   style: GoogleFonts.poppins(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text("Network Error",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                     )),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(
//                   "Please check your Internet connection and try Again",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 isloadingmodal_active.value
//                     ? Image.asset(
//                         "assets/loadingicon.gif",
//                         color: const Color(0xffd75a4a),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }),
//           onConfirm: () async {
//             if (istried.value) {
//               changeistried();
//               try {
//                 isloadingmodal_active(true);
//                 await homepagesection();
//                 await PopularMoviesList();
//                 await FetchgenreList();
//                 await LatestMoviesList();
//                 await Fetchallmovies();
//                 await Fetchallshows();
//                 isloadingmodal_active(false);
//                 Navigator.of(Get.overlayContext!).pop();
//                 return;
//               } catch (e) {
//                 isexception_thrown(false);
//                 isloadingmodal_active(false);
//               }
//             }
//           },
//           onCancel: () {
//             exit(1);
//           },
//           textConfirm: "Try Again",
//           textCancel: "Quit",
//           buttonColor: const Color(0xffd75a4a),
//           confirmTextColor: Colors.white,
//           cancelTextColor: const Color(0xffd75a4a),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       isloadinghomepageApi(false);
//       ErrorSnackBar(e.toString());
//       return false;
//     }
//   }

//   @override
//   void onInit() async {
//     super.onInit();
//     await homepagesection();
//     // await PopularMoviesList();
//     // await FetchgenreList();
//     // await LatestMoviesList();
//     // await Fetchallmovies();
//     // await Fetchallshows();
//   }
// }
