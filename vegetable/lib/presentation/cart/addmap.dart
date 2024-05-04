import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Fluttermap extends StatefulWidget {
  const Fluttermap({super.key});

  @override
  State<Fluttermap> createState() => _FluttermapState();
}

Position? _currentLocation;
bool servicePermission = false;
LocationPermission permission = LocationPermission.denied;
String _currentAddress = "";
bool showSyncText =
    true; // Variabel untuk mengontrol apakah teks "Klik icon untuk sinkronisasi" ditampilkan

Future<Position> _getCurrentLocation() async {
  servicePermission = await Geolocator.isLocationServiceEnabled();
  if (!servicePermission) {
    print("Service Disabled");
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  return await Geolocator.getCurrentPosition();
}

_getAddressFromCoordinates() async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
    );

    Placemark place = placemarks[0];

    
  } catch (e) {
    print(e);
  }
}

class _FluttermapState extends State<Fluttermap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      FlutterMap(
        options: const MapOptions(
          center: LatLng(-7.238141, 112.734710),
          zoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      )
    ]));
  }
}
