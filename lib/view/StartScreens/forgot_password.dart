import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/constants.dart';
import '../../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Main Controller
    final AuthController controller = Get.put(AuthController());

    // Forgot Password Controller
    TextEditingController forgotPasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: forgotPasswordController,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              cursorColor: Colors.grey,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: const Color(0xff1E2030),
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
                  hintText: 'Enter your email address',
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.isloading.value
                ? const CircularProgressIndicator(color: Colors.orange)
                : GestureDetector(
                    onTap: () => print("Forgot Password"),
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
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  )),
          ],
        ),
      )),
    );
  }
}
