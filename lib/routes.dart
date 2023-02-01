import 'package:blackcoffer/Screens/home_screen.dart';
import 'package:blackcoffer/Screens/intro.dart';
import 'package:blackcoffer/Screens/login.dart';
import 'package:blackcoffer/Screens/otp_screen.dart';
import 'package:blackcoffer/Screens/record_video.dart';
import 'package:blackcoffer/Screens/sign_up.dart';
import 'package:blackcoffer/Screens/video_details.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  VideoDetails.routeName: (context) => VideoDetails(),
  VideoCapture.routeName: (context) => VideoCapture(),
};
