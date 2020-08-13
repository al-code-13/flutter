import 'package:equatable/equatable.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class CitysState extends Equatable {
  const CitysState();

  @override
  List<Object> get props => [];
}

class InitialState extends CitysState {}

class LoadedCitysState extends CitysState {
  final CityResponse cityResponse;
  final List<SelectedCity> listdep;
  LoadedCitysState({this.cityResponse, this.listdep});
}

class GetCityState extends CitysState {}
