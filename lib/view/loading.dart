// import 'package:doctors_book_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:location_review_app/constants.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Card(
          child: Container(
            color: Colors.transparent,
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CustomLoadingAnimation(),
          ),
        ),
      ),
    );
  }
}
