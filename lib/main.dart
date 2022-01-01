import 'package:bookstore/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

///---------------------------------------------------
///---------------------------------------------------
///---------------@Flutter_tg-------------------------
///---------------------------------------------------
///---------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IranianSans',
      ),
      home: const SplashScreen(),
    );
  }
}
