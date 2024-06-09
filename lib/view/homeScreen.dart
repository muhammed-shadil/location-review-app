import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_review_app/view/fff.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.position,required this.user});
  final Position? position;
  final User user;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BitmapDescriptor? markerIcon;
  @override
  void initState() {
    _addCustomMarker();
    super.initState();
  }

  Future<void> _addCustomMarker() async {
    final user = FirebaseAuth.instance.currentUser;
    final BitmapDescriptor markerIcons = await createCustomMarker(user!.email!);
    setState(() {
      markerIcon = markerIcons;
    });
  }

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
                  title: "shadil", snippet: "this is your location"),
              icon: markerIcon!)
        },
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.position!.latitude, widget.position!.longitude),
            zoom: 14),
      ),
    );
  }
}
