import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location_review_app/firebase_options.dart';
import 'package:location_review_app/view/login_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
