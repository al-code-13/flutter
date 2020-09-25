import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class CitysEvent extends Equatable {
  const CitysEvent();

  @override
  List<Object> get props => [];
}

class ShowMapEvent extends CitysEvent {}

class ActionUserSelect2DrEvent extends CitysEvent {
  final int value;
  final SelectedCity selectionUserCity;
  final SelectedSUBCity selectedSUBCity;

  ActionUserSelect2DrEvent(
      {this.selectionUserCity, this.selectedSUBCity, this.value});
}

class MoveToCityEvent extends CitysEvent {
  final int valueDep;
  final int valueCiu;
  final SelectedCity selectionUserCity;
  final SelectedSUBCity selectedSUBCity;
  MoveToCityEvent(
      {this.selectionUserCity,
      this.selectedSUBCity,
      this.valueCiu,
      this.valueDep});
}

class GetLocationEvent extends CitysEvent {
  final String city;
  final String typeRoad;
  final String mainRoad;
  final String secondaryRoad;
  final String plaque;

  GetLocationEvent(
      {this.city,
      this.typeRoad,
      this.mainRoad,
      this.secondaryRoad,
      this.plaque});
}

class GetAddressLocationEvent extends CitysEvent {
  final SelectedCity selectionUserCity;
  final SelectedSUBCity selectedSUBCity;
  final CameraPosition position;

  GetAddressLocationEvent(
      {this.selectionUserCity, this.selectedSUBCity, this.position});
}
