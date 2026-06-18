import 'package:echallan/screens/auth_screen/forget_password.dart';
import 'package:echallan/screens/auth_screen/signup_screen.dart';
import 'package:echallan/utils/google_button.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:echallan/utils/text_input_filed.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _loginController = Get.put(LoginController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 3, 95, 165),
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
                      Colors.blue.withOpacity(0.9),
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
                      width: 45.w,
                      height: 20.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "LogIn",
                                style: TextStyle(
                                    fontSize: 30,
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
                            controller: _loginController.emailController,
                            hintText: "Enter your email",
                            obscureText: false,
                          ),
                          SizedBox(height: 2.h),
                          TextInputField(
                            controller: _loginController.passwordController,
                            hintText: "Enter password",
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Obx(
                            () => _loginController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : LogButton(
                                    title: "Login",
                                    onpress: _loginController.login),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => ForgetPassword()),
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => SignupScreen(),
                                      arguments: Get.arguments);
                                },
                                child: const Text(
                                  " SignUp",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 158, 20, 20),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const Text(
                            "or signup using",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const GoogleButton(),
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
