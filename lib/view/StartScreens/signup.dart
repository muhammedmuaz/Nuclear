import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/controller/auth_controller.dart';
import 'package:testapp/view/StartScreens/creditcardsurvers_creen.dart';
import '../../constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX Controller
    final AuthController controller = Get.put(AuthController());
    // firstName Controller
    TextEditingController firstNameController = TextEditingController();
    // lastName Controller
    TextEditingController lastNameController = TextEditingController();
    // phone Controller
    TextEditingController phoneController = TextEditingController();
    // emailAddress Controller
    TextEditingController emailAddressController = TextEditingController();
    // password Controller
    TextEditingController passwordController = TextEditingController();
    // Form Key
    final formKey = GlobalKey<FormState>();

// Sign Up Validation
    Future signup_validation() async {
      bool issignin = await controller.signup(
          firstNameController.text + ' ' + lastNameController.text,
          emailAddressController.text,
          passwordController.text,
          phoneController.text);

      if (issignin) {
        Get.to(CreditCardSurvey_Screen(
          isfromhome: false,
        ));
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_new_outlined))
            : Container(),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create a Account",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 32),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First Name

                        Flexible(
                          child: TextFormField(
                            controller: firstNameController,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter first name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: const Color(0xff1E2030),
                                focusColor: Colors.grey,
                                hoverColor: Colors.grey,
                                hintText: 'First Name',
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

                        // Last Name
                        Flexible(
                          child: TextFormField(
                            controller: lastNameController,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter last name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: const Color(0xff1E2030),
                                focusColor: Colors.grey,
                                hoverColor: Colors.grey,
                                hintText: 'Last Name',
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

                  const SizedBox(
                    height: 20,
                  ),

                  // Email Address
                  TextFormField(
                    controller: emailAddressController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email address";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please enter correct email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your email address',
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

                  const SizedBox(
                    height: 20,
                  ),

                  // Phone Number
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter phone number";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your phone Number',
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
                  const SizedBox(
                    height: 20,
                  ),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 8) {
                        return "Please enter atleast 8 characters for password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your password',
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

                  const SizedBox(
                    height: 20,
                  ),

                  Obx(() => controller.isloading.value
                      ? const CircularProgressIndicator(color: Colors.orange)
                      : GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await signup_validation();
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
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              'Next',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        )),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
