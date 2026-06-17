import 'package:echallan/constants/constants.dart';
import 'package:echallan/utils/chln_details_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChallanCard extends StatelessWidget {
  final String title;
  final int count;
  final String officerId;
  final String date;

  const ChallanCard(
      {super.key,
      required this.title,
      required this.count,
      required this.officerId,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(2.5.h),
      child: Container(
        width: 90.w,
        decoration: BoxDecoration(
            color: Constants.textColor,
            borderRadius: BorderRadius.circular(2.5.h),
            border: Border.all(width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Challan NO ${count}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Image.asset(
                      "assets/images/pencil.png",
                      height: 11.h,
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ChlnDetailsText(title: "Officer Name:", content: title),
                    ChlnDetailsText(title: "Officer ID:", content: officerId),
                    ChlnDetailsText(title: "Division:", content: "Hazara"),
                    ChlnDetailsText(title: "Location:", content: "Abbottabad")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
