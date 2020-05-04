import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//tres estados
//No inicializado -> Splash Screen
class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'No Inicializado';
}
// Autenticado -> Home
class Authenticated extends AuthenticationState {
  final FirebaseUser user;
  const Authenticated({@required this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'Autenticado - displayName : $user';
}
//Autenticado sin email
class AuthenticatedWithOutEmail extends AuthenticationState{
  @override
  String toString() =>'Autenticado sin email';
}
//No autentocadp -> Login
class Unauthenticated extends AuthenticationState{
  @override
  String toString() => 'No Autenticado';
}
//No autentocadp -> Other Methods
class OtherMethodsState extends AuthenticationState{
  @override
  String toString() => 'No Autenticado';
}