import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with InputValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _phoneCredentialsController = BehaviorSubject<String>();

  // Recuperar datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream get phoneStream =>
      _phoneController.stream.transform(validarPhone);    
  Stream get phoneCredentialsStream =>
      _phoneCredentialsController.stream;    

  // Delete Data Stream

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);


  // insertar datos al stream
  Function get changeEmail => _emailController.sink.add;
  Function get changePassword => _passwordController.sink.add;
  Function get changePhone => _phoneController.sink.add;
  Function get changePhoneCredentials => _phoneCredentialsController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get phone => _phoneController.value;
  String get phoneCredentials => _phoneCredentialsController.value;



  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _phoneController?.close();
    _phoneCredentialsController.close();
  }
}
