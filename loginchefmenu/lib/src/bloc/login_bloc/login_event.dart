import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

//Cinco eventos
//Phone Changed
class PhoneChanged extends LoginEvent {
  final String phone;
  const PhoneChanged({@required this.phone});
  @override
  List<Object> get props => [phone];
  @override
  String toString() {
    return 'PhoneChanged {email:$phone}';
  }
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

//Login with phone number
class LoginWithPhone extends LoginEvent {
  final String phoneNumber;
  final BuildContext context;
  const LoginWithPhone({@required this.phoneNumber,@required this.context});
  @override
  List<Object> get props => [phoneNumber,context];
  @override
  String toString() {
    return 'LoginWithPhone {phoneNumber:$phoneNumber,context:$context}';
  }
}

class LoginWithPhoneSucces extends LoginEvent {}

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

//Registro con email
class SignUpWithEmailAndPassowrd extends LoginEvent {
  final String email;
  final String password;
  const SignUpWithEmailAndPassowrd({@required this.email, this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'SignUpWithEmailAndPassword {email:$email,password:$password}';
  }
}

//Login With Google
class LoginWithGoogle extends LoginEvent {}

//Login with facebook
class LoginWithFacebook extends LoginEvent {}
