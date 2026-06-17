import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/utils/buttom_buttom.dart';
import 'package:echallan/utils/challan_card.dart';
import 'package:echallan/utils/serch_filter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class PaidChallan extends StatelessWidget {
  PaidChallan({super.key});
  final adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
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
          "PAID CHALLAN",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 9.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 73.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      const Text(
                        "Total paid challan",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2.h),
                      // const SerchFilter(),
                      SizedBox(height: 2.h),
                      Obx(() {
                        if (adminController.paidChallans.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text("No Challan found"),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var user = adminController.paidChallans[index];
                                return ChallanCard(
                                  title:
                                      "${user.officerFirstName ?? 'NA'} ${user.officerLastName ?? ''}",
                                  count: index + 1,
                                  officerId: user.officerId ?? "",
                                  date: user.challanTime,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 2.h),
                              itemCount: adminController.paidChallans.length),
                        );
                      }),
                      ButtomButtom(
                        title: 'Back',
                        height: 6.5,
                        width: 40,
                        color: Colors.green,
                      ),

                      SizedBox(
                        height: 2.h,
                      )
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
                    'assets/images/challan.jpeg',
                    height: 8.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
