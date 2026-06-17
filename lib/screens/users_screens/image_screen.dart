import 'dart:io';

import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/screens/users_screens/challan_form_screen.dart';
import 'package:echallan/screens/users_screens/owner_details_screen.dart';
import 'package:echallan/utils/prgressbar.dart';
import 'package:echallan/utils/reg_buttons.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get/get.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({super.key});
  var imageDetection = Get.find<ImageDetection>();

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
          padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
          child: Column(
            children: [
              // Image
              Center(
                child: Container(
                  width: 80.w,
                  height: 30.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.file(
                    File(imageDetection.selectedImagePath.value),
                    fit: BoxFit.fill,
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
                    : "No Record Found Please Capture Again",
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
                        builder: (context) => OwnerDetailsScreen()),
                  );
                },
              ),
              SizedBox(height: 2.h),
              RegButtons(
                title: "Capture Again",
                isEnabled: imageDetection.isGetData.value ? false : true,
                onPress: () {
                  Get.put(ImageDetection());
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
