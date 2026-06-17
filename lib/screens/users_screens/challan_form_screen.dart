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
            leading: Icon(
              Icons.arrow_back,
              size: 4.h,
              color: Constants.textColor,
            ),
            title: const Text(
              "CHALLAN FORM",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    FormTextfields(
                      controller: wardan_controller.name,
                      hintText: "Enter Name",
                      title: 'Name',
                    ),
                    //CNIC
                    FormTextfields(
                      controller: wardan_controller.cnic,
                      hintText: "1234567",
                      title: 'Owner CNIC',
                    ),

                    //mobile No
                    FormTextfields(
                      controller: wardan_controller.phone,
                      hintText: "030000000",
                      title: 'Mobile NO',
                    ),
                    //Lincence No
                    FormTextfields(
                      controller: wardan_controller.licence,
                      hintText: "1234567",
                      title: 'Lincence',
                    ),
                    //Vehicle NO
                    FormTextfields(
                      controller: wardan_controller.vehicle_no,
                      hintText: "1234567",
                      title: 'Vehicle NO',
                    ),

                    //drop down
                    const DropDown(),

                    SizedBox(
                      height: 7.h,
                      child: Obx(
                        () => SizedBox(
                          height: 10.h,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 7.h,
                                width: 40.w,
                                child: ListTile(
                                  title: const Text('Paid'),
                                  leading: Radio<String>(
                                    activeColor: Colors.black,
                                    value: 'paid',
                                    groupValue:
                                        wardan_controller.paymentStatus.value,
                                    onChanged: (value) {
                                      wardan_controller
                                          .updatePaymentStatus(value!);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                                width: 50.w,
                                child: ListTile(
                                  title: const Text('Unpaid'),
                                  leading: Radio<String>(
                                    activeColor: Colors.black,
                                    value: 'unpaid',
                                    groupValue:
                                        wardan_controller.paymentStatus.value,
                                    onChanged: (value) {
                                      wardan_controller
                                          .updatePaymentStatus(value!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Obx(
            () => wardan_controller.isloading.value
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: const CircularProgressIndicator())
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: LogButton(
                      title: "Genarate challan",
                      onpress: () {
                        wardan_controller.storeChallanDetails();
                      },
                    ),
                  ),
          )),
    );
  }
}
