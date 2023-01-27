import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/view/merchantpage.dart';
import 'package:testapp/view/paymentScreen.dart';

import '../controller/subscription_controller.dart';

class SubscriptionCard extends StatefulWidget {
  String plaId;
  String planname;
  List<String> featurelist;
  String price;
  bool isactive;
  String time;
  SubscriptionCard(
      {required this.plaId,
      required this.planname,
      required this.featurelist,
      this.price = "0.00",
      this.isactive = false,
      required this.time,
      super.key});

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  final SubscriptionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.planid(widget.plaId);
        setState(() {});
        Get.to(const MerchantPage());
      },
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff1F1D33),
            gradient: widget.isactive
                ? const LinearGradient(colors: [
                    Color(0xffF7B15B),
                    Color(0xffEf8A40)
                  ], stops: [
                    0.1,
                    0.8,
                  ], begin: Alignment.topLeft, end: Alignment.topRight)
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              // height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      widget.planname,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  AutoSizeText(
                    "\$${widget.price}",
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: AutoSizeText(
                      " /${widget.time}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget.featurelist.length,
                  padding: const EdgeInsets.only(top: 5),
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageIcon(
                            const AssetImage("assets/downloadedicon.png"),
                            color: widget.isactive
                                ? Colors.white
                                : Colors.grey.withOpacity(0.5),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: AutoSizeText(
                              widget.featurelist[index],
                              style: TextStyle(
                                color: widget.isactive
                                    ? Colors.white
                                    : const Color(0xff7B9399),
                                fontSize: 16,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
