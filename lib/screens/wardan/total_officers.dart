import 'dart:ffi';

import 'package:echallan/constants/constants.dart';
import 'package:echallan/utils/buttom_buttom.dart';
import 'package:echallan/utils/data/officer_data.dart';
import 'package:echallan/utils/serch_filter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TotalOfficers extends StatefulWidget {
  const TotalOfficers({super.key});

  @override
  State<TotalOfficers> createState() => _TotalOfficersState();
}

class _TotalOfficersState extends State<TotalOfficers> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.background,
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Constants.textColor,
              size: 4.h,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "TOTAL OFFICERS",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: 100.h,
          padding: EdgeInsets.only(
            left: 20.0,
            top: 9.h,
          ),
          child: Stack(
            clipBehavior:
                Clip.none, // Allows the avatar to overflow the container
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 73.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height <= 640 ? 50 : 70.0, left: 10, right: 10),
                    child: Column(
                      children: [
                        const Text(
                          "Please search your officers",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 2.h),
                        //const SerchFilter(),
                        SizedBox(height: 2.h),
                        OfficerData(),
                        SizedBox(
                          height: 1.h,
                        ),
                        ButtomButtom(
                          title: 'Back',
                          height: 6.5,
                          width: 40,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     ButtomButtom(
                        //       title: 'Add',
                        //       height: 6,
                        //       width: 40,
                        //       color: Colors.green,
                        //     ),
                        //     // ButtomButtom(
                        //     //   title: 'Remove',
                        //     //   height: 6,
                        //     //   width: 40,
                        //     //   color: Colors.deepOrangeAccent,
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -6.h,
                left: (90.w / 2) - 50,
                child: Material(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 6.h,
                    child: Image.asset(
                      'assets/images/two-people.png',
                      height: 8.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
