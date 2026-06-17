import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/controller/wardan_controller.dart';
import 'package:echallan/screens/users_screens/challan_form_screen.dart';
import 'package:echallan/utils/details_text.dart';
import 'package:echallan/utils/details_text_2.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class OwnerDetailsScreen extends StatelessWidget {
  OwnerDetailsScreen({super.key});
  //var adminController = Get.find<AdminController>();
  var wardenController = Get.find<WardanController>();
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
          title: Text(
            "OWNER DETAILS",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 60),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: CircleAvatar(
                    radius: 10.h,
                    backgroundImage: AssetImage('assets/images/profile1.png'),
                  )),
                  Text(
                    wardenController.name.text,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor),
                  ),
                  //main container
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 100.w,
                    // height: 30.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5.h)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 15, right: 15, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          DetailsText(
                              title: "Owner name:",
                              content: wardenController.name.text),
                          DetailsText(
                              title: "Owner CNIC:",
                              content: wardenController.cnic.text),
                          DetailsText(
                              title: "Owner City:", content: "Abbottbad"),
                          DetailsText(
                              title: "License No:",
                              content: wardenController.licence.text),
                          DetailsText(
                              title: "Mobile No:",
                              content: wardenController.phone.text),
                          DetailsText(
                              title: "Vehicle No:",
                              content: wardenController.vehicle_no.text),
                          DetailsText(
                              title: "Fine Stutus:",
                              content: wardenController.paymentStatus.value)
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Container(
                    width: 100.w,
                    // height: 30.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5.h)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  "Challan NO 1",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Image.asset(
                                  "assets/images/challan.jpeg",
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
                                  "20-04-2024",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                DetailsText2(
                                    title: "Officer Name:",
                                    content: "M.D haannd"),
                                DetailsText2(
                                    title: "Officer ID:", content: "123456"),
                                DetailsText2(
                                    title: "Division:", content: "A-B-C"),
                                DetailsText2(
                                    title: "Location:", content: "A-B-C")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 100.w,
                    // height: 30.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5.h)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Column(
                              children: [
                                Text(
                                  "Challan NO 1",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Image.asset(
                                  "assets/images/challan.jpeg",
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
                                  "20-04-2024",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                DetailsText2(
                                    title: "Officer Name:",
                                    content: "M.D haannd"),
                                DetailsText2(
                                    title: "Officer ID:", content: "123456"),
                                DetailsText2(
                                    title: "Division:", content: "A-B-C"),
                                DetailsText2(
                                    title: "Location:", content: "A-B-C")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: Align(
        //   alignment: Alignment.bottomCenter,
        //   child: LogButton(
        //     title: "challan Form",
        //     onpress: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => ChallanFormScreen()),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}
