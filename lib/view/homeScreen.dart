import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/controller/review_bloc/review_bloc.dart';
import 'package:location_review_app/controller/review_bottomsheet.dart';
import 'package:location_review_app/view/fff.dart';
import 'package:location_review_app/view/login_screen.dart'; // Ensure this import is correct

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({
    super.key,
  });
  // final User user;
  // final Position? position;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ReviewBloc(),
        ),
      ],
      child: const HomeScreen(
          // user: user,
          ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  // final Position? position;
  // final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BitmapDescriptor? markerIcon;
  final Set<Marker> _markers = {};
  GoogleMapController? _controller;
  @override
  void initState() {
    super.initState();
    // _addCustomMarker();
    _fetchMarkers();
  }

  // Future<void> _addCustomMarker() async {
  //   final BitmapDescriptor markerIcons = await createCustomMarker("shadil");
  //   setState(() {
  //     markerIcon = markerIcons;
  //   });

  // Add the user's current location marker
  // _markers.add(
  //   Marker(
  //     markerId: const MarkerId("current_location"),
  //     position: LatLng(widget.position!.latitude, widget.position!.longitude),
  //     infoWindow: const InfoWindow(
  //         title: "Your Location", snippet: "This is your current location"),
  //     icon: markerIcons,
  //   ),
  // );
  // }

  Future<void> _fetchMarkers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference locations = firestore.collection('users');

    QuerySnapshot querySnapshot = await locations.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    Set<Marker> fetchedMarkers = {};

    for (var data in allData) {
      var locationData = data as Map<String, dynamic>;
      print(locationData);
      print(locationData['latitude']);
      print(locationData['latitude']);
      double latitude = locationData['latitude'];
      double longitude = locationData['longitude'];
      String markerId = locationData['uid'];
      String title = locationData['username'];
      String snippet = locationData['address'];
//  Future<void> _addCustomMarker() async {
      final BitmapDescriptor markerIcons =
          await createCustomMarker(locationData['username']);
      // setState(() {
      //   markerIcon = markerIcons;
      // });}
      fetchedMarkers.add(Marker(
        onTap: () {
          showBottomSheets(context, locationData);
        },
        markerId: MarkerId(markerId),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: title, snippet: snippet),
        icon: markerIcons,
      ));
    }

    setState(() {
      print("fetcher$fetchedMarkers");

      _markers.addAll(fetchedMarkers);
      print("mrker$_markers");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "mrkerssssssssssssssssssssssssssssssssssssssssssssssssssssss$_markers");
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final revieBloc = BlocProvider.of<ReviewBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sign out"),
            ),
          );
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            authBloc.add(LogoutEvent());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreenWrapper()),
                (route) => false);
          },
          child: Icon(Icons.logout_outlined),
        ),
        appBar: AppBar(
          title: const Text("google map"),
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          // onTap: (argument) {},
          indoorViewEnabled: true,
          fortyFiveDegreeImageryEnabled: true,
          markers: _markers,
          initialCameraPosition: const CameraPosition(
            target: LatLng(11.2588, 75.7804),
            zoom: 10,
          ),
        ),
      ),
    );
  }
}
