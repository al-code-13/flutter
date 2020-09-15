// To parse this JSON data, do
//
//     final AddresResponse = AddresResponseFromJson(jsonString);

import 'dart:convert';

AddresResponse addresResponseFromJson(String str) =>
    AddresResponse.fromJson(json.decode(str));

String addresResponseToJson(AddresResponse data) => json.encode(data.toJson());

class AddresResponse {
  AddresResponse({
    this.direction,
    this.coordinates,
  });

  String direction;
  Coordinates coordinates;

  factory AddresResponse.fromJson(Map<String, dynamic> json) => AddresResponse(
        direction: json["direction"] == null ? null : json["direction"],
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "direction": direction == null ? null : direction,
        "coordinates": coordinates == null ? null : coordinates.toJson(),
      };
}

class Coordinates {
  Coordinates({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
  String toRawJson() => json.encode(toJson());
}
