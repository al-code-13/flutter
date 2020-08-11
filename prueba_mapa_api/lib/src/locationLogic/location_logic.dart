import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressRequest.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressResponse.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_mapa_api/src/models/GetLocation/locationRequest.dart';
import 'dart:convert' as convert;
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';

GoogleMapController _controller;
LatLng newPosition;

class LocationLogic {
  Future<AddresResponse> getLocation(
    String city,
    String typeRoad,
    String mainRoad,
    String secondaryRoad,
    String plaque,
  ) async {
    var url = "https://shielded-atoll-43694.herokuapp.com/searchAddress";
    AddresRequest values = AddresRequest(
        city: city,
        typeRoad: typeRoad,
        mainRoad: mainRoad,
        secondaryRoad: secondaryRoad,
        plaque: plaque);
    print(values.toJson());
    try {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: values.toRawJson());
      print(response.body.toString());
      var rtaParseada =
          AddresResponse.fromJson(convert.json.decode(response.body));
      newPosition =
          LatLng(rtaParseada.coordinates.lat, rtaParseada.coordinates.lng);
      setMapController(_controller);
      return rtaParseada;
    } catch (e) {
      print(e);
    }
  }

  Future<LocationResponse> getAddress(CameraPosition position) async {
    var url = "https://shielded-atoll-43694.herokuapp.com/currentLocation";
    LocationRequest values = LocationRequest(
        latitud: position.target.latitude, longitud: position.target.longitude);
    print(values.toJson());
    try {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: values.toRawJson());
      print(response.body.toString());
      var rtaParseada =
          LocationResponse.fromJson(convert.json.decode(response.body));
      return rtaParseada;
    } catch (e) {
      print(e);
    }
  }

  setMapController(GoogleMapController controller) {
    _controller = controller;
    if (newPosition != null) {
      controller.moveCamera(CameraUpdate.newLatLngZoom(newPosition, 18));
    }
  }
}
