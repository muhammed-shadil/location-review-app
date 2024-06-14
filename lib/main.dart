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
    child: MaterialApp(
      title: 'GeoReview',
      theme: ThemeData(
        primaryColor: const Color(0xFF415a77),
        hintColor: const Color(0xFF778da9),
        iconButtonTheme: IconButtonThemeData(
            style:
                IconButton.styleFrom(foregroundColor: const Color(0xFFe0e1dd))),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF212121)),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF415a77),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFFe0e1dd),
            backgroundColor: const Color(0xFF778da9), // Background color
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFFe0e1dd),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: MyApp()),
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
