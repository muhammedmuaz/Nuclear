import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/auth_controller.dart';
import 'package:testapp/main.dart';
import 'package:testapp/view/StartScreens/paymentsurvery_screen.dart';
import '../../model/local_storage_model.dart';
import 'forgot_password.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        Get.to(const Screens());
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Platform.isIOS ? IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined)) : Container(),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 32),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 20,
                ),
                Obx(() => controller.isloading.value
                    ? const CircularProgressIndicator(color: Colors.orange)
                    : GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            writeSecureData(
                                StorageItem("subscription", 'subscribed'));
                            await signin_validation();
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
                            'Log In',
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
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(const PaymentSurverScreen()),
                        child: Container(
                          child: Text(
                            "Create a Acount",
                            style: GoogleFonts.inter(
                                color: Colors.orangeAccent, fontSize: 14),
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
                        onTap: () => Get.to(const ForgotPasswordScreen()),
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
          ),
        ),
      ),
    );
  }
}
