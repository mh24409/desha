// AIzaSyCA74i0VQrZ0VQkYyQL5agtgib646YgQD4
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  LatLng? _initialPosition;
  GoogleMapController? _mapController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((position) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    });
  }

  Future <Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 750,
        width: 430,
        child: Stack(
          children: [
            _initialPosition == null
                ? Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialPosition!, zoom: 15.0),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: {
                      Marker(
                        markerId: MarkerId('myLocation'),
                        position: _initialPosition!,
                      ),
                    },
                  ),
            Positioned(
              top: 50.0,
              left: 15.0,
              right: 15.0,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  // Implement your search logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
