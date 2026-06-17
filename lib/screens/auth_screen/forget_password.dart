import 'package:echallan/constants/constants.dart';
import 'package:echallan/utils/log_button.dart';
import 'package:echallan/utils/text_input_filed.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  var forgetPasswordController = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 34)),
        backgroundColor: Constants.buttonColor,
        title: Text(
          "Forget Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Forget your password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Don;t worry just Enter your email",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextInputField(
                hintText: "abc@gmail.com",
                obscureText: false,
                controller: forgetPasswordController.email,
              ),
              SizedBox(
                height: 5.h,
              ),
              LogButton(
                  title: "Forget password",
                  onpress: () =>
                      forgetPasswordController.sendPasswordResetEmail())
            ],
          ),
        ),
      ),
    );
  }
}
