import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quotes2/services/user_service.dart';  

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final fullName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final phoneNumber = ''.obs;
  final agreePersonalData = false.obs;
  final toggled = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();  

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  void register() async {
  if (formKey.currentState!.validate() && agreePersonalData.value) {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateProfile(displayName: fullNameController.text);
        await _userService.saveUserData(user.uid, fullNameController.text, phoneNumberController.text);

        fullName.value = fullNameController.text;
        Get.offAllNamed('/profile'); 
      }
    } catch (e) {
 
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } else if (!agreePersonalData.value) {
    Get.snackbar(
      'Error',
      'Please agree to the processing of personal data',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}



  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  bool isEmail(String value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(value);
  }
}
