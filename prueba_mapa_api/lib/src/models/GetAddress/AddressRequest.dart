// To parse this JSON data, do
//
//     final addresRequest = addresRequestFromJson(jsonString);

import 'dart:convert';

AddresRequest addresRequestFromJson(String str) =>
    AddresRequest.fromJson(json.decode(str));

String addresRequestToJson(AddresRequest data) => json.encode(data.toJson());

class AddresRequest {
  AddresRequest({
    this.city,
    this.typeRoad,
    this.mainRoad,
    this.secondaryRoad,
    this.plaque,
  });

  String city;
  String typeRoad;
  String mainRoad;
  String secondaryRoad;
  String plaque;

  factory AddresRequest.fromJson(Map<String, dynamic> json) => AddresRequest(
        city: json["city"] == null ? null : json["city"],
        typeRoad: json["typeRoad"] == null ? null : json["typeRoad"],
        mainRoad: json["mainRoad"] == null ? null : json["mainRoad"],
        secondaryRoad:
            json["secondaryRoad"] == null ? null : json["secondaryRoad"],
        plaque: json["plaque"] == null ? null : json["plaque"],
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "typeRoad": typeRoad == null ? null : typeRoad,
        "mainRoad": mainRoad == null ? null : mainRoad,
        "secondaryRoad": secondaryRoad == null ? null : secondaryRoad,
        "plaque": plaque == null ? null : plaque,
      };
  String toRawJson() => json.encode(toJson());
}
