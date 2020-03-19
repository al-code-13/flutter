import 'package:meta/meta.dart';

class LoginState {
  // Definir variables
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isValidPhone;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  // Constructor
  LoginState(
      {@required this.isEmailValid,
      @required this.isPasswordValid,
      this.isValidPhone,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure});

  // Cuatro estados:
  // - Vacio, empty
  factory LoginState.empty() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isValidPhone: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  // - Cargando, loading
  factory LoginState.loading() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isValidPhone: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  // - Falla, failure
  factory LoginState.failure() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isValidPhone: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }

  // - Exito, success
  factory LoginState.success() {
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isValidPhone: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }

  // Funciones adicionales: copywith - update
  LoginState copyWith(
      {bool isEmailValid,
      bool isPasswordValid,
      bool isValidPhone,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure}) {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isValidPhone: isValidPhone ?? this.isValidPhone,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  LoginState update({bool isEmailValid, bool isPasswordValid, bool isValidPhone}) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isValidPhone: isValidPhone,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  @override
  String toString() {
    return ''' LoginState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isValidPhone: $isValidPhone,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }
}