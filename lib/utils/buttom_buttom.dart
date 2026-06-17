import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ButtomButtom extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  const ButtomButtom(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
          alignment: Alignment.center,
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(25)),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
