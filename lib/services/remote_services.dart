import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/model/PopularMovies_Model.dart';
import 'package:testapp/model/SubscriptionPlanMonthly_Model.dart';
import 'package:testapp/model/allshowsmodel.dart';
import 'package:testapp/model/bookmark_model.dart';
import 'package:testapp/model/checksubscriptionmodel.dart';
import 'package:testapp/model/homepage_model.dart';
import 'package:testapp/model/movie_detail_model.dart';
import 'package:testapp/model/moviesmodel.dart';
import 'package:testapp/model/postpaymentstriperesponse.dart';
import 'package:testapp/model/seasondetail_model.dart';
import 'package:testapp/model/showdetailmodel.dart';
import 'package:testapp/view/StartScreens/Start_Slider.dart';
import '../constants.dart';
import '../model/genre_model.dart';

class RemoteServices {
  static var client = http.Client();

  // Home Page Movies
  static Future<HomePageModel?> homePageFetchdata() async {
    var response = await client.post(Uri.parse("$siteurl/home"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString(),
    }, body: {
      "user_id": userId,
    });
    ;
    if (response.statusCode == 200) {
      return homePageModelFromJson(response.body);
    }
    return null;
  }

  // Popular movies List
  static Future<PopularMoviesModel?> PopularMoviesFetchdata() async {
    var response =
        await client.post(Uri.parse("$siteurl/popular_movies"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    });
    if (response.statusCode == 200) {
      return popularMoviesModelFromJson(response.body);
    }
    return null;
  }

  // Genre movies List
  static Future<GenreModel?> GenreListFetchdata() async {
    var response = await client.get(Uri.parse("$siteurl/genres"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    });

    if (response.statusCode == 200) {
      return genreModelFromJson(response.body);
    }
    return null;
  }

// Fetch all movies List
  static Future<MoviesModel?> allmoviesFetchdata() async {
    var response = await client.post(Uri.parse("$siteurl/movies"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString(),
    }, body: {
      "filter": "all",
    });

    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    }
    return null;
  }

// Fetch all Shows List
  static Future<AllShowsModel?> allshowsFetchdata() async {
    var response = await client.post(Uri.parse("$siteurl/shows"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString(),
    });
    if (response.statusCode == 200) {
      return allShowsModelFromJson(response.body);
    }

    return null;
  }

// Fetch all Movies Detail
  static Future<MovieDetailModel?> moviedetailFetchdata(String movieId) async {
    var response =
        await client.post(Uri.parse("$siteurl/movies_details"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    }, body: {
      "movie_id": movieId,
      "user_id": userId
    });
    if (response.statusCode == 200) {
      return movieDetailModelFromJson(response.body);
    }
    return null;
  }

