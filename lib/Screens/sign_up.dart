import 'dart:io';
import 'dart:math';

import 'package:blackcoffer/Module/auth_methods.dart';
import 'package:blackcoffer/My%20Widgets/my_button.dart';
import 'package:blackcoffer/Screens/otp_screen.dart';
import 'package:blackcoffer/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  static String routeName = "Signup Screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _phoneNumberController = TextEditingController();

  XFile? imgXFile;

  final ImagePicker imagePicker = ImagePicker();

  User? user = FirebaseAuth.instance.currentUser;

  FirebaseStorage storage = FirebaseStorage.instance;

  String imgURL = '';

  bool imgUploading = false;

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref = FirebaseStorage.instance
        .ref('users profile image')
        .child(path.basename(image!.path));
    try {
      setState(() {
        imgUploading = true;
      });
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);
        setState(() {
          imgURL = value;
          imgUploading = false;
        });
        Fluttertoast.showToast(
          msg: "Image uploaded successfully",
          toastLength: Toast.LENGTH_LONG,
        );
      });
    } catch (e) {
      print(e);
    }
  }

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
                    keyboardType: TextInputType.phone,
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
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: size.width * 0.05),
                        Text(
                          "Upload photo",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        imgUploading == true
                            ? CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {
                                  pickUploadImage();
                                },
                                child: SizedBox(
                                  width: 95,
                                  height: 95,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  MyButton(
                    size: size,
                    buttonText: 'Next',
                    onPressed: () async {
                      createAccount(
                              _nameController.text,
                              _emailController.text,
                              _phoneNumberController.text,
                              _passwordController.text,
                              imgURL)
                          .then((user) {
                        if (user != null) {
                          print("Account created");
                          Navigator.pushNamed(context, OTPScreen.routeName);
                        } else {
                          print("Failed to create account");
                        }
                      });
                      // Navigator.pushNamed(context, OTPScreen.routeName);
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
