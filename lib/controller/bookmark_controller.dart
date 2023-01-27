import 'dart:io';

import 'package:get/get.dart';
import 'package:testapp/model/bookmark_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../services/remote_services.dart';

class BookmarkController extends GetxController {
  RxBool isloading = true.obs;
  RxBool isAddingbookmark = false.obs;
  RxBool iserror = false.obs;
  RxBool isemptyBookmark = false.obs;
  BookmarkModel? bookmarkModel;

  // Fetch Bookmark List
  Future<BookmarkModel?> Fetchbookmarklist() async {
    try {
      isloading(true);
      if (await RemoteServices.bookmarkmodelFetchdata() == null) {
        isloading(false);
        // print("This is Null");
        isemptyBookmark(true);
        return null;
      } else {
        bookmarkModel = await RemoteServices.bookmarkmodelFetchdata();
        print("This is Length");
        print(bookmarkModel!.videoStreamingApp!.length);
        isloading(false);
        update();
      }
      return bookmarkModel;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Fetch Bookmark List
  Future<void> Addbookmark(String movieType, int movieid) async {
    try {
      isAddingbookmark(true);
      await RemoteServices.add_bookmark(movieType, movieid).then((value) async {
        await Fetchbookmarklist().then((value) => isAddingbookmark(false));
      });
      update();
      // return bookmarkModel;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await Fetchbookmarklist();
  }
}
