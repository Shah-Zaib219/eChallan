import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/wardan_controller.dart';
import 'package:echallan/utils/drop_down.dart';
import 'package:echallan/utils/form_textfields.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ChallanFormScreen extends StatelessWidget {
  ChallanFormScreen({super.key});
  final wardan_controller = Get.find<WardanController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.background,
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 3.h,
              color: Constants.textColor,
            ),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            "CHALLAN FORM",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                FormTextfields(
                  controller: wardan_controller.name,
                  hintText: "Enter Name",
                  title: 'Name',
                ),
                // CNIC
                FormTextfields(
                  controller: wardan_controller.cnic,
                  hintText: "1234567",
                  title: 'Owner CNIC',
                ),
                // Mobile No
                FormTextfields(
                  controller: wardan_controller.phone,
                  hintText: "030000000",
                  title: 'Mobile NO',
                ),
                // Licence No
                FormTextfields(
                  controller: wardan_controller.licence,
                  hintText: "1234567",
                  title: 'Licence',
                ),
                // Vehicle NO
                FormTextfields(
                  controller: wardan_controller.vehicle_no,
                  hintText: "1234567",
                  title: 'Vehicle NO',
                ),
                // Fine Type Dropdown
                const DropDown(),
                const SizedBox(height: 12),
                // Payment Status Radio Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0, bottom: 8),
                        child: Text(
                          "Payment Status",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    activeColor: Colors.white,
                                    value: 'paid',
                                    groupValue: wardan_controller.paymentStatus.value,
                                    onChanged: (value) {
                                      wardan_controller.updatePaymentStatus(value!);
                                    },
                                  ),
                                  const Text(
                                    'Paid',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    activeColor: Colors.white,
                                    value: 'unpaid',
                                    groupValue: wardan_controller.paymentStatus.value,
                                    onChanged: (value) {
                                      wardan_controller.updatePaymentStatus(value!);
                                    },
                                  ),
                                  const Text(
                                    'Unpaid',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding block to prevent keyboard/button overlapping layout content
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => wardan_controller.isloading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : LogButton(
                  title: "Generate Challan",
                  onpress: () {
                    wardan_controller.storeChallanDetails();
                  },
                ),
        ),
      ),
    );
  }
}
