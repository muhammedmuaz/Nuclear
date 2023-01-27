import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/TvScreens/tvsignInScreen.dart';
import 'package:testapp/TvScreens/tvsignupScreen.dart';

import '../constants.dart';
import '../view/StartScreens/signin.dart';

class TvStartScreen extends StatefulWidget {
  const TvStartScreen({super.key});

  @override
  State<TvStartScreen> createState() => TtvStartScreenState();
}

class TtvStartScreenState extends State<TvStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                // alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/logo2.gif'),
                            fit: BoxFit.fill)),
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: backgroundColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Let\'s',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w300)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Get',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w300)),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Started',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam.',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(const TvSignInScreen()),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              height: 40,
                              width: 120,
                              color: const Color(0xffF8B45E),
                              alignment: Alignment.center,
                              child: Text('Sign In',
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(const TvSignUpScreen()),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: Text('Sign Up',
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
