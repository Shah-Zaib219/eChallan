import 'package:echallan/utils/log_button.dart';
import 'package:echallan/utils/text_input_filed.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _singupController = Get.put(SignupController());
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 50, 88),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(1.0),
                      Colors.blue.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 2.h,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 40.w,
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Signup as ${args?.toString().toUpperCase() ?? 'USER'}",
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 30),
                      child: Column(
                        children: [
                          TextInputField(
                            controller: _singupController.firstNameController,
                            hintText: "First Name",
                            obscureText:
                                false, // Fixed: changed isPassword to obscureText
                          ),
                          SizedBox(height: 1.h),
                          TextInputField(
                            controller: _singupController.lastNameController,
                            hintText: "Last Name",
                            obscureText: false, // Fixed
                          ),
                          SizedBox(height: 1.h),
                          TextInputField(
                            controller: _singupController.emailController,
                            hintText: "Email",
                            obscureText: false, // Fixed
                          ),
                          SizedBox(height: 1.h),
                          TextInputField(
                            controller: _singupController.passwordController,
                            hintText: "Password (min 6 characters)",
                            obscureText: true, // Fixed: true for password
                          ),
                          SizedBox(height: 1.h),
                          TextInputField(
                            controller:
                                _singupController.confirmPasswordController,
                            hintText: "Confirm password",
                            obscureText: true, // Fixed: true for password
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Obx(
                            () => _singupController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : LogButton(
                                    title: "SignUp",
                                    onpress: () {
                                      // Add a timeout to reset loading if stuck
                                      Future.delayed(Duration(seconds: 10), () {
                                        if (_singupController.isLoading.value) {
                                          _singupController.isLoading.value =
                                              false;
                                          Get.snackbar(
                                            'Timeout',
                                            'Request timed out. Please check your internet and try again.',
                                            backgroundColor: Colors.orange,
                                            colorText: Colors.white,
                                          );
                                        }
                                      });
                                      _singupController.register(args);
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text(
                                  " Login",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 158, 20, 20),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
