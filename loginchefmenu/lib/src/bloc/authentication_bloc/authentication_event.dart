import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

//Cuatro Eventos
//App started
class AppStarted extends AuthenticationEvent {}

//LoggedIn
class LoggedIn extends AuthenticationEvent {}

//LoggedIn sin email
class LoggedInWithOutEmail extends AuthenticationEvent {}

//LoggedOut
class LoggedOut extends AuthenticationEvent {}
