import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ttttt"),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(11.258753, 75.78041),zoom: 14 ),
      ),
    );
  }
}
