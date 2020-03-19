import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginchefmenu/src/bloc/login_bloc/bloc.dart';
import 'package:loginchefmenu/src/pages/otherMethods.dart';
import 'package:loginchefmenu/src/repository/user_repository.dart';
class OtherMethodsScreen extends StatelessWidget {
  final UserRepository _userRepository;

  OtherMethodsScreen({Key key, @required UserRepository userRepository})
    : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: OtherMethods(userRepository: _userRepository),
      ),
    );
  }
}