import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/wardan_controller.dart';
import 'package:echallan/utils/details_text.dart';
import 'package:echallan/utils/details_text_2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OwnerDetailsScreen extends StatelessWidget {
  OwnerDetailsScreen({super.key});
  final wardenController = Get.find<WardanController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.background,
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          elevation: 0,
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
            "OWNER DETAILS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('challan')
              .where('cnic', isEqualTo: wardenController.cnic.text)
              .snapshots(),
          builder: (context, snapshot) {
            // Get documents if present
            final docs = snapshot.hasData ? snapshot.data!.docs : [];
            
            // Calculate dynamic payment status (Fine Status)
            String dynamicStatus = "Paid";
            if (docs.isNotEmpty) {
              bool hasUnpaid = docs.any((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return (data['payment_status'] ?? 'unpaid').toString().toLowerCase() == 'unpaid';
              });
              dynamicStatus = hasUnpaid ? "Unpaid" : "Paid";
            }

            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 8.h,
                        backgroundImage: const AssetImage('assets/images/profile1.png'),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      wardenController.name.text,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // Main Details Container
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailsText(
                              title: "Owner Name:",
                              content: wardenController.name.text,
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            DetailsText(
                              title: "Owner CNIC:",
                              content: wardenController.cnic.text,
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            const DetailsText(
                              title: "Owner City:",
                              content: "Abbottabad",
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            DetailsText(
                              title: "License No:",
                              content: wardenController.licence.text,
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            DetailsText(
                              title: "Mobile No:",
                              content: wardenController.phone.text,
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            DetailsText(
                              title: "Vehicle No:",
                              content: wardenController.vehicle_no.text,
                            ),
                            const Divider(height: 16, color: Colors.black12),
                            DetailsText(
                              title: "Fine Status:",
                              content: dynamicStatus,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Challan History",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    else if (docs.isEmpty)
                      Container(
                        width: 100.w,
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "No Challan History Found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: docs.length,
                        separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
                        itemBuilder: (context, index) {
                          final data = docs[index].data() as Map<String, dynamic>;
                          
                          // Format Timestamp
                          String formattedDate = "N/A";
                          if (data['challan_time'] != null) {
                            if (data['challan_time'] is Timestamp) {
                              formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(
                                (data['challan_time'] as Timestamp).toDate(),
                              );
                            }
                          } else {
                            formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
                          }

                          final fineType = data['fine_type'] ?? 'Traffic Violation';
                          final fineAmount = data['fine'] ?? '0';
                          final officer = data['officer_name'] ?? 'Traffic Officer';
                          final payStatus = (data['payment_status'] ?? 'unpaid').toString().toLowerCase();
                          final isPaid = payStatus == 'paid';

                          return Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left side info (Challan title & image)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Challan #${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/challan.jpeg",
                                          height: 9.h,
                                          width: 18.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 4.w),
                                  // Right side info (dynamic details)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            // Payment Status Tag
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: isPaid ? Colors.green.shade50 : Colors.red.shade50,
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: isPaid ? Colors.green.shade200 : Colors.red.shade200,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                isPaid ? "PAID" : "UNPAID",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: isPaid ? Colors.green.shade700 : Colors.red.shade700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        DetailsText2(
                                          title: "Violation:",
                                          content: fineType,
                                        ),
                                        SizedBox(height: 0.5.h),
                                        DetailsText2(
                                          title: "Fine Amount:",
                                          content: "Rs. $fineAmount",
                                        ),
                                        SizedBox(height: 0.5.h),
                                        DetailsText2(
                                          title: "Officer Name:",
                                          content: officer,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
