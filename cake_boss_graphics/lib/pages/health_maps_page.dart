import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/d1.dart';

class HealthMapPage extends StatefulWidget {
  @override
  _HealthMapPageState createState() => _HealthMapPageState();
}

class _HealthMapPageState extends State<HealthMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  BitmapDescriptor _markerIcon;
  static LatLng point = LatLng(4.870337, -74.053649);
  Set<Marker> _markers = {};
  List<D1> dunos = [
    D1(
        id: 1,
        nombre: "D1 toditos",
        ciudad: "Chía",
        departamento: "Cundinamarca",
        longitud: 4.870337,
        latitud: -73.053649),
    D1(
        id: 2,
        nombre: "D1 toditos",
        ciudad: "Chía",
        departamento: "Cundinamarca",
        longitud: 4.500337,
        latitud: -74.053649),
  ];

  @override
  void initState() {
    llenado();
    super.initState();
  }

  llenado() {
    dunos.map((f) {
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5), 'assets/d1.png')
          .then((onValue) {
        _markerIcon = onValue;
        _markers.add(
          Marker(
            markerId: MarkerId('${f.id}'),
            position: LatLng(f.latitud, f.longitud),
            icon: _markerIcon,
            infoWindow: InfoWindow(title: f.ciudad, snippet: f.departamento),
          ),
        );
      });
    });
  }

  static final CameraPosition _initPosition = CameraPosition(
    target: point,
    zoom: 17.4746,
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _initPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(
              Marker(
                  markerId: MarkerId(''),
                  position: point),
            );
          });
        },
      ),
    );
  }
}
