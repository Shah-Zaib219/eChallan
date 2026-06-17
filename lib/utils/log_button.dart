import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const LogButton({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        height: 6.5.h,
        width: 84.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 50, 88),
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
