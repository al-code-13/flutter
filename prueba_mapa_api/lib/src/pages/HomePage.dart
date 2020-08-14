import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_mapa_api/src/bloc/blocCitys/blocExport.dart';
import 'package:prueba_mapa_api/src/pages/RequestCity.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("prototipe"),
      ),
      body: BlocProvider<CitysBloc>(
        create: (BuildContext context) =>
            CitysBloc()..add(UserSelectedCityEvent()),
        child: RequesCityPage(),
      ),
    );
  }
}
