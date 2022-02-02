import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/screens/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        dialogBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
    home: Home(),
  ));
}
