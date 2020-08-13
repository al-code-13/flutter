import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/locationLogic/location_logic.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';
import 'blocExport.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CitysBloc extends Bloc<CitysEvent, CitysState> {
  CityResponse cityResponse;
  List<SelectedCity> listdep = [];
  LocationLogic logic = LocationLogic();
  CitysBloc() : super(InitialState());

  @override
  Stream<CitysState> mapEventToState(
    CitysEvent event,
  ) async* {
    if (event is GetCityEvent) {
      print("MI PRIMER BLOC");
      yield* _mapGetAllToState();
    }
    if (event is MoveToCityEvent) {
      yield* _mapMoveToCityToState(event.value);
    }
  }

  Stream<CitysState> _mapMoveToCityToState(int value) async* {
    if (cityResponse.listpais[0].listdep[value].listciu.length <= 1) {
      if (cityResponse.listpais[0].listdep[value].listciu[0].latlong != null) {
        List<String> locationCity =
            (cityResponse.listpais[0].listdep[value].listciu[0].latlong)
                .split(",");

        print("$locationCity XD");
        logic.setNewPositions(LatLng(
            double.parse(locationCity[0]), double.parse(locationCity[1])));
        //yield LoadedCitysState(cityResponse: cityResponse, listdep: listdep);
      } else {
        print("LA PUTISIMA LNLG ES NULA");
      }
    } else {
      print("HAY  MUCHOS MAS GUEBONES");
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
      yield LoadedCitysState(cityResponse: cityResponse, listdep: listdep);
    } catch (e) {
      print(e);
    }
  }
}
