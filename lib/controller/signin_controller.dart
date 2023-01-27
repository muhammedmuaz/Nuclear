import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/model/signInModal.dart';
import '../constants.dart';
import '../model/local_storage_model.dart';

class SignInController extends GetxController {
  RxBool isloading = false.obs;

  Future<bool> signin(String emailAddress, String password) async {
    try {
      isloading(true);
      var response = await http.post(Uri.parse("$siteurl/login"), body: {
        "email": emailAddress,
        "password": password,
      });

      // Obtain shared preferences.
      debugPrint(response.body);
      SignInModel model = await fetchdata(response.body);

      if (model.videoStreamingApp.first.success == "1") {
        isloading(false);
        CompletionSnackBar("User Logged In");
        return true;
      } else {
        isloading(false);
        ErrorSnackBar("An Error Occured");
        return false;
      }
    } catch (e) {
      isloading(true);
      ErrorSnackBar(e.toString());
      return false;
    }
  }

  Future<SignInModel> fetchdata(String response) async {
    SignInModel responsebody = signInModelFromJson(response);
    // Username in Local Storage
    writeSecureData(
        StorageItem("token", responsebody.videoStreamingApp.first.token));
    writeSecureData(
        StorageItem("name", responsebody.videoStreamingApp.first.name));
    writeSecureData(StorageItem(
        "userid", responsebody.videoStreamingApp.first.userId.toString()));
    writeSecureData(
        StorageItem("user_email", responsebody.videoStreamingApp.first.email));
    writeSecureData(StorageItem(
        "user_image", responsebody.videoStreamingApp.first.userImage));
    return responsebody;
  }
}
