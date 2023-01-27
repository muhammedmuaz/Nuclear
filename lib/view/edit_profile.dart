import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testapp/constants.dart';
import 'package:testapp/controller/auth_controller.dart';
import 'package:testapp/widgets/textWidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // firstName Controller
  TextEditingController firstNameController =
      TextEditingController(text: Username!.split(" ").first);
  // lastName Controller
  TextEditingController lastNameController =
      TextEditingController(text: Username!.split(" ").last);
  // phone Controller
  TextEditingController phoneController =
      TextEditingController(text: userphone);
  // emailAddress Controller
  TextEditingController emailAddressController =
      TextEditingController(text: useremail.toString());

  TextEditingController useraddresController =
      TextEditingController(text: useraddress);
  // password Controller
  TextEditingController passwordController = TextEditingController();

  // password Controller
  TextEditingController confirmpasswordController = TextEditingController();
  final AuthController controller = Get.put(AuthController());
  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: TextWidget(text: "Edit Profile"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: backgroundColor,
                            radius: 70,
                            foregroundImage:
                                const AssetImage('assets/profile2.png'),
                          ),
                          // Positioned(
                          //   bottom: 1,
                          //   right: 1,
                          //   child: GestureDetector(
                          //     onTap: (() => print("Edit Profile")),
                          //     child: Container(
                          //       padding: const EdgeInsets.all(2.0),
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 3,
                          //             color: Colors.orangeAccent,
                          //           ),
                          //           borderRadius: const BorderRadius.all(
                          //             Radius.circular(
                          //               50,
                          //             ),
                          //           ),
                          //           color: Colors.orangeAccent,
                          //           boxShadow: [
                          //             BoxShadow(
                          //               offset: const Offset(2, 4),
                          //               color: Colors.black.withOpacity(
                          //                 0.3,
                          //               ),
                          //               blurRadius: 3,
                          //             ),
                          //           ]),
                          //       child: const ImageIcon(
                          //         AssetImage("assets/editIcon.png"),
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 14)),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First Name
                        Flexible(
                          child: TextFormField(
                            controller: firstNameController,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter first name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: const Color(0xff1E2030),
                                focusColor: Colors.grey,
                                hoverColor: Colors.grey,
                                hintText: 'First Name',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(
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
                          width: 10,
                        ),

                        // Last Name
                        Flexible(
                          child: TextFormField(
                            controller: lastNameController,
                            style: const TextStyle(color: Colors.white),
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter last name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: const Color(0xff1E2030),
                                focusColor: Colors.grey,
                                hoverColor: Colors.grey,
                                hintText: 'Last Name',
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Email Address
                  TextFormField(
                    controller: emailAddressController,
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email address";
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
                        filled: true,
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your email address',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
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

                  // User Address
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    controller: useraddresController,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your Address',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
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

                  // Phone Number
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter phone number";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your phone Number',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
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

                  // Pasword
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Enter your Password',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
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

                  // Confirm your Password
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.grey,
                    controller: confirmpasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Re-enter to Confirm Password";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: const Color(0xff1E2030),
                        focusColor: Colors.grey,
                        hoverColor: Colors.grey,
                        hintText: 'Confirm Password',
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),

                  const SizedBox(height: 20),

                  // Button
                  controller.isupdatingProfile.value
                      ? Container(
                          height: 55,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.editProfile(
                                  '${firstNameController.text} ${lastNameController.text}',
                                  emailAddressController.text,
                                  phoneController.text,
                                  useraddresController.text,
                                  passwordController.text);
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
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
