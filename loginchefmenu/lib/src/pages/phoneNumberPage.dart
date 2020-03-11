import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/bloc/login_bloc.dart';
import 'package:loginchefmenu/src/bloc/provider.dart';
import 'package:loginchefmenu/src/pages/createBackground.dart';
import 'package:loginchefmenu/src/pages/futures/validators.dart';
import 'package:loginchefmenu/src/pages/isLog.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';

import 'otherMethods.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key key}) : super(key: key);

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _logOut() async {
    await _auth.signOut();
  }

  bool accept = false;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final leftMargin = MediaQuery.of(context).size.width * 0.08;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CreateBackground().createBigBackground(context),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: leftMargin,
            child: Text(
              "Ingresar con tu celular",
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.55,
            left: leftMargin,
            child: StreamBuilder(
                stream: bloc.phoneStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        hintText: '123-456 78 90',
                        labelText: 'Escribe tu número',
                        errorText: snapshot.error,
                        // counter: Text(snapshot.data),
                      ),
                      onChanged: bloc.changePhone,
                    ),
                  );
                }),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
            left: MediaQuery.of(context).size.width * 0.16,
            right: MediaQuery.of(context).size.width * 0.16,
            child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Text(
                    "Verificar",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                onPressed: () {
                  Validators().verifyPhone(context, "+57" + bloc.phone);
                }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.16,
            right: MediaQuery.of(context).size.width * 0.16,
            child: RaisedButton(
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text("Cerrar Sesión"),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: _logOut,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.85,
            left: MediaQuery.of(context).size.width * 0.16,
            right: MediaQuery.of(context).size.width * 0.16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => OtherMethods()));
              },
              child: Text("Ingresar con otro metodo",style: TextStyle(color:Colors.green),),
            ),
          ),
          // +573004896661 @
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.02,
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  value: accept,
                  onChanged: (value) {
                    setState(() {
                      accept = !accept;
                    });
                  },
                ),
                Text(
                  "Acepto terminos y condiciones",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
