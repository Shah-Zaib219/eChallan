import 'package:echallan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const LogButton({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: Constants.buttonColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onpress,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
