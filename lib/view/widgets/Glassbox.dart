import 'dart:ui';

import 'package:flutter/material.dart';

class Glassbox extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const Glassbox(
      {super.key,
      required this.child,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                        // const Color.fromARGB(255, 250, 223, 141)
                        //     .withOpacity(0.1),
                        // const Color.fromARGB(255, 250, 223, 141)
                        //     .withOpacity(0.3)
                      ])),
            ),
            child
          ],
        ),
      ),
    );
  }
}
