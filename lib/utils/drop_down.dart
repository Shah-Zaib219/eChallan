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
  final wardan_controller = Get.find<WardanController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4.0, bottom: 6),
            child: Text(
              "Fine",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            width: 90.w,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                focusColor: Colors.white,
                value: _chosenValue,
                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                iconEnabledColor: const Color(0xFF1E293B),
                iconSize: 28,
                items: <String>[
                  "Wrong Parking(Bike) 300",
                  'Wrong Parking(LTV) 500',
                  'Wrong Parking(HTV) 600',
                  'Wrong Parking(Government Vehicle) 500',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 16,
                        ),
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
                    } else if (value == 'Wrong Parking(Government Vehicle) 500') {
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
