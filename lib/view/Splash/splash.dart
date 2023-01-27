import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/TvScreens/tvstartScreen.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/subscription_controller.dart';
import 'package:testapp/main.dart';
import 'package:testapp/view/StartScreens/Start_Slider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../StartScreens/creditcardsurvers_creen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SubscriptionController controller = Get.put(SubscriptionController());
  String subscription = '';
  Future<bool> checkfortv() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool isTV =
        androidInfo.systemFeatures.contains('android.software.leanback_only');
    return isTV;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      if (await checkfortv()) {
        Get.to(const TvStartScreen());
      } else {
        if (useremail != null) {
          if (subscribed != null) {
            Get.to(const Screens());
          } else {
            alertSnackBar('Purchasew Subscription to Continue');
            Get.to(CreditCardSurvey_Screen(
              isfromhome: true,
            ));
          }
        } else {
          Get.to(const StartSlider());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          height: deviceheight,
          width: devicewidth,
          child: Image.asset(
            'assets/logo.gif',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
