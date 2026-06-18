import 'dart:io';

import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/screens/users_screens/challan_form_screen.dart';
import 'package:echallan/screens/users_screens/owner_details_screen.dart';
import 'package:echallan/screens/users_screens/add_vehicle_screen.dart';
import 'package:echallan/utils/prgressbar.dart';
import 'package:echallan/utils/reg_buttons.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({super.key});
  final imageDetection = Get.find<ImageDetection>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.background,
        appBar: AppBar(
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
          backgroundColor: Constants.buttonColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  // Image
                  Center(
                    child: Container(
                      width: 85.w,
                      height: 32.h,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white24,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.file(
                        File(imageDetection.selectedImagePath.value),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  //prgress bar
                  Prgressbar(
                    flag: imageDetection.isGetData.value,
                  ),
                  Text(
                    imageDetection.isGetData.value
                        ? "Record Found"
                        : "No Record Found for Plate: ${imageDetection.extractedText.value}\nPlease Register or Capture Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: imageDetection.isGetData.value
                            ? Constants.textColor
                            : Colors.red,
                        fontWeight: FontWeight.w500),
                  ),

                  SizedBox(
                    height: 3.h,
                  ),
                  RegButtons(
                    title: "Generate Challan",
                    onPress: () {
                      Get.to(() => ChallanFormScreen());
                    },
                    isEnabled: imageDetection.isGetData.value,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  RegButtons(
                    title: "OWNER DETAILS",
                    isEnabled: imageDetection.isGetData.value,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  if (!imageDetection.isGetData.value) ...[
                    SizedBox(
                      height: 3.h,
                    ),
                    RegButtons(
                      title: "Register New Vehicle",
                      isEnabled: true,
                      onPress: () {
                        Get.to(() => const AddVehicleScreen());
                      },
                    ),
                  ],
                  SizedBox(height: 3.h),
                  RegButtons(
                    title: "Capture Again",
                    isEnabled: imageDetection.isGetData.value ? false : true,
                    onPress: () {
                      Get.put(ImageDetection());
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

