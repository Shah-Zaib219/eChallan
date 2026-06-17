import 'package:echallan/controller/wardan_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    super.key,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _chosenValue = "Wrong Parking(Bike) 300";
  final wardan_controller = Get.put(WardanController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 15, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Text(
              "Fine",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            width: 90
                .w, // This width ensures the container takes 90% of the screen width
            padding: const EdgeInsets.symmetric(
                horizontal: 10), // Added symmetric padding for better alignment
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(3.h),
            ),
            child: DropdownButtonHideUnderline(
              // Used DropdownButtonHideUnderline to remove the default underline
              child: DropdownButton<String>(
                isExpanded:
                    true, // Ensures the dropdown expands to the container width
                focusColor: Colors.white,
                value: _chosenValue,
                style: const TextStyle(
                    color:
                        Colors.black), // Adjusted text color for dropdown items
                iconEnabledColor: Colors.black,
                iconSize: 30, // Increased the arrow size
                items: <String>[
                  "Wrong Parking(Bike) 300",
                  'Wrong Parking(LTV) 500',
                  'Wrong Parking(HTV) 600',
                  'Wrong Parking(Government Vehicle) 500',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10), // Added padding to each item
                      child: Text(
                        value,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _chosenValue = value!;
                    if (value == "Wrong Parking(Bike) 300") {
                      wardan_controller.fine = '300';
                      wardan_controller.fineType = value;
                    } else if (value == 'Wrong Parking(LTV) 500') {
                      wardan_controller.fine = '500';
                      wardan_controller.fineType = value;
                    } else if (value == 'Wrong Parking(HTV) 600') {
                      wardan_controller.fine = '600';
                      wardan_controller.fineType = value;
                    } else if (value ==
                        'Wrong Parking(Government Vehicle) 500') {
                      wardan_controller.fine = '500';
                      wardan_controller.fineType = value;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
