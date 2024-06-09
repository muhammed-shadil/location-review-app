import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.position});
  final Position? position;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.position!.latitude);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ttttt"),
      ),
      body: GoogleMap(
        onTap: (argument) {},
        indoorViewEnabled: true,
        fortyFiveDegreeImageryEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId("my loction"),
              position:
                  LatLng(widget.position!.latitude, widget.position!.longitude),
              infoWindow: const InfoWindow(
                  title: "shadil", snippet: "this is your location"))
        },
        initialCameraPosition:
            const CameraPosition(target: LatLng(11.2487, 75.8335), zoom: 14),
      ),
    );
  }
}
