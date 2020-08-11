import 'dart:convert';

import 'package:flutter/material.dart';

LocationRequest locationRequestFromJson(String str) =>
    LocationRequest.fromJson(json.decode(str));

String locationRequestToJson(LocationRequest data) =>
    json.encode(data.toJson());

class LocationRequest {
  LocationRequest({
    @required this.latitud,
    @required this.longitud,
  });

  double latitud;
  double longitud;

  factory LocationRequest.fromJson(Map<double, dynamic> json) =>
      LocationRequest(
        latitud: json["latitud"],
        longitud: json["longitud"],
      );

  Map<String, double> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
      };
  String toRawJson() => json.encode(toJson());
}
