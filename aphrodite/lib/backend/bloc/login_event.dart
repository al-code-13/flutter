import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

//Email Changed
class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged({@required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() {
    return 'EmailChanged {email:$email}';
  }
}

//Password changed
class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({@required this.password});
  @override
  List<Object> get props => [password];
  @override
  String toString() {
    return 'PasswordChanged {Password:$password}';
  }
}

//Submittign
class Submitted extends LoginEvent {
  final String email;
  final String password;
  const Submitted({@required this.email, this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'Submitted {email:$email,password:$password}';
  }
}
//Login with email
class LoginWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;
  const LoginWithEmailAndPassword({@required this.email, this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'LoginWithEmailAndPassword {email:$email,password:$password}';
  }
}