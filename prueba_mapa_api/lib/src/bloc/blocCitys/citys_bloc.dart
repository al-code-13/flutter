import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:diacritic/diacritic.dart';
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
  CitysBloc() : super(LoadingState());

  @override
  Stream<CitysState> mapEventToState(
    CitysEvent event,
  ) async* {
    if (event is ShowMapEvent) {
      yield* _mapGetAllToState();
    }
    if (event is MoveToCityEvent) {
      yield* _mapMoveToCityToState(
          valueCiu: event.valueCiu,
          valueDep: event.valueDep,
          selectionUserCity: event.selectionUserCity,
          selectedSUBCity: event.selectedSUBCity);
    }
    if (event is ActionUserSelect2DrEvent) {
      yield* _mapActionUserSelect2DrToState(
          value: event.value,
          selectionUserCity: event.selectionUserCity,
          selectedSUBCity: event.selectedSUBCity);
    }
    if (event is GetLocationEvent) {
      yield* _mapGetAddresResponseToState(event.city, event.typeRoad,
          event.mainRoad, event.secondaryRoad, event.plaque);
    }
    if (event is GetAddressLocationEvent) {
      yield* _mapGetAddressLocationToState(
          position: event.position, selectionUserCity: event.selectionUserCity);
    }
  }

  Stream<CitysState> _mapActionUserSelect2DrToState({
    int value,
    SelectedCity selectionUserCity,
    SelectedSUBCity selectedSUBCity,
  }) async* {
    try {
      idDep = value;
      if (listdep2.isEmpty) {
        if (cityResponse.listpais[0].listdep[value].listciu.length > 1) {
          for (var i = 0;
              i < cityResponse.listpais[0].listdep[value].listciu.length;
              i++) {
            listdep2.add(SelectedSUBCity(
                i: i,
                nameCity: cityResponse
                    .listpais[0].listdep[value].listciu[i].nomciudad));
          }
          yield LoadingState();
          yield LoadedCitysState(
              selectedSUBCity: selectedSUBCity,
              selectionUserCity: selectionUserCity,
              isSecondDRenable: true,
              listdep2: listdep2,
              idSelected: idDep,
              setMapController: setMapController,
              cityResponse: cityResponse,
              listdep: listdep);
        } else {
          List<String> locationCity =
              (cityResponse.listpais[0].listdep[value].listciu[0].latlong)
                  .split(",");
          newPosition = LatLng(
              double.parse(locationCity[0]), double.parse(locationCity[1]));
          setMapController(mycontroller);
          yield LoadingState();
          yield LoadedCitysState(
              selectedSUBCity: selectedSUBCity,
              selectionUserCity: selectionUserCity,
              setMapController: setMapController,
              isSecondDRenable: false,
              listdep2: null,
              idSelected: idDep,
              cityResponse: cityResponse,
              listdep: listdep);
        }
      } else {
        listdep2.clear();
        if (cityResponse.listpais[0].listdep[value].listciu.length > 1) {
          for (var i = 0;
              i < cityResponse.listpais[0].listdep[value].listciu.length;
              i++) {
            listdep2.add(SelectedSUBCity(
                i: i,
                nameCity: cityResponse
                    .listpais[0].listdep[value].listciu[i].nomciudad));
          }
          yield LoadingState();
          yield LoadedCitysState(
              selectedSUBCity: selectedSUBCity,
              selectionUserCity: selectionUserCity,
              isSecondDRenable: true,
              listdep2: listdep2,
              idSelected: idDep,
              setMapController: setMapController,
              cityResponse: cityResponse,
              listdep: listdep);
        } else {
          List<String> locationCity =
              (cityResponse.listpais[0].listdep[value].listciu[0].latlong)
                  .split(",");
          newPosition = LatLng(
              double.parse(locationCity[0]), double.parse(locationCity[1]));
          setMapController(mycontroller);
          yield LoadingState();
          yield LoadedCitysState(
              selectedSUBCity: selectedSUBCity,
              selectionUserCity: selectionUserCity,
              setMapController: setMapController,
              isSecondDRenable: false,
              listdep2: null,
              idSelected: idDep,
              cityResponse: cityResponse,
              listdep: listdep);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<CitysState> _mapMoveToCityToState({
    int valueDep,
    int valueCiu,
    SelectedCity selectionUserCity,
    SelectedSUBCity selectedSUBCity,
  }) async* {
    try {
      if (cityResponse
              .listpais[0].listdep[valueDep].listciu[valueCiu].latlong !=
          null) {
        List<String> locationCity = (cityResponse
                .listpais[0].listdep[valueDep].listciu[valueCiu].latlong)
            .split(",");
        newPosition = LatLng(
            double.parse(locationCity[0]), double.parse(locationCity[1]));
        setMapController(mycontroller);
        yield LoadingState();
        yield LoadedCitysState(
          selectedSUBCity: selectedSUBCity,
          selectionUserCity: selectionUserCity,
          isSecondDRenable: true,
          setMapController: setMapController,
          idSelected: idDep,
          cityResponse: cityResponse,
          listdep2: listdep2,
          listdep: listdep,
        );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<CitysState> _mapGetAllToState() async* {
    try {
      if (listdep2.isEmpty) {
        if (listdep.isEmpty) {
          var url = "https://domicilios.tiendasd1.com/api//citiesEst/127";
          try {
            var response = await http.get(
              url,
              headers: {
                "Content-Type": "application/json",
                "authorization": "datoschefmenu"
              },
            );
            cityResponse =
                CityResponse.fromJson(convert.json.decode(response.body));

            if (cityResponse != null) {
              for (var i = 0;
                  i < cityResponse.listpais[0].listdep.length;
                  i++) {
                if (cityResponse.listpais[0].listdep.length != null) {
                  listdep.add(SelectedCity(
                      i: i,
                      nameCity: cityResponse.listpais[0].listdep[i].nombre));
                }
              }
            }
            yield LoadingState();
            yield LoadedCitysState(
                idSelected: idDep,
                listdep: listdep,
                listdep2: listdep2,
                isSecondDRenable: false,
                setMapController: setMapController,
                cityResponse: cityResponse);
          } catch (e) {
            print(e);
          }
        }
      } else {
        listdep2.clear();
        if (listdep == null || listdep.isEmpty) {
          var url = "https://domicilios.tiendasd1.com/api//citiesEst/127";
          try {
            var response = await http.get(
              url,
              headers: {
                "Content-Type": "application/json",
                "authorization": "datoschefmenu"
              },
            );
            cityResponse =
                CityResponse.fromJson(convert.json.decode(response.body));
            if (cityResponse != null) {
              for (var i = 0;
                  i < cityResponse.listpais[0].listdep.length;
                  i++) {
                if (cityResponse.listpais[0].listdep.length != null) {
                  listdep.add(SelectedCity(
                      i: i,
                      nameCity: cityResponse.listpais[0].listdep[i].nombre));
                }
              }
            }
            yield LoadingState();
            yield LoadedCitysState(
                idSelected: idDep,
                listdep: listdep,
                listdep2: listdep2,
                isSecondDRenable: false,
                setMapController: setMapController,
                cityResponse: cityResponse);
          } catch (e) {
            print(e);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

// _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
  Stream<CitysState> _mapGetAddresResponseToState(String city, String typeRoad,
      String mainRoad, String secondaryRoad, String plaque) async* {
    var url =
        "https://d1-ecommerce-test.chefmenu.com.co/api/v1/geo/search-address";
    AddresRequest values = AddresRequest(
        city: city,
        typeRoad: typeRoad,
        mainRoad: mainRoad,
        secondaryRoad: secondaryRoad,
        plaque: plaque);
    try {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: values.toRawJson());
      var rtaParseada =
          AddresResponse.fromJson(convert.json.decode(response.body));
      print("Response => ${rtaParseada.toJson()}");
      newPosition =
          LatLng(rtaParseada.coordinates.lat, rtaParseada.coordinates.lng);
      setMapController(mycontroller);
      yield GetLocationState(rtaParseada);
    } catch (e) {
      print(e);
    }
  }

  Stream<CitysState> _mapGetAddressLocationToState(
      {SelectedCity selectionUserCity, CameraPosition position}) async* {
    bool hasCoverage = false;
    var url =
        "https://d1-ecommerce-test.chefmenu.com.co/api/v1/geo/current-location";
    LocationRequest values = LocationRequest(
        latitud: position.target.latitude, longitud: position.target.longitude);
    try {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: values.toRawJson());
      LocationResponse rtaParseada;
      if (response.body.isNotEmpty) {
        rtaParseada =
            LocationResponse.fromJson(convert.json.decode(response.body));
      } else {
        print("si viene null");
      }

      hasCoverage = validateCityDR(rtaParseada.city, cityResponse);
      yield UpdateMap();
      yield UpdateMoveCameraState(rtaParseada);
      // if (hasCoverage) {
      //   print("asdasd");
      //   yield LoadingState();
      //   yield LoadedCitysState(
      //       idSelected: idDep,
      //       listdep: listdep,
      //       listdep2: listdep2,
      //       isSecondDRenable: false,
      //       setMapController: setMapController,
      //       cityResponse: cityResponse);
      // }
    } catch (e) {
      print(e);
    }
  }

  validateCityDR(String city, CityResponse cityResponse) {
    bool validation = false;
    print("Response 1 => $city");
    List<Listdep> listCiudades = cityResponse.listpais[0].listdep;
    for (var i = 0; i < listCiudades.length; i++) {
      if (removeDiacritics(listCiudades[i].nombre)
          .contains(removeDiacritics(city))) {
        validation = true;
      } else {
        for (var j = 0; j < listCiudades[i].listciu.length; j++) {
          if (removeDiacritics(listCiudades[i].listciu[j].nomciudad)
              .contains(removeDiacritics(city))) {
            validation = true;
          }
        }
      }
    }

    return validation;
  }

  setMapController(GoogleMapController controller) {
    mycontroller = controller;
    if (newPosition != null) {
      controller.moveCamera(CameraUpdate.newLatLngZoom(newPosition, 18));
    }
  }
}
