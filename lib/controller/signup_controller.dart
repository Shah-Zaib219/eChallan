import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/screens/onboarding_screen/main_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final isLoading = false.obs;

  void register(var role) async {
    // Validate all fields
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate email format
    if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate password length
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      Get.log("Starting signup for role: $role");
      Get.log("Calling Firebase Auth createUserWithEmailAndPassword API...");

      // First create user in Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.log("API SUCCESS: Firebase Auth user created successfully.");
      Get.log("================ SIGNUP RESPONSE DETAILS ================");
      Get.log("User UID: ${userCredential.user?.uid}");
      Get.log("User Email: ${userCredential.user?.email}");
      Get.log("Is Email Verified: ${userCredential.user?.emailVerified}");
      Get.log("Creation Time: ${userCredential.user?.metadata.creationTime}");
      Get.log(
          "Last Sign In Time: ${userCredential.user?.metadata.lastSignInTime}");
      Get.log(
          "Additional User Info: ${userCredential.additionalUserInfo?.toString()}");
      Get.log("========================================================");

      // Generate random ID
      String generateRandomId() {
        final random = Random();
        return (random.nextInt(90000) + 10000).toString();
      }

      String randomId = generateRandomId();

      Get.log("Calling Firestore set document API...");
      // Store user data in Firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'id': randomId,
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'role': role,
      });

      Get.log("API SUCCESS: Firestore document saved successfully.");
      Get.log(
          "Firestore Saved Document Data: { id: $randomId, first_name: ${firstNameController.text.trim()}, last_name: ${lastNameController.text.trim()}, email: ${emailController.text.trim()}, role: $role }");
      Get.log("========================================================");

      // Clear controllers
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // IMPORTANT: Stop loading FIRST before showing snackbar
      isLoading.value = false;

      // Show success message
      Get.snackbar(
        'Success! ✓',
        'Account created successfully as ${role?.toString().toUpperCase()}! Please login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );

      // Navigate back to login screen
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(() => const MainScreen());
    } on FirebaseAuthException catch (e) {
      Get.log("API FAILURE: Signup failed at Firebase Auth step.");
      Get.log("Firebase Auth Error Code: ${e.code}");
      Get.log("Firebase Auth Error Message: ${e.message}");

      // Make sure to stop loading on error
      isLoading.value = false;

      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak (min 6 characters)';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Check your internet connection';
          break;
        default:
          errorMessage = e.message ?? 'Registration failed';
      }
      Get.snackbar(
        'Registration Failed',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      );
      passwordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.log("API FAILURE: Signup failed with a general error.");
      Get.log("General Error Description: $e");

      // Make sure to stop loading on any error
      isLoading.value = false;

      passwordController.clear();
      confirmPasswordController.clear();
      Get.snackbar(
        'Error',
        'Something went wrong: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
