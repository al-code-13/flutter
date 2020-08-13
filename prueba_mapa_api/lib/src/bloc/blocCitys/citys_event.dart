import 'package:equatable/equatable.dart';

abstract class CitysEvent extends Equatable {
  const CitysEvent();

  @override
  List<Object> get props => [];
}

class GetCityEvent extends CitysEvent {}

class MoveToCityEvent extends CitysEvent {
  final int value;
  MoveToCityEvent(this.value);
}
