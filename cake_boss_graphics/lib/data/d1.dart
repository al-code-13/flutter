import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class D1 {
  int id;
  String nombre = "";
  String ciudad = "";
  String departamento = "";
  double latitud;
  double longitud;
  D1(
      {this.id,
      this.nombre,
      this.ciudad,
      this.departamento,
      this.latitud,
      this.longitud});
}



// class MyMapsState extends State {
//   final GlobalKey scaffoldKey = GlobalKey();

//   Completer _controller = Completer();
//   Map markers = {};
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(17.4435, 78.3772),
//     zoom: 14.0,
//   );
//   List listMarkerIds = List();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         appBar: AppBar(
//           leading: Icon(Icons.map),
//           backgroundColor: Colors.blue,
//           title: Text("Google Maps With Markers"),
//         ),
//         body: Container(
//           child: GoogleMap(
//             initialCameraPosition: _kGooglePlex,
//             onTap: (_) {},
//             mapType: MapType.normal,
//             markers: Set.of(markers.values),
//             onMapCreated: (GoogleMapController controler) {
//               _controller.complete(controler);

//               MarkerId markerId1 = MarkerId("1");
//               MarkerId markerId2 = MarkerId("2");
//               MarkerId markerId3 = MarkerId("3");

//               listMarkerIds.add(markerId1);
//               listMarkerIds.add(markerId2);
//               listMarkerIds.add(markerId3);

//               Marker marker1 = Marker(
//                   markerId: markerId1,
//                   position: LatLng(17.4435, 78.3772),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueCyan),
//                   infoWindow: InfoWindow(
//                       title: "Hytech City",
//                       snippet: "Snipet Hitech City"));

//               Marker marker2 = Marker(
//                 markerId: markerId2,
//                 position: LatLng(17.4837, 78.3158),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueGreen),
//               );
//               Marker marker3 = Marker(
//                   markerId: markerId3,
//                   position: LatLng(17.5169, 78.3428),
//                   infoWindow: InfoWindow(
//                       title: "Miyapur", onTap: () {}, snippet: "Miyapur"));

//               setState(() {
//                 markers[markerId1] = marker1;
//                 markers[markerId2] = marker2;
//                 markers[markerId3] = marker3;
//               });
//             },
//           ),
//         ));
//   }

  
// }
