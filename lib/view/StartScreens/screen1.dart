import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/view/StartScreens/signin.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});
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
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/cover.png"),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: devicewidth * 0.175),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Watch movie",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const AutoSizeText(
                        "anywhere, anytime",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const AutoSizeText(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: deviceheight * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(const SignInScreen()),
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
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
                              borderRadius: BorderRadius.circular(6)),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
