import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes2/controllers/profile_controller.dart';
import 'package:quotes2/firebase_options.dart';
import 'package:quotes2/myApp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
Get.put(ProfileController());
  runApp(const MyApp());
}

