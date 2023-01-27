import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/TvScreens/tvhomepage.dart';
import 'package:testapp/TvScreens/tvsignupScreen.dart';
import '../constants.dart';
import '../controller/auth_controller.dart';
import '../view/StartScreens/forgot_password.dart';

class TvSignInScreen extends StatefulWidget {
  const TvSignInScreen({super.key});

  @override
  State<TvSignInScreen> createState() => TvSignInScreenState();
}

class TvSignInScreenState extends State<TvSignInScreen> {
  // Main Controller
  final AuthController controller = Get.put(AuthController());

  // emailAddress Controller
  TextEditingController emailAddressController = TextEditingController();

  // password Controller
  TextEditingController passwordController = TextEditingController();

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Sign Up Validation

  // ignore: non_constant_identifier_names
  Future signin_validation() async {
    bool issignin = await controller.signin(
      emailAddressController.text,
      passwordController.text,
    );

    if (issignin) {
      Get.to(const TVHomePage());
    }
  }

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
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
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
                          'Sign In',
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
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(const TvSignUpScreen()),
                                child: Container(
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.inter(
                                        color: Colors.orangeAccent,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 15,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 2,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Get.to(const ForgotPasswordScreen()),
                                child: SizedBox(
                                  child: Text(
                                    "Forgot Password",
                                    style: GoogleFonts.inter(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () => signin_validation(),
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
