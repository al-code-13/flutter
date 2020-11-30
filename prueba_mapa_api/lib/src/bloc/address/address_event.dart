import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class ShowMapEvent extends AddressEvent {}

class ActionUserSelect2DrEvent extends AddressEvent {
  final int value;
  final int selectionUserCity;
  final SelectedSUBCity selectedSUBCity;

  ActionUserSelect2DrEvent(
      {this.selectionUserCity, this.selectedSUBCity, this.value});
}

class MoveToCityEvent extends AddressEvent {
  final int valueDep;
  final int valueCiu;
  final int selectionUserCity;
  final int selectedSUBCity;
  MoveToCityEvent(
      {this.selectionUserCity,
      this.selectedSUBCity,
      this.valueCiu,
      this.valueDep});
}

class GetLocationEvent extends AddressEvent {
  final int city;
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

class GetAddressLocationEvent extends AddressEvent {
  final int selectionUserCity;
  final SelectedSUBCity selectedSUBCity;
  final CameraPosition position;

  GetAddressLocationEvent(
      {this.selectionUserCity, this.selectedSUBCity, this.position});
}
