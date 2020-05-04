import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../user_repository/user_repository.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield*  _mapLoggedInToState();
    }
    if (event is LoggedInWithOutEmail) {
      yield* _mapLoggedInWithOutEmailToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
    if(event is OtherMethods){
      yield* _mapOtherMethodsToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        if (user.email != null) {
          yield Authenticated(user: user);
        } else {
          yield AuthenticatedWithOutEmail();
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    FirebaseUser user = await _userRepository.getUser();
    yield Authenticated(user: user);
  }

  Stream<AuthenticationState> _mapLoggedInWithOutEmailToState() async* {
    yield AuthenticatedWithOutEmail();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }
  
  
  Stream<AuthenticationState> _mapOtherMethodsToState() async* {
    yield OtherMethodsState();
  }
}
