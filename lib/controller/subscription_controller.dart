import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:testapp/model/SubscriptionModel.dart';
import 'package:testapp/model/checksubscriptionmodel.dart';
import 'package:testapp/model/postpaymentstriperesponse.dart';
import '../constants.dart';
import '../model/SubscriptionPlanMonthly_Model.dart';
import '../model/local_storage_model.dart';
import '../services/remote_services.dart';

class SubscriptionController extends GetxController {
  RxBool isloading = true.obs;
  RxBool isdoingStripepayment = false.obs;
  RxString planid = ''.obs;
  SubsciptionPlaModel? subscriptionModel;
  RxBool isSubscriptionPlansFetching = true.obs;
  SubscriptionPlanMonthlyModel? monthlySubscription;
  SubscriptionPlanMonthlyModel? yearlySubscription;
  RxBool ismonthlyactive = true.obs;
  RxString selectedMonthlySubscriptionplan = "".obs;
  RxString selectedYearlySubscriptionplan = "".obs;
  PostPaymentStripeResponse? stripeResponse;
  CheckSubscription? usersubscription;

  // SubscriptionData
  Future<bool> subscribe() async {
    try {
      isloading(true);
      var response = await http.get(Uri.parse("$siteurl/subscription_plan"),
          headers: {
            'Authorization': 'Bearer $Usertoken',
            'token': Usertoken.toString()
          });

      subscriptionModel = subsciptionPlaModelFromJson(response.body);
      isloading(false);
      return true;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // SubscriptionData

  Future<bool> SubscriptionPlanFetching() async {
    try {
      monthlySubscription = await RemoteServices.subscriptionPlan("30");
      yearlySubscription = await RemoteServices.subscriptionPlan("365");
      isSubscriptionPlansFetching(false);
      return true;
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      throw ErrorSnackBar("Sorry we are facing some issues at the moment");
    }
  }

  // Payment Via Stripe

  Future<bool> stripePayment(
      String cardNo,
      String ccExpiryMonth,
      String ccExpiryYear,
      String cvvNumber,
      String user_id,
      String card_holder_name) async {
    try {
      isdoingStripepayment(true);
      await RemoteServices.stripepayment(cardNo, ccExpiryMonth, ccExpiryYear,
          cvvNumber, planid.value, user_id, card_holder_name);
      writeSecureData(StorageItem("subscription", 'subscribed'));
      CompletionSnackBar('Payment Completed');
      isdoingStripepayment(false);
      return true;
    } on SocketException {
      isdoingStripepayment(false);
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      isdoingStripepayment(false);
      return false;
    }
  }

  Future<String> checkusersubscription() async {
    try {
      usersubscription = await RemoteServices.checkUserPlan();
      if (usersubscription!.videoStreamingApp.msg ==
          'Please select subscription plan') {
        print('Matched Condition');
        return 'Please select subscription plan';
      }
      isdoingStripepayment(false);
      return '';
    } on SocketException {
      throw ErrorSnackBar("Network Error");
    } catch (e) {
      print("Error Here");
      return '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    subscribe();
  }
}
