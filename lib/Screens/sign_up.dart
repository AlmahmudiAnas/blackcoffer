import 'package:blackcoffer/My%20Widgets/my_button.dart';
import 'package:blackcoffer/Screens/otp_screen.dart';
import 'package:blackcoffer/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static String routeName = "Signup Screen";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
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
                  SizedBox(height: size.height * 0.1),
                  Image.asset(
                    "images/logo1.png",
                    scale: 3.5,
                  ),
                  SizedBox(height: size.height * 0.1),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("UserName"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Phone number"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width: size.width * 0.05),
                      Text(
                        "Upload photo",
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        width: 95,
                        height: 95,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButton(
                    size: size,
                    buttonText: 'Next',
                    onPressed: () {
                      Navigator.pushNamed(context, OTPScreen.routeName);
                    },
                    color: kScondaryColor,
                    textColor: kPrimaryColor,
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
