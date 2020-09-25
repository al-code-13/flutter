import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/bloc/blocCitys/blocExport.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

class RequesCityPage extends StatefulWidget {
  RequesCityPage({Key key}) : super(key: key);

  @override
  _RequesCityPageState createState() => _RequesCityPageState();
}

class _RequesCityPageState extends State<RequesCityPage> {
  TypeRoad selectedRoad;
  final Set<Marker> _markers = Set();
  final TextEditingController mainController = TextEditingController();
  final TextEditingController secondaryController = TextEditingController();
  final TextEditingController plaqueController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();

  static final CameraPosition _initialPositionCamera = CameraPosition(
    target: LatLng(4.627154781402947, -74.17772915214299),
    zoom: 18,
  );
  List<TypeRoad> typeRoad = <TypeRoad>[
    TypeRoad('Calle'),
    TypeRoad('Carrera'),
    TypeRoad('Transversal'),
    TypeRoad('Diagonal'),
    TypeRoad('Null')
  ];
  CameraPosition positioned;

  final List<FocusNode> focus = List.generate(5, (i) => FocusNode());

  @override
  void dispose() {
    super.dispose();
    Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('marker_1'),
        orElse: () => null);
    _markers.remove(marker);
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(_initialPositionCamera.target.longitude,
            _initialPositionCamera.target.longitude),
        draggable: true,
      ),
    );

    return BlocListener<CitysBloc, CitysState>(
      listener: (BuildContext context, state) {
        if (state is UpdateMoveCameraState) {
          if (state.locationResponse != null) {
            validations(state.locationResponse);
          }
        }
      },
      child: BlocBuilder<CitysBloc, CitysState>(
        buildWhen: (_, state) {
          return (state is! UpdateMoveCameraState &&
              state is! UpdateMap &&
              state is! GetLocationState);
        },
        builder: (context, state) {
          //  print(state);
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCitysState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _initialPositionCamera,
                    onMapCreated: state.setMapController,
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onCameraIdle: () async {
                      if (positioned != null) {
                        BlocProvider.of<CitysBloc>(context).add(
                            GetAddressLocationEvent(
                                position: positioned,
                                selectionUserCity: state.selectionUserCity));
                      }
                    },
                    onCameraMove: ((_position) {
                      updatePosition(_position);
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
                          // CIUDAD PRINCIPAL
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<SelectedCity>(
                                iconEnabledColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                value: state.selectionUserCity,
                                hint: Text("Selecciona"),
                                onChanged: (SelectedCity value) {
                                  if (mainController.text.length > 1) {
                                    mainController.clear();
                                    secondaryController.clear();
                                    plaqueController.clear();
                                  }

                                  BlocProvider.of<CitysBloc>(context).add(
                                      ActionUserSelect2DrEvent(
                                          value: value.i,
                                          selectedSUBCity: null,
                                          selectionUserCity: value));

                                  setState(() {});
                                },
                                items: state.listdep.map((i) {
                                  return DropdownMenuItem(
                                    value: i,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          i.nameCity,
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
                      //SEGUNDA CIUDAD
                      state.isSecondDRenable
                          ? DropdownButtonHideUnderline(
                              child: DropdownButton<SelectedSUBCity>(
                                iconEnabledColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                value: state.selectedSUBCity,
                                hint: Text("Selecciona"),
                                onChanged: (SelectedSUBCity value) {
                                  if (mainController.text.length > 1) {
                                    mainController.clear();
                                    secondaryController.clear();
                                    plaqueController.clear();
                                  }

                                  BlocProvider.of<CitysBloc>(context).add(
                                      MoveToCityEvent(
                                          selectedSUBCity: value,
                                          selectionUserCity:
                                              state.selectionUserCity,
                                          valueDep: state.selectionUserCity.i,
                                          valueCiu: value.i));
                                  setState(() {});
                                },
                                items: state.listdep2.map((i) {
                                  return DropdownMenuItem(
                                    value: i,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          i.nameCity,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : SizedBox(),

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
                                validateAddress(state.selectionUserCity);
                                selectedRoad = value;
                                setState(() {});
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
                              controller: mainController,
                              style: TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Numero",
                              ),
                              onChanged: (_) {
                                validateAddress(state.selectionUserCity);
                                setState(() {});
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: focus[0],
                              onSubmitted: (v) =>
                                  FocusScope.of(context).requestFocus(focus[1]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
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
                              controller: secondaryController,
                              style: TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Numero",
                              ),
                              onChanged: (_) {
                                validateAddress(state.selectionUserCity);
                                setState(() {});
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: focus[1],
                              onSubmitted: (v) =>
                                  FocusScope.of(context).requestFocus(focus[2]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
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
                              controller: plaqueController,
                              style: TextStyle(fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "Placa",
                              ),
                              onChanged: (_) {
                                validateAddress(state.selectionUserCity);
                                setState(() {});
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: focus[2],
                              onSubmitted: (v) =>
                                  FocusScope.of(context).requestFocus(focus[3]),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: complementController,
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
                              controller: aliasController,
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
                      "Agregar",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: () => print("Agregar")),
              ],
            );
          }

          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }

  updatePosition(CameraPosition _position) {
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

  validateAddress(SelectedCity selectionUserCity) {
    String city;
    String typeRoad;
    String mainRoad;
    String secondaryRoad;
    String plaque;
    if (mainController.text != "" &&
        secondaryController.text != "" &&
        selectedRoad.type != null &&
        plaqueController.text != "") {
      city = selectionUserCity.nameCity;
      typeRoad = selectedRoad.type;
      mainRoad = mainController.text;
      secondaryRoad = secondaryController.text;
      plaque = plaqueController.text;
      BlocProvider.of<CitysBloc>(context).add(GetLocationEvent(
          city: city,
          typeRoad: typeRoad,
          mainRoad: mainRoad,
          secondaryRoad: secondaryRoad,
          plaque: plaque));
    }
  }

  validations(LocationResponse rta) {
    if (rta.mainRoad != null &&
        rta.secondaryRoad != null &&
        rta.plaque != null) {
      mainController.text = rta.mainRoad;
      secondaryController.text = rta.secondaryRoad;
      plaqueController.text = rta.plaque;
    } else {
      mainController.text = "null";
      secondaryController.text = "null";
      plaqueController.text = "null";
    }

    switch (rta.typeRoad) {
      case "Calle":
        selectedRoad = typeRoad[0];
        break;
      case "Carrera":
        selectedRoad = typeRoad[1];

        break;

      case "Transversal":
        selectedRoad = typeRoad[2];

        break;
      case "Diagonal":
        selectedRoad = typeRoad[3];

        break;
      default:
        selectedRoad = typeRoad[4];
    }
  }
}
