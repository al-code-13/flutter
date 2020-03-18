import 'package:bloc/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'bloc/bloc_supervisor.dart';
import 'blocs/my_bloc_delegate.dart';
import 'blocs/counter_bloc.dart';
import 'blocs/stopwatch.dart';
import 'flutter_bloc/bloc_provider.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  final counterBloc = CounterBloc();
  final stopwatchBloc = StopwatchBloc();
  runApp(
    BlocProvider<StopwatchBloc>(
      bloc: stopwatchBloc,
      child: BlocProvider<CounterBloc>(
        bloc: counterBloc,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: HomePage(),
        ),
      ),
    ),
  );
}
