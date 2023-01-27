import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:testapp/model/PopularMovies_Model.dart';
import 'package:testapp/model/allshowsmodel.dart';
import 'package:testapp/model/genre_model.dart';
import 'package:testapp/model/homepage_model.dart';
import 'package:testapp/model/movie_detail_model.dart';
import 'package:testapp/model/moviegenre_detailmodel.dart';
import 'package:testapp/model/moviesmodel.dart';
import 'package:testapp/services/remote_services.dart';
import '../constants.dart';

class MovieController extends GetxController {
  RxBool isloading = true.obs;
  RxBool ismoviesloading = true.obs;
  RxBool isloadingpopularmovies = true.obs;
  RxBool isloadingdetailmovies = true.obs;
  RxBool isloadingdetailgenremovies = true.obs;
  RxBool ismovieavailablein_genremovies = true.obs;
  RxBool isloadingplatestmovies = true.obs;
  RxBool isloadingpshows = true.obs;
  RxInt isActiveGenreColor = 0.obs;
  RxInt isActiveGenreSelectedExplorePageColor = 0.obs;
  RxString movieurl = ''.obs;
  RxString subtitleurl = ''.obs;

  GenreModel? genreModel;
  MoviegenreDetailmodel? genremovie_detail;
  PopularMoviesModel? popularMoviesModel;
  PopularMoviesModel? latestMoviesModel;
  HomePageModel? homepagemovies;
  // ignore: non_constant_identifier_names
  MovieDetailModel? movie_detail_Model;
  MoviesModel? allMoviesModel;
  // MoviesModel? allMoviesModelcheck;
  List<AllMoviesModelExplore>? allMoviesModelExplore;
  //  List loading circular logics
  //  for movies
  RxInt exploremovieslength = 8.obs;
  RxInt explorepageavailablenmovies = 0.obs;
  RxInt homePagemovieslength = 8.obs;
  // RxInt displaymovies = 1.obs;
  RxBool exploreisfetchingmoremovies = false.obs;
  // for countries search tags
  RxInt countrieslength = 8.obs;
  // for countries search tags
  RxInt yearslength = 8.obs;

  // Search Text Editing Controller

  final homePageController = TextEditingController().obs;
  final explorePageController = TextEditingController().obs;
  final genrePageController = TextEditingController().obs;

  // checking variable

  RxBool isUserSearchedinHomePage = false.obs;
  RxBool isUserSearchedinExplorePage = false.obs;
  RxBool isUserSearchedinGenrePage = false.obs;
  RxBool isUserSearchedinShowPage = false.obs;

  // checking variable

  RxString assignString = ''.obs;
  RxString assignStringExplore = ''.obs;
  RxString assignStringGenre = ''.obs;

  // Genre Page movies

  RxInt genremovieslength = 0.obs;
  RxInt genremoviesdisplaylength = 0.obs;
  RxBool isloadingmoreGenrePagemovies = false.obs;

  // Explore Page Fixings
  RxBool issearchTagSelected = false.obs;

  // Year
  RxList year = [].obs;
  // For Coloring
  RxList yearisactive = [].obs;
  RxBool allyearisActive = true.obs;
  // Genre
  RxList genreId = [].obs;
  RxList genreIdisactive = [].obs;
  RxBool allgenreisActive = true.obs;
  // Country
  RxList country = [].obs;
  RxList countryisactive = [].obs;
  RxBool allcountriesisActive = true.obs;
  // Variable just for update UI on the Explore Page Screen values
  RxInt updateUi = 0.obs;

  // for countries search tags
  RxInt totalexploreMovies = 0.obs;

  // Checking Network Connection
  RxBool isnetworkConnected = false.obs;

  // HomePage fetch data circular condition
  RxBool isloadinghomepageApi = true.obs;
  RxBool isloadingmodal_active = false.obs;

  RxBool isexception_thrown = false.obs;

  // HomePage Network Error
  RxBool homePage_networkError = false.obs;

  // ExplorePage Movies Previous length
  RxInt previousmovieslength = 0.obs;
  // ExplorePage TextField Tappwed time length
  RxBool textfieldtapped = false.obs;

  // Fetch More Movies Genre Page
  void fetchmoregenremovies() {
    isloadingmoreGenrePagemovies(true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (genremovieslength.value - genremoviesdisplaylength.value < 10) {
        genremoviesdisplaylength = genremovieslength;
      } else {
        genremoviesdisplaylength = genremoviesdisplaylength + 2;
      }
      isloadingmoreGenrePagemovies(false);
    });
  }

