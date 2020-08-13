import 'dart:convert';

CityResponse cityResponseFromJson(String str) =>
    CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  CityResponse({
    this.listpais,
    this.est,
  });

  List<Listpai> listpais;
  int est;

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        listpais: json["listpais"] == null
            ? null
            : List<Listpai>.from(
                json["listpais"].map((x) => Listpai.fromJson(x))),
        est: json["est"] == null ? null : json["est"],
      );

  Map<String, dynamic> toJson() => {
        "listpais": listpais == null
            ? null
            : List<dynamic>.from(listpais.map((x) => x.toJson())),
        "est": est == null ? null : est,
      };
}

class Listpai {
  Listpai({
    this.listdep,
    this.cod,
    this.nombre,
  });

  List<Listdep> listdep;
  int cod;
  String nombre;

  factory Listpai.fromJson(Map<String, dynamic> json) => Listpai(
        listdep: json["listdep"] == null
            ? null
            : List<Listdep>.from(
                json["listdep"].map((x) => Listdep.fromJson(x))),
        cod: json["cod"] == null ? null : json["cod"],
        nombre: json["nombre"] == null ? null : json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "listdep": listdep == null
            ? null
            : List<dynamic>.from(listdep.map((x) => x.toJson())),
        "cod": cod == null ? null : cod,
        "nombre": nombre == null ? null : nombre,
      };
}

class Listdep {
  Listdep({
    this.listciu,
    this.cod,
    this.nombre,
  });

  List<Listciu> listciu;
  int cod;
  String nombre;

  factory Listdep.fromJson(Map<String, dynamic> json) => Listdep(
        listciu: json["listciu"] == null
            ? null
            : List<Listciu>.from(
                json["listciu"].map((x) => Listciu.fromJson(x))),
        cod: json["cod"] == null ? null : json["cod"],
        nombre: json["nombre"] == null ? null : json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "listciu": listciu == null
            ? null
            : List<dynamic>.from(listciu.map((x) => x.toJson())),
        "cod": cod == null ? null : cod,
        "nombre": nombre == null ? null : nombre,
      };
}

class Listciu {
  Listciu({
    this.idciudad,
    this.nomciudad,
    this.tipogeo,
    this.zonas,
    this.atributos1,
    this.atributos2,
    this.atributos3,
    this.latlong,
  });

  int idciudad;
  String nomciudad;
  String tipogeo;
  String zonas;
  String atributos1;
  String atributos2;
  String atributos3;
  String latlong;

  factory Listciu.fromJson(Map<String, dynamic> json) => Listciu(
        idciudad: json["idciudad"] == null ? null : json["idciudad"],
        nomciudad: json["nomciudad"] == null ? null : json["nomciudad"],
        tipogeo: json["tipogeo"] == null ? null : json["tipogeo"],
        zonas: json["zonas"] == null ? null : json["zonas"],
        atributos1: json["atributos1"] == null ? null : json["atributos1"],
        atributos2: json["atributos2"] == null ? null : json["atributos2"],
        atributos3: json["atributos3"] == null ? null : json["atributos3"],
        latlong: json["latlong"] == null ? null : json["latlong"],
      );

  Map<String, dynamic> toJson() => {
        "idciudad": idciudad == null ? null : idciudad,
        "nomciudad": nomciudad == null ? null : nomciudad,
        "tipogeo": tipogeo == null ? null : tipogeo,
        "zonas": zonas == null ? null : zonas,
        "atributos1": atributos1 == null ? null : atributos1,
        "atributos2": atributos2 == null ? null : atributos2,
        "atributos3": atributos3 == null ? null : atributos3,
        "latlong": latlong == null ? null : latlong,
      };
  String toRawJson() => json.encode(toJson());
}
