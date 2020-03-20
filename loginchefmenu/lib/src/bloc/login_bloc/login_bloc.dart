import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginchefmenu/src/utils/validators.dart';
import 'bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
      Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent) next) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PhoneChanged) {
      yield* _mapPhoneChangedToState(event.phone);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is LoginWithPhone) {
      yield* _mapLoginWithPhone(phoneNumber: event.phoneNumber,context: event.context);
    }
    if (event is LoginWithPhoneSucces) {
      yield* _mapLoginWithPhoneSuccess();
    }
    if (event is LoginWithEmailAndPassword) {
      yield* _mapLoginWithEmailAndPasswordToState(
          email: event.email, password: event.password);
    }
    if (event is SignUpWithEmailAndPassowrd) {
      yield* _mapSignUpWithEmailAndPassowrd(
          email: event.email, password: event.password);
    }
    if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
    }
    if (event is LoginWithFacebook) {
      yield* _mapLoginWithFacebookToState();
    }
  }

  Stream<LoginState> _mapPhoneChangedToState(String phone) async* {
    yield state.update(isValidPhone: Validators.isValidPhone(phone));
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithPhone({String phoneNumber,BuildContext context}) async* {
    yield LoginState.loading(); 
    try {
      await _userRepository.verifyPhone(phoneNumber,context);
      yield LoginState.success();
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithEmailAndPasswordToState(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.logInEmail(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapSignUpWithEmailAndPassowrd(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signUpWithEmail(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookToState() async* {
    try {
      await _userRepository.loginWithFacebook();
      yield LoginState.success();
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }
  
  Stream<LoginState> _mapLoginWithPhoneSuccess() async* {
    try {
      yield LoginState.success();
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }
}
