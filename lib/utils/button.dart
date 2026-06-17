import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Button extends StatelessWidget {
  final String title;
  final double height;
  final VoidCallback onPress;
  final double width;
  const Button(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          alignment: Alignment.center,
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 1, 50, 88),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.camera_alt,
                size: 4.h,
                color: Colors.white,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
