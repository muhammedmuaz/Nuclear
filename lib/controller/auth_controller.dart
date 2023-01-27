import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:testapp/model/local_storage_model.dart';
import 'package:testapp/services/remote_services.dart';
import '../constants.dart';
import '../model/signInModal.dart';
import 'package:http/http.dart' as http;
import '../model/signUpModel.dart';

class AuthController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isupdatingProfile = false.obs;

  // Sign In

  Future<bool> signin(String emailAddress, String password) async {
    try {
      isloading(true);
      var response = await http.post(Uri.parse("$siteurl/login"), body: {
        "email": emailAddress,
        "password": password,
      });

      Map<String, dynamic> ischeck = jsonDecode(response.body);

      if (ischeck['success'] == "0") {
        isloading(false);
        ErrorSnackBar("Invalid username & password");
        return false;
      } else {
        SignInModel model = await SaveSignIn(response.body);
        if (model.videoStreamingApp.first.success == "1") {
          isloading(false);

          userId = await readSecureData("userid");
          Usertoken = await readSecureData("token");
          Username = await readSecureData("name");
          useremail = await readSecureData("user_email");
          userImage = await readSecureData("user_image");
          CompletionSnackBar("User Logged In");
          return true;
        } else {
          isloading(false);
          ErrorSnackBar("An Error Occured");
          return false;
        }
      }
    } on SocketException {
      isloading(false);
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isloading(false);
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Sign Up

  Future<bool> signup(String username, String emailAddress, String password,
      String phone) async {
    try {
      isloading(true);
      var response = await http.post(Uri.parse("$siteurl/signup"), body: {
        "name": username,
        "email": emailAddress,
        "password": password,
        "phone": phone
      });

      // Obtain shared preferences.
      SignUpModel? model = await SaveSignUp(response.body);
      if (model!.videoStreamingApp!.first!.success == "1") {
        userId = await readSecureData("userid");
        Usertoken = await readSecureData("token");
        Username = await readSecureData("name");
        useremail = await readSecureData("user_email");
        userImage = await readSecureData("user_image");
        isloading(false);
        CompletionSnackBar("User created");
        return true;
      } else {
        isloading(false);
        ErrorSnackBar("An Error Occured");
        return false;
      }
      return true;
    } on SocketException {
      isloading(false);
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isloading(false);
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  Future<bool> forgotPassword(String emailAddress) async {
    try {
      isloading(true);
      var response =
          await http.post(Uri.parse("$siteurl/forgot_password"), body: {
        "email": emailAddress,
      });

      // Obtain shared preferences.
      SignInModel model = await SaveSignIn(response.body);

      if (model.videoStreamingApp.first.success == "1") {
        isloading(false);
        CompletionSnackBar("User Logged In");
        return true;
      } else {
        isloading(false);
        ErrorSnackBar("An Error Occured");
        return false;
      }
    } on SocketException {
      isloading(false);
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isloading(false);
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Save SignIn details

  Future<SignInModel> SaveSignIn(String response) async {
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

  // Save SignUp details

  Future<SignUpModel?> SaveSignUp(String response) async {
    SignUpModel? responsebody = signUpModelFromJson(response);
    // Username in Local Storage
    writeSecureData(StorageItem(
        "name", responsebody!.videoStreamingApp!.first!.user!.name!));
    writeSecureData(
        StorageItem("token", responsebody.videoStreamingApp!.first!.token!));
    writeSecureData(StorageItem(
        "user_email", responsebody.videoStreamingApp!.first!.user!.email!));
    writeSecureData(StorageItem(
        "userid", responsebody.videoStreamingApp!.first!.user!.id.toString()));
    writeSecureData(StorageItem(
        "user_image", responsebody.videoStreamingApp!.first!.user!.userImage!));
    return responsebody;
  }

  Future<void> editProfile(String Name, String email, String phone,
      String user_address, String password) async {
    try {
      isupdatingProfile(true);
      if (await RemoteServices.updateProfile(
          Name, email, phone, user_address, password)) {
        writeSecureData(StorageItem("userphone", phone));
        writeSecureData(StorageItem("useraddress", user_address));
        CompletionSnackBar("Profile Updated");
        isupdatingProfile(false);
      } else {
        ErrorSnackBar("An Error Occured");
        isupdatingProfile(false);
      }
    } on SocketException {
      isupdatingProfile(false);
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isupdatingProfile(false);
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }
}
