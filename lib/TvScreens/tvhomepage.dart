import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVHomePage extends StatelessWidget {
  const TVHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/tvcover.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 24),
            child: Image.asset(
              'assets/logo2.gif',
              height: 100,
              width: 100,
              alignment: Alignment.topLeft,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    'Watch Movie',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                  AutoSizeText(
                    'Anywhere. Anytime.',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                        fontSize: 40),
                  ),
                  AutoSizeText(
                    'Lorem ipsum dolor sit amet, consetetur \nsadipscing elitr, sed diam.',
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontWeight: FontWeight.w200,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 150,
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
                        'Get Started',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
