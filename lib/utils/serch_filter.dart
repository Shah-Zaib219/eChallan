import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SerchFilter extends StatelessWidget {
  const SerchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 1.5.h),
      height: 5.5.h,
      width: 84.w,
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 7, 6, 6),
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Image.asset(
            "assets/images/pencil.png",
            height: 3.8.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Search by ID",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
