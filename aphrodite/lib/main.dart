import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'backend/authentication_bloc/authentication_event.dart';
import 'backend/authentication_bloc/bloc.dart';
import 'backend/authentication_bloc/simple_bloc_delegate.dart';
import 'backend/user_repository/user_repository.dart';
import 'frontend/src/pages/home_page.dart';
import 'frontend/src/ui/login_screen.dart';
import 'frontend/src/ui/splash_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  const App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is Uninitialized) {
          return SplassScreen();
        }
        if (state is Authenticated) {
          return HomePage(
              // user: state.user,
              // userRepository: _userRepository,
              );
        }
        if (state is Unauthenticated) {
          return LoginScreen(
            userRepository: _userRepository,
          );
        }
        return Container();
      }),
    );
  }
}
