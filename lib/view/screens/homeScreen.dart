import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_review_app/controller/authentication/bloc/auth_bloc.dart';
import 'package:location_review_app/controller/review_bloc/review_bloc.dart';
import 'package:location_review_app/view/screens/review_bottomsheet.dart';
import 'package:location_review_app/view/widgets/custom_marker.dart.dart';
import 'package:location_review_app/view/screens/login_screen.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({
    super.key,
  });
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
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  BitmapDescriptor? markerIcon;
  final Set<Marker> _markers = {};
  GoogleMapController? _controller;
  final LatLng _initialPosition = const LatLng(11.2588, 75.7804);
  @override
  void initState() {
    super.initState();
    _fetchMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    print(_markers);
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
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  authBloc.add(LogoutEvent());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LoginScreenWrapper()),
                      (route) => false);
                },
                icon: const Icon(Icons.logout_outlined))
          ],
          title: const Text(
            "GeoReview",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          indoorViewEnabled: true,
          fortyFiveDegreeImageryEnabled: true,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 10,
          ),
        ),
      ),
    );
  }

  Future<void> _fetchMarkers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference locations = firestore.collection('users');

    QuerySnapshot querySnapshot = await locations.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    Set<Marker> fetchedMarkers = {};
    for (var data in allData) {
      var locationData = data as Map<String, dynamic>;
      double latitude = locationData['latitude'];
      double longitude = locationData['longitude'];
      String markerId = locationData['uid'];
      String title = locationData['username'];
      String snippet = locationData['address'];
      final BitmapDescriptor markerIcons =
          await createCustomMarker(locationData['username']);

      if (markerId == user!.uid) {
        _controller!.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 14.0, // Adjust the zoom level as needed
            ),
          ),
        );
      }
      fetchedMarkers.add(Marker(
        onTap: () {
          showBottomSheets(context, locationData);
        },
        markerId: MarkerId(markerId),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: title, snippet: snippet),
        icon: markerIcons,
      )
      );
    }

    print("ssssssssss${fetchedMarkers}");
    setState(() {
      _markers.addAll(fetchedMarkers);
    });
  }
}
