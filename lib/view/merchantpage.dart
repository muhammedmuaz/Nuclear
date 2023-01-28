import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../widgets/subscriptionmerchant.dart';
import '../widgets/textWidget.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({super.key});

  @override
  State<MerchantPage> createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
                child: SizedBox(
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
                        width: 20,
                      ),
                      TextWidget(text: "Payment Method")
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const AutoSizeText(
                "One Last Step! Add A\n Payment Method.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 50),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Subscription_merchant(
                    //   imageAddress: 'assets/stripelogo.png',
                    //   text: 'Pay with Stripe',
                    //   ispaypal: false,
                    // ),
                    // const SizedBox(width: 25),
                    Subscription_merchant(
                      imageAddress: 'assets/paypallogo.png',
                      text: 'Pay with PayPal',
                      ispaypal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: AutoSizeText(
                  "By clicking “Submit”, you agree to the Subscription Terms and that after any applicable promotional period your subscription will automatically renew on a monthly basis and you will be charged \$4.99/Month (plus applicable tax) at the start of each billing period unless you cancel. Cancel at any time through your account page effective at the end of the billing cycle. No refunds for partial months. Cancel before any applicable promotional period ends to avoid charges.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
