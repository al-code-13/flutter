// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

LocationResponse locationResponseFromJson(String str) =>
    LocationResponse.fromJson(json.decode(str));

String locationResponseToJson(LocationResponse data) =>
    json.encode(data.toJson());

class LocationResponse {
  LocationResponse({
    this.country,
    this.city,
    this.typeRoad,
    this.mainRoad,
    this.secondaryRoad,
    this.plaque,
    this.cardinalPoint,
  });

  String country;
  String city;
  String typeRoad;
  String mainRoad;
  String secondaryRoad;
  String plaque;
  String cardinalPoint;

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        typeRoad: json["typeRoad"] == null ? null : json["typeRoad"],
        mainRoad: json["mainRoad"] == null ? null : json["mainRoad"],
        secondaryRoad:
            json["secondaryRoad"] == null ? null : json["secondaryRoad"],
        plaque: json["plaque"] == null ? null : json["plaque"],
        cardinalPoint:
            json["cardinalPoint"] == null ? null : json["cardinalPoint"],
      );

  Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "city": city == null ? null : city,
        "typeRoad": typeRoad == null ? null : typeRoad,
        "mainRoad": mainRoad == null ? null : mainRoad,
        "secondaryRoad": secondaryRoad == null ? null : secondaryRoad,
        "plaque": plaque == null ? null : plaque,
        "cardinalPoint": cardinalPoint == null ? null : cardinalPoint,
      };
  String toRawJson() => json.encode(toJson());
}
