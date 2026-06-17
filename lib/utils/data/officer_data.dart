import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class OfficerData extends StatelessWidget {
  OfficerData({super.key});

  final admin_controller = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Expanded(child: Obx(() {
      if (admin_controller.usersList.isEmpty) {
        return Center(
          child: Text("No Warden Found"),
        );
      }
      return ListView.builder(
        itemCount: admin_controller.usersList.length,
        itemBuilder: (context, index) {
          var user = admin_controller.usersList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Stack(
              children: [
                Card(
                  color: Constants.buttonColor,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  
                  child: SizedBox(
                    height: 8.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.5.h),
                      child: InkWell(
                        child: ListTile(
                          title: Text(
                            'Warden Name ${user.firstName}  ${user.lastName}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Warden ID: ${user.id}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: CircleAvatar(
                    radius: 4.h,
                    backgroundColor: Constants.textColor,
                    child: Icon(Icons.person, color: Colors.black, size: 5.h),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }));
  }
}
