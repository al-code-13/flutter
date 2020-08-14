import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CitysEvent extends Equatable {
  const CitysEvent();

  @override
  List<Object> get props => [];
}

class GetCityEvent extends CitysEvent {}

class UserSelectedCityEvent extends CitysEvent {}

class UserSelectedSecondCityEvent extends CitysEvent {
  final int value;

  UserSelectedSecondCityEvent(this.value);
}

class ActionUserSelect2DrEvent extends CitysEvent {
  final int value;

  ActionUserSelect2DrEvent(this.value);
}

class MoveToCityEvent extends CitysEvent {
  final int valueDep;
  final int valueCiu;
  MoveToCityEvent({this.valueCiu, this.valueDep});
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
  final CameraPosition position;

  GetAddressLocationEvent({this.position});
}
