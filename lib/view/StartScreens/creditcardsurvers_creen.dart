import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/subscription_controller.dart';
import 'package:testapp/view/merchantpage.dart';
import 'package:testapp/view/paymentScreen.dart';

import 'select_planScreen.dart';

class CreditCardSurvey_Screen extends StatelessWidget {
  bool isfromhome;
  CreditCardSurvey_Screen({required this.isfromhome, super.key});
  SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: isfromhome
            ? Container()
            : IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text(
          "Nuclear App",
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              height: 1.0,
            )),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ImageIcon(
                    AssetImage("assets/credit_card.png"),
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10),
                AutoSizeText(
                  "One last step! Don't forget:",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                AutoSizeText(
                  "Your first 7 days are free, and you won't be charged until 7 days. Cancel anytime",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey,
                    // fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.to(const MerchantPage()),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.orangeAccent,
                        Colors.orange,
                      ], stops: [
                        0.4,
                        0.6,
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    ),
                    child: Text(
                      'SUBSCRIBE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
