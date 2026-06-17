import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/controller/login_controller.dart';
import 'package:echallan/screens/onboarding_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../../controller/wardan_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => WardanController());
    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => ImageDetection());
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double logoPosition = 0.5;

    return SafeArea(
      child: Scaffold(
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
              top: logoPosition *
                  40.h, // Adjust the top position based on logoPosition value
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 70.w, // Adjust the width as needed
                  height: 40.h, // Adjust the height as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
