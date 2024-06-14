import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class constants {
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  //--------------regx----------------//
  static final regemail =
      RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  static final phonreg = RegExp(r"^[6789]\d{9}$");

  static final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static final name = RegExp(r'^[A-Za-z]+$');

  //--------------regx----------------//

  static final loginkey = GlobalKey<FormState>();
  static final signupkey = GlobalKey<FormState>();
}
class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color:Colors.black, size: 50,
     
    );
  }
}