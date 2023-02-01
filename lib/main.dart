import 'package:blackcoffer/Screens/intro.dart';
import 'package:blackcoffer/Screens/login.dart';
import 'package:blackcoffer/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black Coffer',
      debugShowCheckedModeBanner: false,
      initialRoute: IntroScreen.routeName,
      routes: routes,
    );
  }
}
