// To parse this JSON data, do
//
//     final addresResponse = addresResponseFromJson(jsonString);

import 'dart:convert';

AddresResponse addresResponseFromJson(String str) =>
    AddresResponse.fromJson(json.decode(str));

String addresResponseToJson(AddresResponse data) => json.encode(data.toJson());

class AddresResponse {
  AddresResponse({
    this.direction,
    this.coordinates,
  });

  Direction direction;
  Coordinates coordinates;

  factory AddresResponse.fromJson(Map<String, dynamic> json) => AddresResponse(
        direction: json["direction"] == null
            ? null
            : Direction.fromJson(json["direction"]),
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "direction": direction == null ? null : direction.toJson(),
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
}

class Direction {
  Direction({
    this.country,
    this.city,
    this.zone,
    this.typeRoad,
    this.mainRoad,
    this.secondaryRoad,
    this.plaque,
    this.cardinalPoint,
  });

  String country;
  String city;
  dynamic zone;
  String typeRoad;
  String mainRoad;
  String secondaryRoad;
  String plaque;
  dynamic cardinalPoint;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        zone: json["zone"],
        typeRoad: json["typeRoad"] == null ? null : json["typeRoad"],
        mainRoad: json["mainRoad"] == null ? null : json["mainRoad"],
        secondaryRoad:
            json["secondaryRoad"] == null ? null : json["secondaryRoad"],
        plaque: json["plaque"] == null ? null : json["plaque"],
        cardinalPoint: json["cardinalPoint"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "city": city == null ? null : city,
        "zone": zone,
        "typeRoad": typeRoad == null ? null : typeRoad,
        "mainRoad": mainRoad == null ? null : mainRoad,
        "secondaryRoad": secondaryRoad == null ? null : secondaryRoad,
        "plaque": plaque == null ? null : plaque,
        "cardinalPoint": cardinalPoint,
      };
}
