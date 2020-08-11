import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/locationResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.627154781402947, -74.17772915214299),
    zoom: 18,
  );
  GoogleMapController mapController;
  CameraPosition positioned;

  final List<FocusNode> focus = List.generate(5, (i) => FocusNode());
  final TextEditingController _mainController = TextEditingController();
  final TextEditingController _secondaryController = TextEditingController();
  final TextEditingController _plaqueController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  List<Result> rta;

  LocationResponse locationResponse;

  List<City> citys = <City>[
    City('BOGOTA'),
    City('MEDALLO'),
    City('CALI'),
  ];
  List<TypeRoad> typeRoad = <TypeRoad>[
    TypeRoad('Calle'),
    TypeRoad('Carrera'),
    TypeRoad('Transversal')
  ];

  City selectedUser;
  TypeRoad selectedRoad;
  final Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(
            _kGooglePlex.target.longitude, _kGooglePlex.target.longitude),
        draggable: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) {
                mapController = controller;
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraIdle: () async {
                if (positioned != null) {
                  rta = await _getAddress(positioned);
                  print("Ya no lo hago o si?");
                  _validations(rta[0]);
                }
              },
              onCameraMove: ((_position) {
                Future.delayed(const Duration(milliseconds: 1), () {
                  _updatePosition(_position);

                  setState(() {});
                });

                setState(() {
                  positioned = _position;
                });
              }),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<City>(
                          iconEnabledColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          value: selectedUser,
                          hint: Text("Selecciona"),
                          onChanged: (City value) {
                            setState(() {
                              selectedUser = value;
                            });
                          },
                          items: citys.map((City city) {
                            return DropdownMenuItem<City>(
                              value: city,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    city.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.ac_unit),
                      iconSize: 32,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton<TypeRoad>(
                        iconEnabledColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        value: selectedRoad,
                        onChanged: (TypeRoad value) {
                          setState(() {
                            selectedRoad = value;
                          });
                        },
                        hint: Text("Selecciona"),
                        items: typeRoad.map((TypeRoad typeRoad) {
                          return DropdownMenuItem<TypeRoad>(
                            value: typeRoad,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  typeRoad.type,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: TextField(
                        controller: _mainController,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Numero",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: focus[0],
                        onSubmitted: (v) =>
                            FocusScope.of(context).requestFocus(focus[1]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '#',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _secondaryController,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Numero",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: focus[1],
                        onSubmitted: (v) =>
                            FocusScope.of(context).requestFocus(focus[2]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '-',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _plaqueController,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Placa",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: focus[2],
                        onSubmitted: (v) =>
                            FocusScope.of(context).requestFocus(focus[3]),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _complementController,
                  style: TextStyle(fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Edificio, Casa, Apartamento, Bloque...",
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: focus[3],
                  onSubmitted: (v) =>
                      FocusScope.of(context).requestFocus(focus[4]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.home, color: Colors.black),
                      iconSize: 40,
                      onPressed: () => print("ME TOCARON"),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _aliasController,
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Nombre de la dirección",
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: focus[4],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 32),
            color: Colors.orangeAccent,
            child: Text(
              "Agregar Actualizar",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            onPressed: () => print("Actualizdo"),
          ),
        ],
      ),
    );
  }

  void _updatePosition(CameraPosition _position) {
    Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('marker_1'),
        orElse: () => null);
    _markers.remove(marker);
    _markers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
      ),
    );
  }

  void _validations(Result rta) {
    if (rta.addressComponents[0].types[0] == "street_number") {
      String longAdress = rta.addressComponents[0].shortName;
      List seconRoad = longAdress.split("-");
      _secondaryController.text = seconRoad[0];
      _plaqueController.text = seconRoad[1];
    }
    if (rta.addressComponents[1].types[0] == "route") {
      String longAdressMain = rta.addressComponents[1].shortName;
      List main = longAdressMain.split(".");
      switch (main[0].toString()) {
        case "Cl":
          setState(() {
            selectedRoad = typeRoad[0];
          });

          break;
        case "Cra":
          setState(() {
            selectedRoad = typeRoad[1];
          });

          break;
        case "Dg":
          setState(() {
            selectedRoad = typeRoad[2];
          });

          break;
        default:
          selectedRoad = typeRoad[2];
      }
      _mainController.text = main[1];
    }
  }
}

Future<List<Result>> _getAddress(CameraPosition position) async {
  var key = "AIzaSyAxjPtKTUmaHtrQIWBaaVHooHyqtYiH9Vo";
  var url =
      "https://maps.googleapis.com/maps/api/geocode/json?language=es-419&latlng=${position.target.latitude},${position.target.longitude}&key=$key";

  var response = await http.post(url);
  var rtaParseada =
      LocationResponse.fromJson(convert.json.decode(response.body));
  return rtaParseada.results;
}

class City {
  City(this.name);
  final String name;
}

class TypeRoad {
  final String type;
  TypeRoad(this.type);
}
