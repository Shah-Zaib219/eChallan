import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/screens/users_screens/camra_capture_scerren.dart';
import 'package:echallan/screens/wardan/dash_bord.dart';
import 'package:echallan/utils/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var userId;
  var wardenName;

  void login() async {
    // Check if fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter email and password",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      userId = userCredential.user!.uid;
      print("User ID: $userId");

      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDocument.exists) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          "User data not found in database. Please contact support.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      var role = userDocument.data()?['role'] ?? '';
      wardenName = (userDocument.data()?['first_name'] ?? '') +
          (userDocument.data()?['last_name'] ?? '');

      final authService = Get.find<AuthService>();
      await authService.saveUserSession(
        uid: userId,
        role: role,
        firstName: userDocument.data()?['first_name'] ?? '',
        lastName: userDocument.data()?['last_name'] ?? '',
        email: userDocument.data()?['email'] ?? '',
      );

      isLoading.value = false;
      emailController.clear();
      passwordController.clear();

      // Show success message
      Get.snackbar(
        "Welcome! ✓",
        "Successfully logged in as ${role?.toString().toUpperCase()}",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );

      if (role == "admin") {
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAll(() => DashBord());
      } else if (role == "warden") {
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAll(() => CamraCaptureScereen(),
            arguments: userDocument.data()?['first_name'] ?? 'Warden');
      } else {
        Get.snackbar(
          "Error",
          "Unknown role: $role",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email format";
          break;
        case 'user-disabled':
          errorMessage = "This account has been disabled";
          break;
        case 'too-many-requests':
          errorMessage = "Too many attempts. Try again later";
          break;
        case 'network-request-failed':
          errorMessage = "Network error. Check your connection";
          break;
        default:
          errorMessage = e.message ?? "Authentication failed";
      }
      Get.snackbar(
        "Login Failed",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      );
      print("Firebase Auth Error: ${e.code} - ${e.message}");
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      );
      print("General Error: $e");
    }
  }
}
