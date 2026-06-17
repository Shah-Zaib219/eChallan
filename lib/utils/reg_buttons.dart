import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegButtons extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool isEnabled;

  const RegButtons(
      {super.key,
      required this.title,
      required this.onPress,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPress : null,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 7.h,
            width: 83.w,
            decoration: BoxDecoration(
                color:
                    isEnabled ? Color.fromARGB(255, 3, 95, 165) : Colors.grey,
                borderRadius: BorderRadius.circular(25.sp)),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
