import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:testapp/controller/subscription_controller.dart';
import 'package:testapp/main.dart';
import 'package:testapp/view/paymentScreen.dart';

class Subscription_merchant extends StatelessWidget {
  String imageAddress;
  String text;
  bool ispaypal;
  Subscription_merchant(
      {required this.imageAddress,
      required this.text,
      required this.ispaypal,
      super.key});
  final SubscriptionController controller = Get.find();
  void changepage() {
    Get.to(Screens());
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Container(
        height: deviceheight * 0.28,
        width: devicewidth * 0.6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xffEE863D), width: 1)),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image(image: AssetImage(imageAddress))),
            const SizedBox(
              height: 5,
            ),
            AutoSizeText(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  if (!ispaypal) {
                    Get.to(const PaymentScreen());
                  } else {
                    Get.to(
                      UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "AR4AjUzZslxopMJU69MYIJtki-SnW9yxzSGelevb3Y7JeXLiJjdo4Stt2u4j-9Zl1eEKr-v6srnW5bmk",
                          secretKey:
                              "EKUbJIoVpjEmH3FZXI3YFOQRwf-bUzlMBD-KC2MxrZFnD-7y1ykyuCtgrYW9GkdPO5baQtHGINxqHa50",
                          returnURL: "nativexo://paypalpay",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: const [
                            {
                              "amount": {
                                "total": '10.12',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '10.12',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "The Blast(Basic)",
                                    "quantity": 1,
                                    "price": '10.12',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": "Jane Foster",
                                  "line1": "Travis County",
                                  "line2": "",
                                  "city": "Austin",
                                  "country_code": "US",
                                  "postal_code": "73301",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("Completed");
                            // Get.back();
                            Get.back();
                            Future.delayed(const Duration(seconds: 2), () {
                              changepage();
                            });

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         (const Screens())));
                            // Get.to();
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    );
                  }
                  // await controller.subscribe();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  height: 42,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.orangeAccent,
                        Colors.orange,
                      ], stops: [
                        0.4,
                        0.6,
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                      borderRadius: BorderRadius.circular(6)),
                  child: const AutoSizeText(
                    'Pay Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
