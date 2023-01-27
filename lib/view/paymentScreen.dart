import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/subscription_controller.dart';
import 'package:testapp/main.dart';
import '../widgets/textWidget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardnameController = TextEditingController();
  TextEditingController holdernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController expirymonthController = TextEditingController();
  TextEditingController expiryyearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  final SubscriptionController controller = Get.find();
  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        TextWidget(text: "Add a New Card")
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: cardnameController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 16,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Card Number',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Card Number";
                      } else if (value.length != 16) {
                        return "Invalid Card Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: expirymonthController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            maxLength: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Expiry Month";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Expiry Month',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: expiryyearController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            maxLength: 4,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Expiry Year";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Expiry Year',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 3,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter CVC/CVV";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                // fillColor: const Color(0xff1E2030),
                                // focusColor: Colors.grey,
                                // hoverColor: Colors.grey,
                                hintText: 'CVC/CVV',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: holdernameController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Card Holder Name";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        // fillColor: const Color(0xff1E2030),
                        hintText: 'Card holder name',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: addressController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        hintText: 'Billing address line 1',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Billing address line 2',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  const SizedBox(height: 20),
                  // Container(
                  //   padding: const EdgeInsets.all(5.0),
                  //   decoration: BoxDecoration(
                  //       color: const Color(0xff1F1D33),
                  //       borderRadius: BorderRadius.circular(8.0)),
                  //   child: ListTile(
                  //     leading: Image.asset("assets/cardicon.png"),
                  //     title: AutoSizeText(
                  //       "We will verify your card by making a \$1 charge. Don't worry we will refund it.",
                  //       style: TextStyle(
                  //           color: Colors.white.withOpacity(0.5), fontSize: 14),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 40),
                  ListTile(
                    leading: Image.asset("assets/donelogo.png"),
                    title: AutoSizeText(
                      "Your card details are safe with us. By continuing, you agree to the Terms & Conditions.",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.isdoingStripepayment.value
                      ? Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: double.infinity,
                          child: CircularProgressIndicator(
                            color: isActiveColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            ///////////////Have to change it ///////////////////////////
                            if (formKey.currentState!.validate()) {
                              if (await controller.stripePayment(
                                  cardnameController.text,
                                  expirymonthController.text,
                                  expiryyearController.text,
                                  cvvController.text,
                                  userId.toString(),
                                  holdernameController.toString())) {
                                Get.to(const Screens());
                              } else {
                                print("Error");
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
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
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'Save Card',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                ],
              );
            }),
          ),
        ),
      )),
    );
  }
}
