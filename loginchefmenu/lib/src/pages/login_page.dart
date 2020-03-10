import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/services.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/phoneNumberPage.dart';

import 'createBackground.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
// +573004896661
class _LoginPageState extends State<LoginPage> {
  final createBackground = CreateBackground();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();

  Future<bool> currentUser() async {
    _auth.currentUser().then((value) {
      if (value != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  bool isLogged;
  String currentSesion;
  bool isRegister = true;

  FirebaseUser myUser;

  //------------------Cerrar sesion validando cual fue el metodo de inicio --------------------------------------------------
  void _logOut() async {
    await _auth.signOut().then((value) {
      switch (currentSesion) {
        case 'Facebook':
          facebookLogin.logOut();
          break;
        case 'Google':
          _googleSignIn.disconnect();
          break;
        default:
          break;
      }
      isLogged = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // createBackground.createBigBackground(context),
          createBackground.createSlimBackground(context),
           
          // PhoneNumberPage(),
          // OtherMethods(),
          // CodeVerification(),
          // PersonalData(),
        ],
      ),
    );
  }
}
