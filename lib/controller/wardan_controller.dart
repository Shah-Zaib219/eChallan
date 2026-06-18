import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/controller/sms_controller.dart';
import 'package:echallan/screens/users_screens/camra_capture_scerren.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class WardanController extends GetxController {
  final name = TextEditingController();
  final cnic = TextEditingController();
  final phone = TextEditingController();
  final licence = TextEditingController();
  final vehicle_no = TextEditingController();
  String fine = "";
  var fineType = '';
  var smsController = SmsController();
  var isloading = false.obs;
  final LoginController loginController = Get.find<LoginController>();
  var paymentStatus = 'unpaid'.obs;

  void updatePaymentStatus(String status) {
    paymentStatus.value = status;
  }

  Future<void> storeChallanDetails() async {
    // Check if all fields are filled
    if (name.text.isEmpty ||
        cnic.text.isEmpty ||
        phone.text.isEmpty ||
        licence.text.isEmpty ||
        vehicle_no.text.isEmpty) {
      isloading.value = false;
      Get.snackbar("", "Please fill all the fields",
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    var rand = Random();
    var id = rand.nextInt(11);
    // Create a map of data to store
    Map<String, dynamic> challanData = {
      'name': name.text,
      'cnic': cnic.text,
      'phone': phone.text,
      'licence': licence.text,
      'vehicle_no': vehicle_no.text,
      'fine': fine,
      'payment_status': paymentStatus.value,
      'challan_by': loginController.userId,
      'officer_name': loginController.wardenName,
      'fine_type': fineType,
      'challan_time': FieldValue.serverTimestamp(),
    };

    try {
      isloading.value = true;
      // Add the map to the 'challan' collection
      await FirebaseFirestore.instance
          .collection('challan')
          .add(challanData)
          .then((data) {
        print(
            'You Have Been Challaned for the voliation of the ${fineType} and the Amount is ${fine}. Please Submit your Challan on the Given Account Number ${id}   ${phone.text}');
        smsController.sendSmsToUser(
          phone.text,
          'You Have Been Challaned for the voliation of the ${fineType}  and the Amount is ${fine}. Please Submit your Challan on the Given Account Number ${id}5678648903', // Replace with your message
        );
        Get.snackbar("", "Challan sucessfully generated",
            colorText: Colors.white, backgroundColor: Colors.green);
        isloading.value = false;
        Get.to(() => CamraCaptureScereen());
      });
    } catch (e) {
      print("Error storing challan details: $e");
    } finally {
      isloading.value = false;
    }
  }
}
