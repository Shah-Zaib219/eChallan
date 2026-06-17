import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CamraCaptureScereen extends StatelessWidget {
  CamraCaptureScereen({super.key});
  final imageDetection = Get.put(ImageDetection());

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    imageDetection.pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    imageDetection.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.background,
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          leading: Icon(
            Icons.menu_rounded,
            size: 4.h,
            color: Colors.white,
          ),
          title: Text(
            "Hii ${Get.arguments.toString()}",
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return imageDetection.isLoading.value
                      ? CircularProgressIndicator()
                      : Button(
                          title: "Tap to capture",
                          height: 6.5,
                          width: 60,
                          onPress: () {
                            _showImageSourceDialog(context);
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
