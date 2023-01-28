import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';
import '../widgets/textWidget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: TextWidget(text: "Notification"),
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        leadingWidth: 100,
        toolbarHeight: 100,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView.builder(itemBuilder: ((context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.asset("assets/notificationIcon.png"),
                title: Text(
                  "Lorem Ipsum is simply",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  "Lorem Ipsum is simply",
                  style: GoogleFonts.inter(
                      color: Colors.grey.withOpacity(0.5), fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Divider(thickness: 1, color: Colors.grey.withOpacity(0.5)),
              )
            ],
          );
        })),
      ),
    );
  }
}
