import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/screens/wardan/chart.dart';
import 'package:echallan/screens/wardan/paid_challan.dart';
import 'package:echallan/screens/wardan/total_challan.dart';
import 'package:echallan/screens/wardan/total_officers.dart';
import 'package:echallan/screens/wardan/unpaid.dart';
import 'package:echallan/utils/admin_cards.dart';
import 'package:echallan/utils/app_drawer.dart';
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
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          elevation: 0,
          title: const Text(
            "ADMIN DASHBOARD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 13),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/profile1.png'),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overview Dashboard",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  "Welcome, ${adminController.userName.value}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => AdminCards(
                          title: "Total Officers",
                          count: adminController.usersList.length,
                          icon: Icons.people_alt_rounded,
                          iconColor: const Color(0xFF2563EB), // Blue 600
                          iconBgColor: const Color(0xFFDBEAFE), // Blue 100
                          onPress: () {
                            Get.to(() => const TotalOfficers());
                          },
                        )),
                    Obx(() => AdminCards(
                          title: "Total Challans",
                          count: adminController.challanList.length,
                          icon: Icons.assignment_rounded,
                          iconColor: const Color(0xFF7C3AED), // Purple 600
                          iconBgColor: const Color(0xFFF5F3FF), // Purple 100
                          onPress: () {
                            Get.to(() => TotalChallan());
                          },
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => AdminCards(
                          title: "Paid Challan",
                          count: adminController.paidChallans.length,
                          icon: Icons.check_circle_rounded,
                          iconColor: const Color(0xFF059669), // Green 600
                          iconBgColor: const Color(0xFFD1FAE5), // Green 100
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaidChallan(),
                              ),
                            );
                          },
                        )),
                    Obx(() => AdminCards(
                          title: "Unpaid Challan",
                          count: adminController.unpaidChallans.length,
                          icon: Icons.warning_rounded,
                          iconColor: const Color(0xFFDC2626), // Red 600
                          iconBgColor: const Color(0xFFFEE2E2), // Red 100
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Unpaid(),
                              ),
                            );
                          },
                        )),
                  ],
                ),
                Obx(() => DoughnutChart(
                      paid: adminController.paidChallans.length.toDouble(),
                      unPaid: adminController.unpaidChallans.length.toDouble(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
