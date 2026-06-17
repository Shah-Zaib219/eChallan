import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      elevation: 10,
      child: Container(
        height: 7.h,
        width: 30.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.red),
        child: Center(
            child: Text(
          "G",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
    );
  }
}
