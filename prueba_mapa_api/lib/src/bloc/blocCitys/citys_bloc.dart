import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressRequest.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressResponse.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationRequest.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';
import 'blocExport.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CitysBloc extends Bloc<CitysEvent, CitysState> {
  CityResponse cityResponse;
  List<SelectedCity> listdep = [];
  List<SelectedSUBCity> listdep2 = [];
  GoogleMapController mycontroller;
  LatLng newPosition;
  int idDep;
  CitysBloc() : super(InitialState());

  @override
  Stream<CitysState> mapEventToState(
    CitysEvent event,
  ) async* {
    if (event is UserSelectedCityEvent) {
      yield* _mapGetAllToState();
    }
    if (event is GetCityEvent) {
      yield* _mapGetAllToState();
    }
    if (event is MoveToCityEvent) {
      yield* _mapMoveToCityToState(event.valueDep, event.valueCiu);
    }
    if (event is GetLocationEvent) {
      yield* _mapGetAddresResponseToState(event.city, event.typeRoad,
          event.mainRoad, event.secondaryRoad, event.plaque);
    }
    if (event is GetAddressLocationEvent) {
      yield* _mapGetAddressLocationToState(event.position);
    }
    if (event is UserSelectedSecondCityEvent) {
      yield* _mapAddListSubCityToState(event.value);
    }
    if (event is ActionUserSelect2DrEvent) {
      yield* _mapActionUserSelect2DrToState(event.value);
    }
  }

  Stream<CitysState> _mapActionUserSelect2DrToState(int value) async* {
    idDep = value;
    if (listdep2 != null) {
      listdep2.clear();
    }
    if (cityResponse.listpais[0].listdep[value].listciu.length > 1) {
      for (var i = 0;
          i < cityResponse.listpais[0].listdep[value].listciu.length;
          i++) {
        listdep2.add(SelectedSUBCity(
            i: i,
            nameCity:
                cityResponse.listpais[0].listdep[value].listciu[i].nomciudad));
      }
      print("ME LLAMARON ?");
      yield InitialState();
      yield UserSelectedCityState(
        cityResponse: cityResponse,
        listdep2: listdep2,
        listdep: listdep,
        setMapController: setMapController,
        isSecondDRenable: true,
      );
    } else {
      print("SOLO ES UNA");
      List<String> locationCity =
          (cityResponse.listpais[0].listdep[value].listciu[0].latlong)
              .split(",");
      newPosition =
          LatLng(double.parse(locationCity[0]), double.parse(locationCity[1]));
      yield LoadedCitysState(
          idSelected: idDep,
          setMapController: setMapController,
          cityResponse: cityResponse,
          listdep: listdep);
    }
  }

  Stream<CitysState> _mapAddListSubCityToState(int value) async* {
    idDep = value;
    if (listdep2 != null) {
      listdep2.clear();
    }
    if (cityResponse.listpais[0].listdep[value].listciu.length > 1) {
      print(cityResponse.listpais[0].listdep[value].nombre);

      for (var i = 0;
          i < cityResponse.listpais[0].listdep[value].listciu.length;
          i++) {
        listdep2.add(SelectedSUBCity(
            i: i,
            nameCity:
                cityResponse.listpais[0].listdep[value].listciu[i].nomciudad));
      }
      yield UserSelectedCityState(
        cityResponse: cityResponse,
        listdep2: listdep2,
        listdep: listdep,
        setMapController: setMapController,
        isSecondDRenable: true,
      );
    }
  }

  Stream<CitysState> _mapMoveToCityToState(int valueDep, int valueCiu) async* {
    idDep = valueDep;
    print("ENTRE AL SEGUNDO DR");
    print(valueCiu);
    if (cityResponse.listpais[0].listdep[valueDep].listciu[valueCiu].latlong !=
        null) {
      print("Si entre al auishdfauishdguipadefrg");
      List<String> locationCity =
          (cityResponse.listpais[0].listdep[valueDep].listciu[0].latlong)
              .split(",");
      newPosition =
          LatLng(double.parse(locationCity[0]), double.parse(locationCity[1]));
      yield InitialState();
      yield LoadedCitysState(
          idSelected: idDep,
          setMapController: setMapController,
          cityResponse: cityResponse,
          listdep: listdep);
    } else {
      print("LA PUTISIMA LNLG ES NULA");
    }
  }

  Stream<CitysState> _mapGetAllToState() async* {
    var url = "https://domicilios.tiendasd1.com/api//citiesEst/127";
    try {
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "authorization": "datoschefmenu"
        },
      );
      cityResponse = CityResponse.fromJson(convert.json.decode(response.body));
      if (cityResponse != null) {
        for (var i = 0; i < cityResponse.listpais[0].listdep.length; i++) {
          if (cityResponse.listpais[0].listdep.length != null) {
            listdep.add(SelectedCity(
                i: i, nameCity: cityResponse.listpais[0].listdep[i].nombre));
          }
        }
      }
      yield UserSelectedCityState(
          listdep: listdep,
          listdep2: listdep2,
          isSecondDRenable: false,
          setMapController: setMapController,
          cityResponse: cityResponse);
    } catch (e) {
      print(e);
    }
  }

  Stream<CitysState> _mapGetAddresResponseToState(String city, String typeRoad,
      String mainRoad, String secondaryRoad, String plaque) async* {
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
      setMapController(mycontroller);
      yield GetLocationState(rtaParseada);
    } catch (e) {
      print(e);
    }
  }

  Stream<CitysState> _mapGetAddressLocationToState(
      CameraPosition position) async* {
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
      yield UpdateMap();
      yield UpdateMoveCameraState(rtaParseada);
    } catch (e) {
      print(e);
    }
  }

  setMapController(GoogleMapController controller) {
    mycontroller = controller;
    print(mycontroller);
    print(controller);
    if (newPosition != null) {
      print(newPosition);
      controller.moveCamera(CameraUpdate.newLatLngZoom(newPosition, 18));
    }
  }
}
