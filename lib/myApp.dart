import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes2/app_bindings/app_bindings.dart';
import 'package:quotes2/routes/routes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(), 
      initialRoute: '/splash', 
      getPages: AppRoutes.routes,
    );
  }
}