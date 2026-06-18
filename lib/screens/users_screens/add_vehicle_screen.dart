import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/controller/wardan_controller.dart';
import 'package:echallan/screens/users_screens/challan_form_screen.dart';
import 'package:echallan/utils/cnic_formatter.dart';
import 'package:echallan/utils/form_textfields.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _vehicleNoController = TextEditingController();
  final _nameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final imageDetection = Get.find<ImageDetection>();
    _vehicleNoController.text = imageDetection.extractedText.value;
  }

  @override
  void dispose() {
    _vehicleNoController.dispose();
    _nameController.dispose();
    _cnicController.dispose();
    _phoneController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _registerVehicle() async {
    final vehicleNo = _vehicleNoController.text.trim();
    final name = _nameController.text.trim();
    final cnic = _cnicController.text.trim();
    final phone = _phoneController.text.trim();
    final license = _licenseController.text.trim();

    if (vehicleNo.isEmpty ||
        name.isEmpty ||
        cnic.isEmpty ||
        phone.isEmpty ||
        license.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all the fields",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    // Validator: Owner Name (letters and space only)
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(name)) {
      Get.snackbar(
        "Invalid Input",
        "Owner Name must only contain letters and spaces",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    // Validator: CNIC Format (XXXXX-XXXXXXX-X)
    final cnicRegex = RegExp(r'^\d{5}-\d{7}-\d$');
    if (!cnicRegex.hasMatch(cnic)) {
      Get.snackbar(
        "Invalid Input",
        "CNIC must match format XXXXX-XXXXXXX-X (13 digits total)",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    // Validator: Mobile Number (11 digits starting with 03)
    final phoneRegex = RegExp(r'^03\d{9}$');
    if (!phoneRegex.hasMatch(phone)) {
      Get.snackbar(
        "Invalid Input",
        "Mobile Number must be exactly 11 digits starting with 03",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    // Validator: Pakistan Driving License format
    final licenseRegex = RegExp(
      r'^([a-zA-Z]{2,4}-\d{2}-\d{3,7}|\d{5}-\d{7}-\d#\d{1,6}|\d{4,8})$',
      caseSensitive: false,
    );
    if (!licenseRegex.hasMatch(license)) {
      Get.snackbar(
        "Invalid Input",
        "License Number does not match a valid Pakistan license format\n(e.g., LHR-18-1234, CNIC#Sequence, or 1234567)",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Add vehicle info to Firebase Firestore
      await FirebaseFirestore.instance.collection('vehicle').add({
        'vehicle_no': vehicleNo,
        'name': name,
        'cnic': cnic,
        'mobile_no': phone,
        'license_no': license,
      });

      // 2. Populate data in WardanController
      final wardenController = Get.find<WardanController>();
      wardenController.name.text = name;
      wardenController.cnic.text = cnic;
      wardenController.phone.text = phone;
      wardenController.licence.text = license;
      wardenController.vehicle_no.text = vehicleNo;

      // 3. Update ImageDetection state
      final imageDetection = Get.find<ImageDetection>();
      imageDetection.isGetData.value = true;

      Get.snackbar(
        "Success",
        "Vehicle details registered successfully!",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );

      // Route directly to ChallanFormScreen
      Get.off(() => ChallanFormScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to register vehicle: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              size: 4.h,
              color: Constants.textColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "REGISTER VEHICLE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormTextfields(
                  controller: _vehicleNoController,
                  hintText: "Enter Vehicle Number",
                  title: 'Vehicle NO',
                ),
                FormTextfields(
                  controller: _nameController,
                  hintText: "Enter Owner Name",
                  title: 'Owner Name',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                ),
                FormTextfields(
                  controller: _cnicController,
                  hintText: "XXXXX-XXXXXXX-X",
                  title: 'Owner CNIC',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CnicFormatter(),
                  ],
                  maxLength: 15,
                ),
                FormTextfields(
                  controller: _phoneController,
                  hintText: "03000000000",
                  title: 'Mobile NO',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 11,
                ),
                FormTextfields(
                  controller: _licenseController,
                  hintText: "Enter License Number",
                  title: 'License Number',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-#]')),
                  ],
                ),
                SizedBox(height: 4.h),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : LogButton(
                        title: "Register & Proceed",
                        onpress: _registerVehicle,
                      ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
