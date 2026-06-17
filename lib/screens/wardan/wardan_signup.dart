import 'package:echallan/screens/auth_screen/login_screen.dart';
import 'package:echallan/screens/auth_screen/signup_screen.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class WardanSignup extends StatefulWidget {
  const WardanSignup({super.key});

  @override
  State<WardanSignup> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<WardanSignup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 1, 50, 88),
          ),
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
                top: 2.h, // Adjust the top position based on logoPosition value
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 50.w,
                      height: 25.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //inputs
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        children: [
                          // TextInputField(hintText: "First Name"),
                          // TextInputField(hintText: "Last Name"),
                          // TextInputField(hintText: "Last Name"),
                          // TextInputField(hintText: "CNIC"),
                          // TextInputField(hintText: "Password"),
                          // TextInputField(hintText: "Confirm password"),
                          SizedBox(
                            height: 3.h,
                          ),
                          LogButton(
                            title: "SignUp",
                            onpress: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 0.4.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "or login using",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
