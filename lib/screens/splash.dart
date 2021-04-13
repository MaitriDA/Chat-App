import 'dart:async';
import 'package:baatein/screens/aboutUs.dart';
import 'package:baatein/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new HomePage(),
      backgroundColor: Colors.grey.shade100,
      image: new Image.asset("assets/images/logo.png"),
      loadingText: Text("Loading... "),
      photoSize: 150.0,
      loaderColor: Colors.lightBlue,
    );
  }
}