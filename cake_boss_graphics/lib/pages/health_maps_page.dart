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
  Set<Marker> markersV2 = Set();
  List<D1> dunos = [
    D1(
        id: "1",
        nombre: "D1 toditos",
        ciudad: "Chía",
        departamento: "Cundinamarca",
        longitud: 4.870337,
        latitud: -74.053649),
    D1(
        id: "2",
        nombre: "D1 toditos",
        ciudad: "Chía",
        departamento: "Cundinamarca",
        longitud: 4.872337,
        latitud: -74.053649),
    D1(
        id: "3",
        nombre: "D1 toditos",
        ciudad: "Chía",
        departamento: "Cundinamarca",
        longitud: 4.872617,
        latitud: -74.053649),
  ];

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/d1.png')
        .then((onValue) {
      _markerIcon = onValue;
    }).then((onValue) {
      llenado();
    });
  }

  llenado() {
    print("si llego");
    dunos.map((f) {
      Marker resultMarker = Marker(
        icon: _markerIcon,
        markerId: MarkerId(f.id),
        infoWindow:
            InfoWindow(title: "${f.ciudad}", snippet: "${f.departamento}"),
        position: LatLng(f.longitud, f.latitud),
      );
      markersV2.add(resultMarker);
    }).toList();
  }

  static final CameraPosition _initPosition = CameraPosition(
    target: point,
    zoom: 17.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: markersV2,
        mapType: MapType.normal,
        initialCameraPosition: _initPosition,
        onMapCreated: (GoogleMapController controller) {
          print(markersV2);
          _controller.complete(controller);
        },
      ),
    );
  }
}
