import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:projeto/routes/Routes.dart';
import 'package:projeto/views/SplashScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
    home: SplashScreen(nextScreen:'/Home', duration: 5000),
  ));
}


