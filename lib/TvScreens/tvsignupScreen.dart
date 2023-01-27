import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/TvScreens/tvsignInScreen.dart';
import '../constants.dart';

class TvSignUpScreen extends StatefulWidget {
  const TvSignUpScreen({super.key});

  @override
  State<TvSignUpScreen> createState() => TvSignUpScreenState();
}

class TvSignUpScreenState extends State<TvSignUpScreen> {
  // emailAddress Controller
  TextEditingController emailAddressController = TextEditingController();

  // password Controller
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: backgroundColor,
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailAddressController,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email first";
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
                                      filled: true, //<-- SEE HERE
                                      fillColor: const Color(0xff1E2030),
                                      focusColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                      hintText: 'First Name',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: emailAddressController,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email first";
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
                                      filled: true, //<-- SEE HERE
                                      fillColor: const Color(0xff1E2030),
                                      focusColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                      hintText: 'Last Name',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: emailAddressController,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter email first";
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
                                filled: true, //<-- SEE HERE
                                fillColor: const Color(0xff1E2030),
                                focusColor: Colors.grey,
                                hoverColor: Colors.grey,
                                hintText: 'Enter your email address',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: GoogleFonts.inter(
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
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: passwordController,
                            style: GoogleFonts.inter(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter phone number first";
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
                                hintStyle: GoogleFonts.inter(
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
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: passwordController,
                            style: GoogleFonts.inter(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password first";
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
                                hintStyle: GoogleFonts.inter(
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
                    Row(
                      children: [
                        Card(
                          elevation: 5,
                          child: Container(
                            height: 40,
                            width: 120,
                            color: const Color(0xffF8B45E),
                            alignment: Alignment.center,
                            child: Text('Next',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(const TvSignInScreen()),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: Text('Sign In',
                                  style: GoogleFonts.inter(
                                       textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
