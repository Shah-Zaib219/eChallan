import 'package:echallan/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdminCards extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onPress;
  const AdminCards(
      {super.key,
      required this.title,
      required this.count,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 11.h,
          width: 42.w,
          decoration: BoxDecoration(
            color: Constants.buttonColor,
            borderRadius: BorderRadius.circular(10),
            // Match the border radius of the Material widget
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Constants.textColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Constants.textColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
