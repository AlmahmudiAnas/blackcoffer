import 'package:blackcoffer/My%20Widgets/my_button.dart';
import 'package:blackcoffer/Screens/login.dart';
import 'package:blackcoffer/Screens/sign_up.dart';
import 'package:blackcoffer/consts.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  static String routeName = "IntroScreen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kScondaryColor, kPrimaryColor],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.2),
                    Image.asset(
                      "images/logo1.png",
                      scale: 3.5,
                    ),
                    SizedBox(height: size.height * 0.15),
                    MyButton(
                      size: size,
                      buttonText: "Login",
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      color: kScondaryColor,
                      textColor: kPrimaryColor,
                    ),
                    SizedBox(height: size.height * 0.05),
                    MyButton(
                      size: size,
                      buttonText: "Sign up",
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                      color: kScondaryColor,
                      textColor: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
