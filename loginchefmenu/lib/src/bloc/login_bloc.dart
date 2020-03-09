import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with InputValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  // Recuperar datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream get phoneStream =>
      _phoneController.stream.transform(validarPhone);    

  // Delete Data Stream

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine3(emailStream, passwordStream,phoneStream, (e, p, w) => true);


  // insertar datos al stream
  Function get changeEmail => _emailController.sink.add;
  Function get changePassword => _passwordController.sink.add;
  Function get changePhone => _phoneController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get phone => _phoneController.value;



  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _phoneController?.close();
  }
}
