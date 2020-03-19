import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginchefmenu/src/bloc/login_bloc/bloc.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/repository/user_repository.dart';
class PersonalDataScreen extends StatelessWidget {
  final UserRepository _userRepository;

  PersonalDataScreen({Key key, @required UserRepository userRepository})
    : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: PersonalData(userRepository: _userRepository),
      ),
    );
  }
}