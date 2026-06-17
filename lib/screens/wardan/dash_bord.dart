import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/screens/wardan/chart%20copy.dart';
import 'package:echallan/screens/wardan/paid_challan.dart';
import 'package:echallan/screens/wardan/total_challan.dart';
import 'package:echallan/screens/wardan/total_officers.dart';
import 'package:echallan/screens/wardan/unpaid.dart';
import 'package:echallan/utils/admin_cards.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class DashBord extends StatelessWidget {
  DashBord({super.key});
  final adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Constants.background,
            appBar: AppBar(
              backgroundColor: Constants.buttonColor,
              leading: Icon(
                Icons.menu,
                size: 4.h,
                color: Constants.textColor,
              ),
              title: Text(
                "ADMIN",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 13),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile1.png'),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ${adminController.userName.value}",
                        style: TextStyle(
                            fontSize: 25,
                            color: Constants.textColor,
                            fontWeight: FontWeight.w800),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => AdminCards(
                                  title: "Total Officers",
                                  count: adminController.usersList.length,
                                  onPress: () {
                                    // adminController.fetchUsersByRole('warden');
                                    Get.to(() => TotalOfficers());
                                  },
                                )),
                            Obx(() => AdminCards(
                                title: "Total Challan",
                                count: adminController.challanList.length,
                                onPress: () {
                                  Get.to(() => TotalChallan());
                                })),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => AdminCards(
                                title: "Paid challan",
                                count: adminController.paidChallans.length,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaidChallan(),
                                      ));
                                })),
                            Obx(() => AdminCards(
                                title: "Unpaid challan",
                                count: adminController.unpaidChallans.length,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Unpaid(),
                                      ));
                                }))
                          ],
                        ),
                      ),
                      Obx(() => DoughnutChart(
                          paid: adminController.challanList.length.toDouble(),
                          unPaid: 3
                          //  adminController.unpaidChallans.length
                          //      .toDouble(),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
