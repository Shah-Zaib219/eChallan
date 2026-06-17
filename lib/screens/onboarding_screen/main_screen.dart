import 'package:echallan/screens/auth_screen/login_screen.dart';
import 'package:echallan/utils/reg_buttons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        // Blue gradient overlay
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
        // Logo image positioned with a vertical offset
        Positioned(
          top: 20.h, // Adjust the top position based on logoPosition value
          left: 0,
          right: 0,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 70.w, // Adjust the width as needed
                  height: 40.h, // Adjust the height as needed
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              RegButtons(
                title: "ADMIN LOGIN",
                onPress: () {
                  Get.to(() => LoginScreen(), arguments: "admin");
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              RegButtons(
                title: "WARDAN LOGIN",
                onPress: () {
                  Get.to(() => LoginScreen(), arguments: "warden");
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
