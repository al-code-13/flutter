import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:loginchefmenu/src/bloc/login_bloc.dart';
import 'package:loginchefmenu/src/bloc/provider.dart';
import 'package:loginchefmenu/src/pages/createBackground.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/phoneNumberPage.dart';

import 'futures/validators.dart';
import 'isLog.dart';

class OtherMethods extends StatefulWidget {
  OtherMethods({Key key}) : super(key: key);

  @override
  _OtherMethodsState createState() => _OtherMethodsState();
}

class _OtherMethodsState extends State<OtherMethods> {
  final _validators = Validators();
  bool accept = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  //--------------INICIO DE SESION CON EMAIL Y PASSWORD--------------------------------------------------------------------
  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => IsLog())))
        .catchError((e) {
      _validators.showAlert("Usuario o contraseña invalidos", context);
    });
    return result.user;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              CreateBackground().createBigBackground(context),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                left: MediaQuery.of(context).size.width * 0.05,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneNumberPage()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
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
                    _validators.logInWithGoogle(context).then((value) => {});
                  },
                  text: "   Continuar con Google   ",
                ),
              ),
            ],
          ),
        ),
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
            onTap: () {
              _scrollController.animateTo(
                  (MediaQuery.of(context).size.height * 0.34),
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 1600));
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.mail_outline,
                color: Colors.green,
              ),
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
            onTap: () {
              _scrollController.animateTo(
                  (MediaQuery.of(context).size.height * 0.34),
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 1600));
            },
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                ),
                labelText: 'Contraseña',
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
                    _logInEmail(bloc.email, bloc.password);
                  }
                : null,
          ),
        );
      },
    );
  }
}
