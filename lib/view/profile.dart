import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/view/StartScreens/Start_Slider.dart';
import 'package:testapp/view/SubscriptionPage.dart';
import 'package:testapp/view/bookmarkScreen.dart';
import 'package:testapp/view/edit_profile.dart';
import 'package:testapp/view/historyPage.dart';
import 'package:testapp/widgets/ProfileActioncontainer.dart';
import 'package:testapp/widgets/profilebox.dart';
import 'package:testapp/widgets/textWidget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          backgroundColor: backgroundColor,
                          radius: 70,
                          foregroundImage:
                              const AssetImage('assets/profile2.png')
                          // NetworkImage(userImage.toString()),
                          ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: GestureDetector(
                          onTap: (() => Get.to(const EditProfileScreen())),
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.orangeAccent,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.orangeAccent,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: const ImageIcon(
                              AssetImage("assets/editIcon.png"),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                    child: Text(
                  Username.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                )),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(useremail.toString(),
                      style: GoogleFonts.inter(
                          color: Colors.grey.withOpacity(0.5), fontSize: 14)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                // crossAxisAlignment: C,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 98,
                    width: 90,
                    decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ProfileBox(
                      Name: "Bookmark",
                      IconPath: "assets/bookmarkIcon.png",
                      pageRoute: BookmarkScreen(),
                    ),
                  ),
                  Container(
                    height: 98,
                    width: 90,
                    decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ProfileBox(
                      Name: "History",
                      IconPath: "assets/rotateIcon.png",
                      pageRoute: HistoryScreen(),
                    ),
                  ),
                  // Container(
                  //   height: 98,
                  //   width: 90,
                  //   decoration: BoxDecoration(
                  //     color: boxColor,
                  //     borderRadius: BorderRadius.circular(15.0),
                  //   ),
                  //   child: ProfileBox(
                  //     Name: "Statistics",
                  //     IconPath: "assets/statisticsIcon.png",
                  //     pageRoute: HistoryScreen(),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              // MemberShip
              TextWidget(text: "Membership"),
              const SizedBox(height: 20),
              ProfileActionContainer(
                title: "Monthly Subscriptions",
                Subtitle: "Subscription until June 14 2021",
                OnTap: () {
                  Get.to(const SubscriptionPage());
                },
              ),
              const SizedBox(height: 20),
              // Bills & Payment
              // TextWidget(text: "Bills & Payment"),
              // const SizedBox(height: 20),
              // ProfileActionContainer(
              //     title: "Billing Details",
              //     Subtitle: "VISA  '''' '''' 1902",
              //     OnTap: () => print("Billing Details")),
              // const SizedBox(height: 20),
              // Account & Security
              TextWidget(text: "Account & Security"),
              const SizedBox(height: 20),
              ProfileActionContainer(
                  title: "My Account",
                  Subtitle: "Account settings, change number",
                  OnTap: () => Get.to(const EditProfileScreen())),
              const SizedBox(height: 20),
              // LOG OUT
              TextWidget(text: "Log Out"),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () async {
                  await deleteSecureData();
                  Get.to(const StartSlider());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 80,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: boxColor),
                  child: const ListTile(
                    title: AutoSizeText("LOG OUT",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
