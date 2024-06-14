import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_review_app/controller/review_bloc/review_bloc.dart';
import 'package:location_review_app/firebase_options.dart';
import 'package:location_review_app/view/login_screen.dart';
import 'package:location_review_app/view/splashScreeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ReviewBloc(),
      )
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MyApp()),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SplashScreenWrapper();
  }
}
