import 'dart:async';

class InputValidator {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Mas de 6 caracteres');
    }
  });
  final validarPhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone != '') {
      List<String> phoneNew = phone.split(RegExp(r"b*"));
        if (phone.length >= 13) {
          //var newPone = '+57'+phone;
          sink.add(phone);
        } else {
          sink.addError('Faltan numeros');
        }
      
    }
  });
}
