import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controller/subscription_controller.dart';
import '../../constants.dart';

class SubscriptionStart extends StatelessWidget {
  const SubscriptionStart({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    final SubscriptionController controller = Get.put(SubscriptionController());
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AutoSizeText(
                "Subscription",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(
                height: 20,
              ),

              Obx(
                () => controller.isloading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    : SizedBox(
                        height: deviceheight * 0.5,
                        child: ListView.builder(
                            itemCount: controller
                                .subscriptionModel!.videoStreamingApp.length,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: deviceheight * 0.5,
                                    width: devicewidth * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: const Color(0xffEE863D),
                                            width: 2)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller
                                              .subscriptionModel!
                                              .videoStreamingApp[index]
                                              .planName,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.end,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "\$",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                controller
                                                    .subscriptionModel!
                                                    .videoStreamingApp[index]
                                                    .planPrice,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 34,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .subscriptionModel!
                                              .videoStreamingApp[index]
                                              .planDuration,
                                          style: const TextStyle(
                                              color: Color(0xffEE863D),
                                              fontSize: 18),
                                        ),
                                        const Flexible(
                                          child: ListTile(
                                            minLeadingWidth: 5,
                                            horizontalTitleGap: 8,
                                            leading: ImageIcon(
                                                AssetImage("assets/tile.png"),
                                                color: Color(0xffEE863D)),
                                            title: Text(
                                              "Lorem Ipsum is",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          child: ListTile(
                                            minLeadingWidth: 5,
                                            horizontalTitleGap: 8,
                                            leading: ImageIcon(
                                                AssetImage("assets/tile.png"),
                                                color: Color(0xffEE863D)),
                                            title: Text(
                                              "Lorem Ipsum is",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          child: ListTile(
                                            minLeadingWidth: 5,
                                            horizontalTitleGap: 8,
                                            leading: ImageIcon(
                                                AssetImage("assets/tile.png"),
                                                color: Color(0xffEE863D)),
                                            title: Text(
                                              "Lorem Ipsum is",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          child: ListTile(
                                            minLeadingWidth: 5,
                                            horizontalTitleGap: 8,
                                            leading: ImageIcon(
                                                AssetImage("assets/tile.png"),
                                                color: Color(0xffEE863D)),
                                            title: Text(
                                              "Lorem Ipsum is",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          child: ListTile(
                                            minLeadingWidth: 5,
                                            horizontalTitleGap: 8,
                                            leading: ImageIcon(
                                                AssetImage("assets/tile.png"),
                                                color: Color(0xffEE863D)),
                                            title: Text(
                                              "Lorem Ipsum is",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await controller.subscribe();
                                            print(controller.subscriptionModel!
                                                .videoStreamingApp.length);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            alignment: Alignment.center,
                                            height: 42,
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
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: const Text(
                                              'Subscribe',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Subscription_deals(
              //         title: 'Basic',
              //       ),
              //       SizedBox(width: 10,),
              //       Subscription_deals(
              //         title: 'Recommended',
              //       ),
              //       SizedBox(width: 10,),
              //       Subscription_deals(
              //         title: 'Premium',
              //       ),
              //     ],
              //   ),
              // ),
              // Image.asset(
              //   "assets/subscribe.png"
              // ),

              // const SizedBox(
              //   height: 20,
              // ),
              // GestureDetector(
              //   onTap: () => Get.to(const Screen1()),
              //   child: Container(
              //     alignment: Alignment.center,
              //     height: 55,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         gradient: const LinearGradient(colors: [
              //           Colors.orangeAccent,
              //           Colors.orange,
              //         ], stops: [
              //           0.4,
              //           0.6,
              //         ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              //         borderRadius: BorderRadius.circular(6)),
              //     child: const Text(
              //       'Next',
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 15,
              //           fontWeight: FontWeight.w800),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
