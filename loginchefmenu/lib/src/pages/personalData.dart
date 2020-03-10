import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/bloc/login_bloc.dart';
import 'package:loginchefmenu/src/bloc/provider.dart';
import 'package:loginchefmenu/src/pages/otherMethods.dart';
import 'package:loginchefmenu/src/routes/routes.dart';

import 'futures/validators.dart';
import 'isLog.dart';

class PersonalData extends StatefulWidget {
  PersonalData({Key key}) : super(key: key);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}
//menuchef46@gmail.com
class _PersonalDataState extends State<PersonalData> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final validators = Validators();
  bool vivblePass = false;
  String phoneBloc;
//------------------Crear usuario con email y password---------------------------------------------------------------------
  Future<FirebaseUser> _signUpWithEmail(String email, String password) async {
    final FirebaseUser user = (await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .catchError((e) async {
      // currentProvider = "password";
      // emailToValidate = email;
      // await otherAccounts();
    }))
        .user;
    // myUser = user;
    // print(user);
    // print("---------------");
    // isLogged = true;
    // currentSesion = 'Email';
    setState(() {});
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.16,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.08,
            top: MediaQuery.of(context).size.height * 0.22,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.green,
                      ),
                      hintText: 'Ingrese su nombre',
                      labelText: 'Nombre',
                    ),
                  ),
                  _email(bloc),
                  _password(bloc),
                ],
              ),
            ),
          ),
          _registerButton(bloc),
        ],
      ),
    );
  }

  //------------------Crear input del email con validacion en bloc ----------------------------------------------------------
  Widget _email(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.green,
              ),
              hintText: 'example@hotmail.com',
              labelText: 'Correo Electronico',
              errorText: snapshot.error,
              counterText: snapshot.data,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  //------------------Crear input del password con validacion en bloc -------------------------------------------------------
  Widget _password(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                ),
                hintText: "****",
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  //------------------Crear input de tipo boton para registrar con validacion en bloc ---------------------------------------
  Widget _registerButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.48,
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
                  "Continuar",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {
                _signUpWithEmail(bloc.email, bloc.password).then((value) =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IsLog())));

                setState(() {
                  // emailBloc = bloc.email;
                  // passwordBloc = bloc.password;
                });
              }),
        );
      },
    );
  }
}
