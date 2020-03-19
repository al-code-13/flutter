import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//tres estados
//No inicializado -> Splash Screen
// Autenticado -> Home
//No autentocadp -> Login
class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'No Inicializado';
}
class Authenticated extends AuthenticationState {
  final FirebaseUser user;
  const Authenticated(this.user);
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'Autenticado - displayName : $user';
}
class Unauthenticated extends AuthenticationState{
  @override
  String toString() => 'No Autenticado';
}