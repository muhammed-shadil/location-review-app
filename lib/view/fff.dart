import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarker(String initial) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double size = 80.0;

  // Draw the background circle with border
  final Paint borderPaint = Paint()
    ..color = const ui.Color.fromARGB(255, 220, 222, 226)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10.0;
  final Paint fillPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  canvas.drawCircle(const Offset(size / 2, size / 2), size / 2, fillPaint);
  canvas.drawCircle(const Offset(size / 2, size / 2), size / 2, borderPaint);

  // Draw the initial
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  textPainter.text = TextSpan(
    text: initial[0],
    style: const TextStyle(
      fontSize: 40.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );

  textPainter.layout(minWidth: 0, maxWidth: size);
  textPainter.paint(
    canvas,
    Offset(
      (size - textPainter.width) / 2,
      (size - textPainter.height) / 2,
    ),
  );

  final img =
      await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List uint8List = byteData!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(uint8List);
}