// Fetch Show Detail by id
  static Future<ShowDetailModel?> showdetailFetchdata(String seriesId) async {
    var response =
        await client.post(Uri.parse("$siteurl/show_details"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    }, body: {
      "series_id": seriesId,
    });
    if (response.statusCode == 200) {
      return showDetailModelFromJson(response.body);
    }
    return null;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Stripe Payment Method
  static Future<String> stripepayment(
      String cardNo,
      String ccExpiryMonth,
      String ccExpiryYear,
      String cvvNumber,
      String plan_id,
      String user_id,
      String card_holder_name) async {
    var response = await client
        .post(Uri.parse("$siteurl/postPaymentWithStripeApp"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    }, body: {
      'card_no': cardNo,
      'ccExpiryMonth': ccExpiryMonth,
      'ccExpiryYear': ccExpiryYear,
      'cvvNumber': cvvNumber,
      'plan_id': plan_id,
      'user_id': user_id,
      'card_holder_name': card_holder_name
      // "series_id": seriesId,
    });
    try {
      postPaymentStripeResponseFromJson(response.body)
          .videoStreamingApp
          .first
          .stripePaymentToken;
      return '';
    } catch (e) {
      print('Error');
      print(e);
      throw ErrorSnackBar(jsonDecode(response.body)['error']);
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // static Future<bool?> AddBookMark(String movietype, String movieId) async {
  //   var response =
  //       await client.post(Uri.parse("$siteurl/storeBookmarkurl"), headers: {
  //     'Authorization': 'Bearer $Usertoken',
  //     "Access-Control_Allow_Origin": "*",
  //     'token': Usertoken.toString()
  //   }, body: {
  //     "user_id": userId,
  //     "movie_type": movietype,
  //     "movie_id": movieId
  //   });
  //   if (response.statusCode == 200) {
  //     return true;
  //   }
  //   return false;
  // }

// Subscription Plans API Yearly
  static Future<SubscriptionPlanMonthlyModel?> subscriptionPlan(
      String days) async {
    var response = await client
        .post(Uri.parse("$siteurl/subscription_plan_yearly"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    }, body: {
      "plan_duration_type": days,
    });
    if (response.statusCode == 200) {
      return subscriptionPlanMonthlyModelFromJson(response.body);
    }
    return null;
  }

// Season Detail by season Id
  static Future<SeasonDetailModel?> seasondetailFetchdata(String Id) async {
    var response = await client.post(Uri.parse("$siteurl/episodes"), headers: {
      'Authorization': 'Bearer $Usertoken',
      "Access-Control_Allow_Origin": "*",
      'token': Usertoken.toString()
    }, body: {
      "season_id": Id,
      "user_id": userId
    });
    if (response.statusCode == 200) {
      SeasonDetailModel model = seasonDetailModelFromJson(response.body);
      return model;
    }
    return null;
  }

// Bookmark All Data
  static Future<BookmarkModel?> bookmarkmodelFetchdata() async {
    try {
      var response =
          await client.post(Uri.parse("$siteurl/getBookmarkurl"), headers: {
        'Authorization': 'Bearer $Usertoken',
        "Access-Control_Allow_Origin": "*",
        'token': Usertoken.toString()
      }, body: {
        "user_id": userId
      });
      if (response.statusCode == 200) {
        BookmarkModel? model;
        if (jsonDecode(response.body)['VIDEO_STREAMING_APP'].first ==
            'user record not found') {
          print("It is null");
          return null;
        } else {
          model = bookmarkModelFromJson(response.body);
        }
        return model;
      }
      return null;
    } catch (e) {
      print("Error is this");
      print(e);
      Get.to(const StartSlider());
    }
  }

  // Add Bookmark by id
  static Future<bool> add_bookmark(String movieType, int movieid) async {
    try {
      var response =
          await client.post(Uri.parse("$siteurl/storeBookmarkurl"), headers: {
        'Authorization': 'Bearer $Usertoken',
        "Access-Control_Allow_Origin": "*",
        'token': Usertoken.toString()
      }, body: {
        "user_id": userId,
        "movie_type": movieType,
        "movie_id": movieid.toString()
      });
      if (response.statusCode == 200) {
        // BookmarkModel? model;
        // print("Value /////////////////////////////////");
        // print(jsonDecode(response.body)['VIDEO_STREAMING_APP']["success"]);
        // if (jsonDecode(response.body)['VIDEO_STREAMING_APP']["success"] == 1) {
        return true;
        // }
      }
      return false;
    } catch (e) {
      print(e);
      throw ErrorSnackBar("Network Error");
    }
  }

// Check User Plan
  static Future<CheckSubscription?> checkUserPlan() async {
    try {
      var response =
          await client.post(Uri.parse("$siteurl/check_user_plan"), headers: {
        'Authorization': 'Bearer $Usertoken',
        "Access-Control_Allow_Origin": "*",
        'token': Usertoken.toString()
      }, body: {
        "user_id": userId
      });
      print("This is respose Body");
      print(response.body);
      // return checkSubscriptionFromJson(response.body);
    } catch (e) {
      print("Error is this");
      print(e);
    }
  }

  static Future<bool> updateProfile(String Name, String email, String phone,
      String user_address, String password) async {
    try {
      var response =
          await client.post(Uri.parse("$siteurl/profile_update"), headers: {
        'Authorization': 'Bearer $Usertoken',
        "Access-Control_Allow_Origin": "*",
        'token': Usertoken.toString()
      }, body: {
        "user_id": userId,
        "name": Name,
        "email": email,
        "phone": phone,
        "user_address": user_address,
        "password": password
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
