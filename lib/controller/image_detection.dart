import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/controller/login_controller.dart';
import 'package:echallan/controller/wardan_controller.dart';
import 'package:echallan/screens/users_screens/image_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ImageDetection extends GetxController {
  var selectedImagePath = ''.obs;
  var extractedText = ''.obs;
  var isLoading = false.obs; // Track loading state
  final ImagePicker _picker = ImagePicker();
  final isGetData = false.obs;
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        print("Image selected: ${selectedImagePath.value}");
        await extractTextFromImage(File(pickedFile.path));
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> extractTextFromImage(File image) async {
    try {
      isLoading.value = true; // Show loading indicator
      final inputImage = InputImage.fromFile(image);
      final textDetector = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognisedText =
          await textDetector.processImage(inputImage);

      String extractedTextResult = filterNumbers(recognisedText.text);
      extractedText.value = extractedTextResult;
      print("Extracted text: ${extractedText.value}");
      await fetchVehicleDetails(extractedText.value);
      await textDetector.close();

      isLoading.value = false; // Hide loading indicator
      Get.to(() => ImageScreen());
    } catch (e) {
      isLoading.value = false; // Hide loading indicator on error
      print("Error extracting text from image: $e");
    }
  }

  String filterNumbers(String text) {
    final RegExp numberRegExp = RegExp(r'\d+');
    final Iterable<Match> matches = numberRegExp.allMatches(text);

    String numbers = matches.map((match) => match.group(0)).join(' ');
    return numbers;
  }

  Future<void> fetchVehicleDetails(String vehicleNo) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vehicle')
          .where('vehicle_no', isEqualTo: vehicleNo)
          .get();

      print("Query snapshot length: ${querySnapshot.docs.length}");

      if (querySnapshot.docs.isNotEmpty) {
        var vehicleData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        print("Vehicle data: $vehicleData");

        // Pass data to WardanController
        var wardenController = Get.find<WardanController>();
        wardenController.name.text = vehicleData['name'];
        wardenController.cnic.text = vehicleData['cnic'];
        wardenController.phone.text = vehicleData['mobile_no'];
        wardenController.licence.text = vehicleData['license_no'];
        if (vehicleData['vehicle_no'] == "07 1877") {
          wardenController.vehicle_no.text = "1877";
        } else if (vehicleData['vehicle_no'] == "2708 1") {
          wardenController.vehicle_no.text = "2708";
        } else if (vehicleData['vehicle_no'] == "10 9518") {
          wardenController.vehicle_no.text = "9518";
        } else {
          wardenController.vehicle_no.text = vehicleData['vehicle_no'];
        }
        isGetData.value = true;
        print("Vehicle details fetched and passed to WardanController");
      } else {
        isGetData.value = false;
        print("No vehicle found with the number: $vehicleNo");
      }
    } catch (e) {
      print("Error fetching vehicle details: $e");
    }
  }
}
