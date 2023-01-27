import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/bookmark_controller.dart';
import 'package:testapp/controller/movie_controller.dart';
import 'package:testapp/view/StartScreens/Start_Slider.dart';
import 'package:testapp/view/Splash/splash.dart';
import 'package:testapp/view/homepage.dart';
import 'controller/shows_controller.dart';

void main() {
  // FlutterError.onError = (details) {
  //   FlutterError.presentError(details);
  //   if (kDebugMode) Get.to(const StartSlider());
  // };
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  read User Data

  Future<void> readUserData() async {
    // User Id
    userId = await readSecureData("userid");

    // User Name
    Username = await readSecureData("name");

    // User email
    useremail = await readSecureData("user_email");

    // token
    Usertoken = await readSecureData("token");

    // User Image
    userImage = await readSecureData("user_image");

    // Subscription
    subscribed = await readSecureData("subscription");

    // User Phone
    userphone = await readSecureData("userphone");

    // User Address
    useraddress = await readSecureData("useraddress");

    // Printing User Details

    debugPrint("User Id");
    debugPrint(userId);
    debugPrint("UserName");
    debugPrint(Username);
    debugPrint("User Email");
    debugPrint(useremail);
    debugPrint("User Token");
    debugPrint(Usertoken);
    debugPrint("User Image");
    debugPrint(userImage);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NHV App',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const Screens()),
        GetPage(name: '/Slider', page: () => const StartSlider()),
      ],
      theme: ThemeData(
        backgroundColor: const Color(0xff0B091C),
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Color.fromRGBO(30, 32, 48, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xff1E2030)),
          ),
        ),
      ),
    );
  }
}

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final MovieController _movieController = Get.put(MovieController());
  final showsController _showsController = Get.put(showsController());
  final BookmarkController controller = Get.put(BookmarkController());

  Future<void> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _movieController.isnetworkConnected.value = true;
      }
    } on SocketException catch (_) {
      _movieController.isnetworkConnected.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Widget screen = const HomePage(key: PageStorageKey("homeScreen"));
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.defaultDialog(
          title: "Alert",
          content: Text(
            "Are you you want to exit",
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          confirmTextColor: Colors.white,
          cancelTextColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          backgroundColor: backgroundColor,
          buttonColor: Colors.red,
          textConfirm: "Yes",
          textCancel: "No",
          onConfirm: () => SystemNavigator.pop(),
          onCancel: () => false),
      child: Scaffold(
        backgroundColor: const Color(0xff0B091C),
        body: screen,
        bottomNavigationBar: SalomonBottomBar(
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            currentIndex: index,
            selectedColorOpacity: 0.95,
            onTap: (i) {
              setState(() {
                screen = Pages[i];
                index = i;
              });
            },
            items: [
              SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  selectedColor: Colors.orange,
                  unselectedColor: Colors.white),
              SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/explore.png"),
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Explore",
                    style: TextStyle(color: Colors.white),
                  ),
                  unselectedColor: Colors.white),
              SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/tv.png"),
                    color: Colors.white,
                  ),
                  title: const Text("TV Show",
                      style: TextStyle(color: Colors.white))),
              // SalomonBottomBarItem(
              //     icon: const ImageIcon(
              //       AssetImage("assets/download.png"),
              //       color: Colors.white,
              //     ),
              //     title: const Text(
              //       "Download",
              //       style: TextStyle(color: Colors.white),
              //     )),
              SalomonBottomBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/profile.png"),
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  )),
            ]),
      ),
    );
  }
}