// for years
  void fetchmoreyears(int length) {
    if (yearslength < length) {
      yearslength = yearslength + 10;
    }
  }

// for countries
  void fetchmorecountries(int length) {
    if (countrieslength < length) {
      countrieslength = countrieslength + 10;
    }
  }

// Fetch Movies
  void fetchmoremovies(int totalmovies) {
    exploreisfetchingmoremovies(true);
    Future.delayed(const Duration(seconds: 1), () {
      if (exploremovieslength < totalmovies &&
          exploremovieslength < explorepageavailablenmovies.value) {
        if (exploremovieslength.value + 10 >
            explorepageavailablenmovies.value) {
          exploremovieslength.value = explorepageavailablenmovies.value;
        } else {
          exploremovieslength = exploremovieslength + 8;
          homePagemovieslength = homePagemovieslength + 8;
        }
      }
      exploreisfetchingmoremovies(false);
    });
  }

// Checklist
  Future checklist(String Name, String Id) async {
    genreModel!.videoStreamingApp.clear();
    await MoviebygenreIdList(Id, "limit");
  }

// Fetch Genre List
  Future<GenreModel?> FetchgenreList() async {
    try {
      genreModel = await RemoteServices.GenreListFetchdata();
      isloading(false);
      return genreModel!;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

// Movie by Genre List
  Future<void> MoviebygenreIdList(String movieId, String filter) async {
    isloadingdetailgenremovies(true);
    ismovieavailablein_genremovies(true);
    try {
      var response =
          await http.post(Uri.parse("$siteurl/movies_by_genre"), headers: {
        'Authorization': 'Bearer $Usertoken',
        'token': Usertoken.toString()
      }, body: {
        "genre_id": movieId,
        "filter": 'all',
      });
      var jsonResponse = jsonDecode(response.body);
      List jsonlist = jsonResponse["VIDEO_STREAMING_APP"];
      if (jsonlist.isEmpty || jsonlist.length == 1) {
        ismovieavailablein_genremovies(false);
      } else {
        genremovie_detail = moviegenreDetailmodelFromJson(response.body);
      }
      isloadingdetailgenremovies(false);
    } on SocketException {
      throw Get.defaultDialog();
    } catch (e) {
      throw Get.defaultDialog(
              title: "Sorry",
              content: const Text("We are facing some issues at the moment"))
          .then((value) => {Get.back()});
    }
  }

// Update Color

  updatecolor(int index) {
    isActiveGenreColor(index);
  }

  updatecolorExplorePage(int index) {
    isActiveGenreSelectedExplorePageColor.value = index;
    // update();
  }

// Popular movies List

  Future<PopularMoviesModel?> PopularMoviesList() async {
    try {
      popularMoviesModel = await RemoteServices.PopularMoviesFetchdata();
      isloadingpopularmovies(false);
      return popularMoviesModel!;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isloadingpopularmovies(false);
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

// Movie Detail

  Future<bool> MovieDetails(String movieId) async {
    try {
      isloadingdetailmovies(true);
      movie_detail_Model = await RemoteServices.moviedetailFetchdata(movieId);
      isloadingdetailmovies(false);
      return true;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      ErrorSnackBar("Sorry we are facing some issues at the moment");
      return false;
    }
  }

// Movie Play

  Future<bool> MoviePlay(String movie, String subtitle) async {
    movieurl.value = movie;
    subtitleurl.value = subtitle;
    return true;
  }

// Fetch all Movies

  Future<bool> Fetchallmovies() async {
    try {
      allMoviesModel = await RemoteServices.allmoviesFetchdata();
      explorepageavailablenmovies.value = allMoviesModel!.totalRecords;
      allMoviesModelExplore =
          allMoviesModel!.videoStreamingApp.cast<AllMoviesModelExplore>();
      totalexploreMovies.value = allMoviesModel!.totalRecords;
      ismoviesloading(false);
      return true;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      ErrorSnackBar("Sorry we are facing some issues at the moment");
      return false;
    }
  }

// Fetch Movies bt Tags

  void fetchmoviesbyTags(String year) {
    exploremovieslength.value = 8;
    fetchmoremovies(allMoviesModel!.videoStreamingApp.length);
  }

// Fetch HomePage Movies

  Future<HomePageModel?> homepagesection() async {
    isloadinghomepageApi(true);
    try {
      homepagemovies = await RemoteServices.homePageFetchdata();
      homepagemovies!.videoStreamingApp.latestMovies.length;
      isloadinghomepageApi(false);
      return homepagemovies;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await homepagesection();
    await Fetchallmovies();
    await FetchgenreList();
  }
}
