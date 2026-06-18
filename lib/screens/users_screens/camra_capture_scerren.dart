import 'package:echallan/constants/constants.dart';
import 'package:echallan/controller/image_detection.dart';
import 'package:echallan/utils/auth_service.dart';
import 'package:echallan/utils/button.dart';
import 'package:echallan/utils/app_drawer.dart';
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
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    imageDetection.pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
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
    final authService = Get.find<AuthService>();
    final String wardenName = authService.firstName ?? 'Warden';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.background,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Constants.buttonColor,
          title: Text(
            "Hii $wardenName",
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
                      ? const CircularProgressIndicator()
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
