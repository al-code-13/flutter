import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/phoneNumberPage.dart';

import 'futures/validators.dart';

class IsLog extends StatefulWidget {
  IsLog({Key key}) : super(key: key);

  @override
  _IsLogState createState() => _IsLogState();
}

class _IsLogState extends State<IsLog> {
  final _validators = Validators();

  FirebaseAuth _auth = FirebaseAuth.instance;
  //------------------Cerrar sesion validando cual fue el metodo de inicio --------------------------------------------------
  void _logOut() async {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    height: 180,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          child: Text("Cerrar Sesión"),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                        color: Colors.deepPurple,
                        onPressed: () {
                          _logOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneNumberPage()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.77,
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.12,
            child: FacebookSignInButton(
              borderRadius: 5,
              onPressed: () {
                _validators.loginWithFacebook(context);
              },
              text: "Continuar con Facebook",
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.83,
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.12,
            child: GoogleSignInButton(
              borderRadius: 5,
              onPressed: () async {
                _validators.logInWithGoogle(context).then((value) => {});
              },
              text: "   Continuar con Google   ",
            ),
          ),
        ],
      ),
    );
  }
}
