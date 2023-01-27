import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/widgets/subscriptionCard.dart';
import 'package:testapp/widgets/textWidget.dart';
import '../controller/subscription_controller.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final SubscriptionController controller = Get.put(SubscriptionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: Obx(() {
        if (controller.isloading.value) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AutoSizeText(
                  "Subscriptions",
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: Colors.orangeAccent,
                )
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        TextWidget(text: "Subscriptions")
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  for (int i = 0;
                      i <
                          controller
                              .subscriptionModel!.videoStreamingApp.length;
                      i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: SubscriptionCard(
                          plaId: controller
                              .subscriptionModel!.videoStreamingApp[i].planId
                              .toString(),
                          planname: controller
                              .subscriptionModel!.videoStreamingApp[i].planName,
                          featurelist: List.generate(
                              controller.subscriptionModel!.videoStreamingApp[i]
                                  .description.length,
                              (index) => controller.subscriptionModel!
                                  .videoStreamingApp[i].description[index]),
                          price: controller.subscriptionModel!
                              .videoStreamingApp[i].planPrice,
                          time: controller.subscriptionModel!
                              .videoStreamingApp[i].planDuration),
                    ),
                ],
              ),
            ),
          );
        }
      })),
    );
  }
}
