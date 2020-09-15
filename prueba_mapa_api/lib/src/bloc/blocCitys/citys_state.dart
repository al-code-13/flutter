import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressResponse.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class CitysState extends Equatable {
  const CitysState();

  @override
  List<Object> get props => [];
}

class LoadingState extends CitysState {
  String toString() => 'Satisfactorio  LA PUTASIMA CARGA';
}

class UpdateMap extends CitysState {}

class UserSelectedCityState extends CitysState {
  final Function(GoogleMapController controller) setMapController;
  final CityResponse cityResponse;
  final bool isSecondDRenable;
  final List<SelectedSUBCity> listdep2;
  final List<SelectedCity> listdep;
  UserSelectedCityState(
      {this.isSecondDRenable,
      this.listdep2,
      this.cityResponse,
      this.setMapController,
      this.listdep});
}

class LoadedCitysState extends CitysState {
  final Function(GoogleMapController controller) setMapController;
  final CityResponse cityResponse;
  final int idSelected;
  final bool isSecondDRenable;
  final List<SelectedSUBCity> listdep2;
  final List<SelectedCity> listdep;
  LoadedCitysState(
      {this.listdep2,
      @required this.isSecondDRenable,
      @required this.idSelected,
      @required this.setMapController,
      @required this.cityResponse,
      @required this.listdep});
}

class GetCityState extends CitysState {}

class MainHomeState extends CitysState {}

// ENVIO
class GetLocationState extends CitysState {
  final AddresResponse addresResponse;

  GetLocationState(this.addresResponse);
}

//  ENVIO COORDENADAS LLEGA DIRECCION
class GetAddressLocationState extends CitysState {
  final LocationResponse locationResponse;

  GetAddressLocationState(this.locationResponse);
}

class UpdateMoveCameraState extends CitysState {
  final LocationResponse locationResponse;
  UpdateMoveCameraState(this.locationResponse);
}
