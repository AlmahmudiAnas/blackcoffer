import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<User?> createAccount(String userName, String email, String phoneNumber,
    String password, String imgURL) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  try {
    UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      Fluttertoast.showToast(
        msg: "$err",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    });
    print("Account Created Succesfully");
    userCredential.user!.updateDisplayName(userName);
    await _fireStore.collection('users').doc(_auth.currentUser!.uid).set({
      "full name": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "photoURL": imgURL,
      "uid": _auth.currentUser!.uid,
    });
    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> login(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = (await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
    Fluttertoast.showToast(
        msg: "$err",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red);
  }))
      .user;
  try {
    if (user != null) {
      print("Login Succesfull");
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    //print(e);
    return null;
  }
}
