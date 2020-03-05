import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final twitterLogin = new TwitterLogin(
  //   consumerKey: 'Y9KsGQiLOSKqFt4ieZCwQm23R',
  //   consumerSecret: '3q02R80J9N9VdmRkyjF8eruAODaS79u1cZ61UN2dLamHm49LKW',
  // );

  bool isLogged = false;
  String currentSesion;
  bool isRegister = true;

  String emailBloc;
  String passwordBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          // isLogged ? _isLog(context) : _loginForm(context),
        ],
      ),
    );
  }

  //------------------Crear fondo para formulario  --------------------------------------------------------------------------
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final banner = Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://s1.1zoom.me/big0/841/Meat_products_Vegetables_457159.jpg",
            ),
          ),
        ),
      ),
    );
    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
    final greenLine = Container(
      color: Colors.green,
      height: 10,
      width: double.infinity,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
    );

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            banner,
            greenLine,
          ],
        ),
        Positioned(top: 90, left: 30, child: circulo),
        Positioned(top: -40, right: -30, child: circulo),
        Positioned(bottom: -50, right: -10, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 90),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                "Chefmenu",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
