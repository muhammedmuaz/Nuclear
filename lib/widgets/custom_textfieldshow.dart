import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/controller/shows_controller.dart';

class showtextfield extends StatelessWidget {
  const showtextfield({super.key});
  @override
  Widget build(BuildContext context) {
    final showsController showcontroller = Get.find();
    return Container(
      height: 51,
      color: const Color(0xff1C1A2E),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Obx(() {
            return TextField(
                style: const TextStyle(color: Colors.white),
                controller: showcontroller.showPageController.value,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                cursorColor: Colors.transparent,
                onChanged: ((value) {
                  showcontroller.isusersearchedShowsPage.value = true;
                  showcontroller.assignString.value = value;
                  print(
                      "///////////////////////////////////////////////////////////////////////////////////");
                  print("CURRENT lENGTH");
                  print(showcontroller.allshows!.videoStreamingApp
                      .where((element) {
                    return element.showTitle!.toLowerCase().contains(
                        showcontroller.assignString.value.toLowerCase());
                  }).length);
                  if (showcontroller.allshows!.videoStreamingApp
                          .where((element) {
                        return element.showTitle!.toLowerCase().contains(
                            showcontroller.assignString.value.toLowerCase());
                      }).length <
                      8) {
                    print("If Runs");
                    showcontroller.showsdisplaylength.value = showcontroller
                        .allshows!.videoStreamingApp
                        .where((element) {
                      return element.showTitle!.toLowerCase().contains(
                          showcontroller.assignString.value.toLowerCase());
                    }).length;
                    print("Current Value");
                    print(showcontroller.showsdisplaylength.value);
                  } else {
                    showcontroller.showstotallength.value = showcontroller
                        .allshows!.videoStreamingApp
                        .where((element) {
                      return element.showTitle!.toLowerCase().contains(
                          showcontroller.assignString.value.toLowerCase());
                    }).length;
                    showcontroller.showsdisplaylength.value = 8;
                  }

                  if (value.isEmpty) {
                    showcontroller.isusersearchedShowsPage.value = false;
                    showcontroller.showsdisplaylength.value = 8;
                    showcontroller.showstotallength.value =
                        showcontroller.showsrecordedlengthApi.value;
                  }
                }),
                decoration: const InputDecoration(
                    filled: false,
                    fillColor: Color(0xff1E2030),
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    hintText: 'What are you watching today',
                    hintTextDirection: TextDirection.ltr,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none));
          })),

          const VerticalDivider(
            color: Colors.white,
            thickness: 0.8,
          ),

          const SizedBox(
            width: 5,
          ),

          GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          // FaIcon(
          //   Icons.menu,
          //   color: Colors.white,
          // ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
    // Card(
    //   margin: EdgeInsets.symmetric(horizontal: 24),
    //   color: Color(0xff1C1A2E),
    //   elevation: 1,
    //   child:
    //   TextField(
    //     decoration: InputDecoration(
    //       focusColor:Color(0xff1C1A2E) ,
    //       fillColor: Color(0xff1C1A2E),
    //       suffixIcon: Icon(Icons.search, color: Colors.white,),
    //       iconColor: Colors.white,
    //       enabledBorder: OutlineInputBorder(

    //         borderRadius: BorderRadius.circular(10)), //<-- SEE HERE
    //       ),

    //   // ),
    // );
  }
}
