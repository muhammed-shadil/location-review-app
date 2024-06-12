import 'dart:async';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/view/homeScreen.dart';
import 'package:location_review_app/view/login_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: Splashscreen(),
    );
  }
}

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        Timer(const Duration(seconds: 3), () {
          if (state is Authenticated) {
            print("wwwwwwwwwwwwwwwwww${state.position}");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => HomeScreenWrapper(
                          // position: state.position,
                          // user: user!,
                        )));
          } else if (state is UnAuthenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreenWrapper()));
          }
        });
      },
      child: FlutterSplashScreen.fadeIn(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        childWidget: SizedBox(
          width: 200,
          height: 400,
          child: Column(
            children: [
              Image.asset("asset/fff2946959.jpg"),
              const Text(
                "STUwelt",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}