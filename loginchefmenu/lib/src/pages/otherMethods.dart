import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:loginchefmenu/src/bloc/login_bloc.dart';
import 'package:loginchefmenu/src/bloc/provider.dart';

import 'futures/validators.dart';

class OtherMethods extends StatefulWidget {
  OtherMethods({Key key}) : super(key: key);

  @override
  _OtherMethodsState createState() => _OtherMethodsState();
}

class _OtherMethodsState extends State<OtherMethods> {
  final _validators = Validators();
  bool accept = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  //--------------INICIO DE SESION CON EMAIL Y PASSWORD--------------------------------------------------------------------
  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _validators.showAlert("Usuario o contraseña invalidos", context);
    });
    return result.user;
  }
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
              Text(
                "Bienvenido de nuevo",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )
            ],
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.08,
          top: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: <Widget>[
                _email(bloc),
                _password(bloc),
              ],
            ),
          ),
        ),
        _loginButton(bloc),
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
              _validators.logInWithGoogle().then((value) => {});
            },
            text: "   Continuar con Google   ",
          ),
        ),
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
                Icons.mail_outline,
                color: Colors.green,
              ),
              hintText: 'example@example.com',
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
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  //------------------Crear input de tipo boton para entrar con validacion en bloc ------------------------------------------
  Widget _loginButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.68,
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
            onPressed: snapshot.hasData
                ? () {
                    // _logInEmail(bloc.email, bloc.password).then((user) {
                    //   isLogged = true;
                    //   myUser = user;
                    //   currentSesion = 'Email';
                    //   setState(() {
                    //     emailBloc = bloc.email;
                    //     passwordBloc = bloc.password;
                    //   });
                    // });
                  }
                : null,
          ),
        );
      },
    );
  }
}
