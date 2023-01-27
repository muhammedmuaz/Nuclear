import 'package:flutter/material.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/widgets/downloadWidget.dart';

class Downloads extends StatelessWidget {
  const Downloads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Downloads",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download2.png',
                  Ratings: 6.5,
                  Time: '1h 21min',
                  Title: 'Matt Max: Fury Way',
                  Downloadvalue: 0.1,
                ),
                const SizedBox(
                  height: 10,
                ),
                DownloadWidget(
                  ImgUrl: 'assets/download3.png',
                  Ratings: 6.8,
                  Time: '1h 15min',
                  Title: 'Blackhawk Down',
                  Downloadvalue: 0.1,
                ),
                const SizedBox(
                  height: 10,
                ),
                DownloadWidget(
                  ImgUrl: 'assets/download1.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'The Mitrix: Reloaded',
                  Downloadvalue: 0.1,
                ),
                const SizedBox(height: 20),

                // Finished Downloads
                const Text(
                  "Finished Downloads",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download4.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'Master of Hacking',
                  Downloadvalue: 0.1,
                  isdownloaded: true,
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download5.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'Lord of the Hammer',
                  Downloadvalue: 0.1,
                  isdownloaded: true,
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download6.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'Akuaman The Saga',
                  Downloadvalue: 0.1,
                  isdownloaded: true,
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download5.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'Lord of the Hammer',
                  Downloadvalue: 0.1,
                  isdownloaded: true,
                ),
                const SizedBox(height: 20),
                DownloadWidget(
                  ImgUrl: 'assets/download4.png',
                  Ratings: 8.1,
                  Time: '1h 12min',
                  Title: 'Master of Hacking',
                  Downloadvalue: 0.1,
                  isdownloaded: true,
                ),
              ]),
        )),
      ),
    );
  }
}
