import 'package:echallan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegButtons extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool isEnabled;

  const RegButtons({
    super.key,
    required this.title,
    required this.onPress,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: isEnabled ? Constants.buttonColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPress : null,
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
