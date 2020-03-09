import 'dart:async';

import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _scrollController = ScrollController();

  List<int> _listaNumeros = List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar5();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_agregar5();
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listas'),
        ),
        body: Stack(
          children: <Widget>[
            _crearLista(),
            _createLoading(),
          ],
        ));
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: getPage1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listaNumeros[index];
          return FadeInImage(
            image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
            placeholder: AssetImage('assets/jar-loading.gif'),
          );
        },
      ),
    );
  }

  Future<Null> getPage1()async {
    final duration = Duration(seconds: 2);
     Timer(duration, (){
      _listaNumeros.clear();
      _ultimoItem++;
      _agregar5();
    });
    return Future.delayed(duration);
  }

  void _agregar5() {
    for (var i = 0; i < 5; i++) {
      _listaNumeros.add(_ultimoItem++);
    }
    setState(() {});
  }

  Future fetchData() async {
    _isLoading = true;
    setState(() {});
    final duration = Duration(seconds: 2);
    return Timer(duration, rtaHttp);
  }

  void rtaHttp() {
    _isLoading = false;
    _agregar5();
    _scrollController.animateTo(_scrollController.position.pixels + 150,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
  }

  Widget _createLoading() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 15)
        ],
      );
    } else {
      return Container();
    }
  }
}
