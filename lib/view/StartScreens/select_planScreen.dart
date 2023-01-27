import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testapp/controller/subscription_controller.dart';
import 'package:testapp/videoPlayer/video_player.dart';
import 'package:testapp/view/StartScreens/plancreate_screen.dart';
import 'package:testapp/view/paymentScreen.dart';
import '../../constants.dart';

class SelectPlanScreen extends StatefulWidget {
  bool isfromhome;
  SelectPlanScreen({required this.isfromhome, super.key});

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  SubscriptionController _controller = Get.put(SubscriptionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.SubscriptionPlanFetching();
  }

  bool monthly_isactive = true;
  bool isactive = false;

  String title1 = "Basic Plan Monthly";
  String title2 = "testing Monthly";
  String price1 = "2.00";
  String price2 = "1500.00";
  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
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
      body: Container(
        height: deviceheight,
        width: devicewidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Try 1 week free",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const AutoSizeText(
                      "Cancel Anytime",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        // fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              _controller.ismonthlyactive.value = true;
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      _controller.ismonthlyactive.value
                                          ? BorderRadius.circular(10.0)
                                          : null,
                                  color: _controller.ismonthlyactive.value
                                      ? backgroundColor
                                      : null),
                              child: AutoSizeText(
                                "Monthly",
                                style: TextStyle(
                                    color: _controller.ismonthlyactive.value
                                        ? Colors.orangeAccent
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          // Expanded(
                          //     child: GestureDetector(
                          //   onTap: () {
                          //     _controller.ismonthlyactive.value = false;

                          //     setState(() {});
                          //   },
                          //   child: Container(
                          //     margin: const EdgeInsets.all(3.0),
                          //     decoration: BoxDecoration(
                          //         borderRadius:
                          //             _controller.ismonthlyactive.value
                          //                 ? null
                          //                 : BorderRadius.circular(10.0),
                          //         color: _controller.ismonthlyactive.value
                          //             ? null
                          //             : backgroundColor),
                          //     alignment: Alignment.center,
                          //     child: AutoSizeText(
                          //       "Annual",
                          //       style: TextStyle(
                          //           color: _controller.ismonthlyactive.value
                          //               ? Colors.white
                          //               : Colors.orangeAccent,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const AutoSizeText(
                      "Save 16% with annual billing! That's \$4.17/mo. for Essential.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        // fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return SizedBox(
                        child: _controller.isSubscriptionPlansFetching.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orangeAccent,
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:
                                    // Monthly
                                    _controller.ismonthlyactive.value
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      _controller
                                                          .monthlySubscription!
                                                          .subscriptionPlanMonthly
                                                          .length;
                                                  i++)
                                                GestureDetector(
                                                  onTap: () {
                                                    _controller.planid.value =
                                                        _controller
                                                            .monthlySubscription!
                                                            .subscriptionPlanMonthly[
                                                                i]
                                                            .planId
                                                            .toString();
                                                    _controller
                                                        .selectedYearlySubscriptionplan(
                                                            "");
                                                    _controller
                                                            .selectedMonthlySubscriptionplan
                                                            .value =
                                                        _controller
                                                            .monthlySubscription!
                                                            .subscriptionPlanMonthly[
                                                                i]
                                                            .planId
                                                            .toString();
                                                    setState(() {
                                                      // isactive = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 24),
                                                    height: 200,
                                                    width: 160,
                                                    decoration: BoxDecoration(
                                                        gradient: _controller
                                                                    .selectedMonthlySubscriptionplan
                                                                    .value ==
                                                                _controller
                                                                    .monthlySubscription!
                                                                    .subscriptionPlanMonthly[
                                                                        i]
                                                                    .planId
                                                                    .toString()
                                                            ? const LinearGradient(
                                                                colors: [
                                                                    Colors
                                                                        .orangeAccent,
                                                                    Colors
                                                                        .orange,
                                                                  ],
                                                                stops: [
                                                                    0.4,
                                                                    0.6,
                                                                  ],
                                                                begin: Alignment
                                                                    .bottomLeft,
                                                                end: Alignment
                                                                    .topRight)
                                                            : null,
                                                        border: isactive
                                                            ? null
                                                            : Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        AutoSizeText(
                                                          _controller
                                                              .monthlySubscription!
                                                              .subscriptionPlanMonthly[
                                                                  i]
                                                              .planName,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AutoSizeText(
                                                          "\$${_controller.monthlySubscription!.subscriptionPlanMonthly[i].planPrice} after trial",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )
                                        : Container()
                                // Row(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //     children: [

                                //       for (int i = 0;
                                //           i <
                                //               _controller
                                //                   .yearlySubscription!
                                //                   .subscriptionPlanMonthly
                                //                   .length;
                                //           i++)
                                //         GestureDetector(
                                //           onTap: () {
                                //             _controller.planid.value =
                                //                 _controller
                                //                     .yearlySubscription!
                                //                     .subscriptionPlanMonthly[
                                //                         i]
                                //                     .planId
                                //                     .toString();
                                //             _controller
                                //                 .selectedMonthlySubscriptionplan(
                                //                     "");
                                //             _controller
                                //                     .selectedYearlySubscriptionplan
                                //                     .value =
                                //                 _controller
                                //                     .yearlySubscription!
                                //                     .subscriptionPlanMonthly[
                                //                         i]
                                //                     .planId
                                //                     .toString();
                                //             setState(() {
                                //               // isactive = true;
                                //             });
                                //           },
                                //           child: Container(
                                //             padding: const EdgeInsets
                                //                     .symmetric(
                                //                 horizontal: 24),
                                //             height: 200,
                                //             width: 160,
                                //             decoration: BoxDecoration(
                                //                 gradient: _controller
                                //                             .selectedYearlySubscriptionplan
                                //                             .value ==
                                //                         _controller
                                //                             .yearlySubscription!
                                //                             .subscriptionPlanMonthly[
                                //                                 i]
                                //                             .planId
                                //                             .toString()
                                //                     ? const LinearGradient(
                                //                         colors: [
                                //                             Colors
                                //                                 .orangeAccent,
                                //                             Colors
                                //                                 .orange,
                                //                           ],
                                //                         stops: [
                                //                             0.4,
                                //                             0.6,
                                //                           ],
                                //                         begin: Alignment
                                //                             .bottomLeft,
                                //                         end: Alignment
                                //                             .topRight)
                                //                     : null,
                                //                 border: isactive
                                //                     ? null
                                //                     : Border.all(
                                //                         width: 1,
                                //                         color: Colors
                                //                             .grey
                                //                             .withOpacity(
                                //                                 0.5))),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment
                                //                       .center,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .center,
                                //               children: [
                                //                 AutoSizeText(
                                //                   _controller
                                //                       .yearlySubscription!
                                //                       .subscriptionPlanMonthly[
                                //                           i]
                                //                       .planName,
                                //                   style: const TextStyle(
                                //                       color:
                                //                           Colors.white,
                                //                       fontSize: 22,
                                //                       fontWeight:
                                //                           FontWeight
                                //                               .bold),
                                //                   textAlign:
                                //                       TextAlign.center,
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 10,
                                //                 ),
                                //                 AutoSizeText(
                                //                   "\$${_controller.yearlySubscription!.subscriptionPlanMonthly[i].planPrice} after trial",
                                //                   style:
                                //                       const TextStyle(
                                //                     color: Colors.white,
                                //                     fontSize: 16,
                                //                     // fontWeight: FontWeight.bold
                                //                   ),
                                //                   textAlign:
                                //                       TextAlign.center,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //     ],
                                //   )

                                ),
                      );
                    }),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: const [
                          ListTile(
                            minLeadingWidth: 2,
                            // contentPadding: 0,
                            leading: ImageIcon(
                              AssetImage("assets/downloadedicon.png"),
                              color: Colors.orange,
                            ),
                            title: Text(
                              "Tens of thousand of episodes & movies",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 2,
                            // contentPadding: 0,
                            leading: ImageIcon(
                              AssetImage("assets/downloadedicon.png"),
                              color: Colors.orange,
                            ),
                            title: Text(
                              "NFL on CBS & top soccer live",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 2,
                            // contentPadding: 0,
                            leading: ImageIcon(
                              AssetImage("assets/downloadedicon.png"),
                              color: Colors.orange,
                            ),
                            title: Text(
                              "Limited ads",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 2,
                            // contentPadding: 0,
                            leading: ImageIcon(
                              AssetImage("assets/downloadedicon.png"),
                              color: Colors.orange,
                            ),
                            title: Text(
                              "24/7 live news with CBSN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.isfromhome) {
                          Get.to(const PaymentScreen());
                        } else {
                          Get.to(const PlanCreateScreen());
                        }
                        // showMaterialModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => Container(
                        //     height: deviceheight * 0.9,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 20, vertical: 20),
                        //     decoration: const BoxDecoration(
                        //       image: DecorationImage(
                        //           image: NetworkImage(
                        //               "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w370-q80/show_asset/26/81/29/show_asset_425843ac-4a22-485e-b1b8-2056adb29851.jpg"),
                        //           fit: BoxFit.fill),
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Colors.black,
                        //           Colors.transparent,
                        //         ],
                        //         begin: Alignment.bottomCenter,
                        //         end: Alignment.topCenter,
                        //         stops: [0.1, 1],
                        //       ),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         const Padding(
                        //           padding:
                        //               EdgeInsets.symmetric(horizontal: 24.0),
                        //           child: AutoSizeText(
                        //             "STREAM IT ALL FOR JUST \$70/YR. MORE!",
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //                 fontSize: 26,
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //         const SizedBox(height: 10),
                        //         const AutoSizeText(
                        //           "Get Paramount+ and SHOWTIME together for \$70/year more than Paramount+ alone. Watch hit originals, movies, docs and sports. all in the one place. Plus, SHOWTIME is always commercial free. Try 7 days free!",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //             color: Colors.white,
                        //             // fontWeight: FontWeight.bold
                        //           ),
                        //         ),

                        //         const SizedBox(height: 10),

                        //         // First Button

                        //         GestureDetector(
                        //           onTap: () => {},
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             height: 50,
                        //             width: double.infinity,
                        //             decoration: const BoxDecoration(
                        //               gradient: LinearGradient(
                        //                   colors: [
                        //                     Colors.orangeAccent,
                        //                     Colors.orange,
                        //                   ],
                        //                   stops: [
                        //                     0.4,
                        //                     0.6,
                        //                   ],
                        //                   begin: Alignment.bottomLeft,
                        //                   end: Alignment.topRight),
                        //             ),
                        //             child: const Text(
                        //               'GET THE BUNDLE',
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ),
                        //         ),
                        //         const SizedBox(height: 10),

                        //         // Second Button

                        //         GestureDetector(
                        //           onTap: () => Get.to(const PlanCreateScreen()),
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             height: 50,
                        //             width: double.infinity,
                        //             decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 border: Border.all(
                        //                     color: Colors.white, width: 2)),
                        //             child: const Text(
                        //               'MAYBE LATER',
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //           ),
                        //         ),

                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
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
                        ),
                        child: const Text(
                          'CONTINUE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
          ),
        ),
      ),
    );
  }
}

// Bottom Modal
