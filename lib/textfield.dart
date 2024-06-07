// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_review_app/constants.dart';

class mainTextfield extends StatelessWidget {
  const mainTextfield({
    Key? key,
    required this.controller,
    required this.text,
    required this.obscuretext,
    required this.preficsicon,
    this.suffixIcon,
    this.keyboard,
    required this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String text;
  final bool obscuretext;
  final IconData preficsicon;
  final IconData? suffixIcon;
  final TextInputType? keyboard;
  final String? Function(dynamic value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // obscureText: obscuretext && !ispasswordvisible,
      validator: validator,
      keyboardType: keyboard,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Color.fromARGB(255, 68, 73, 53),
        fontSize: 16,
      ),
      controller: controller,
      decoration: InputDecoration(
        fillColor: constants.white.withOpacity(0.7),
        filled: true,
        errorMaxLines: 3,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        // enabledBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //     borderSide: BorderSide.none),
        // disabledBorder: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20)),
        //   borderSide: BorderSide(
        //     color: Color.fromRGBO(68, 73, 53, 1),
        //     width: 0.55,
        //   ),
        // ),
        // errorBorder: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20)),
        //   borderSide: BorderSide(
        //     color: Color.fromARGB(255, 68, 73, 53),
        //     width: 0.55,
        //   ),
        // ),
        // focusedBorder: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20)),
        //   borderSide: BorderSide(
        //     color: Color.fromARGB(255, 68, 73, 53),
        //     width: 1.5,
        //   ),
        // ),
        hintStyle: const TextStyle(),
        hintText: text,
        // suffixIcon:
        //  (obscuretext)
        // ? IconButton(
        //     color: Colorpalette.primarycolor,
        //     onPressed: () {
        //       context.read<PasswordCubit>().visibilityicon();
        //     },
        //     icon: Icon(ispasswordvisible
        //         ? Icons.visibility
        //         : Icons.visibility_off),
        //   )
        // : null,
        // contentPadding: const EdgeInsets.symmetric(vertical: 7)
      ),
    );
  }
}
