import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/services.dart';
import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';

import 'futures/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final twitterLogin = new TwitterLogin(
  //   consumerKey: 'Y9KsGQiLOSKqFt4ieZCwQm23R',
  //   consumerSecret: '3q02R80J9N9VdmRkyjF8eruAODaS79u1cZ61UN2dLamHm49LKW',
  // );
  FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();

  final _validators = Validators();

  bool isLogged = false;
  String currentSesion;
  bool isRegister = true;

  FirebaseUser myUser;
  String emailBloc;
  String passwordBloc;

  //--------------INICIO DE SESION CON EMAIL Y PASSWORD--------------------------------------------------------------------
  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _validators.showAlert("Usuario o contraseña invalidos", context);
    });
    return result.user;
  }

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
    myUser = user;
    print(user);
    print("---------------");
    isLogged = true;
    currentSesion = 'Email';
    setState(() {});
    return user;
  }
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
          _createBackground(context),
          isLogged ? _isLog(context) : _loginForm(context),
        ],
      ),
    );
  }

  //------------------Vista cuando el usuario inicio sesion -----------------------------------------------------------------
  Widget _isLog(BuildContext context) {
    return SingleChildScrollView(
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
                Text("${myUser.displayName}"),
                Text("${myUser.email}"),
                RaisedButton(
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
                RaisedButton(
                  textColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text("Facebook Link"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: () async {},
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text("Google Link"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: () async {},
                ),
              ],
            ),
          ),
          isLogged ? SizedBox() : Text("Olvidaste tu contraseña"),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  //------------------Formulario de login -----------------------------------------------------------------------------------
  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.only(top: 50, bottom: 25),
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
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  isRegister ? "Ingresar" : "Registrar",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 60),
                _email(bloc),
                SizedBox(height: 30),
                _password(bloc),
                SizedBox(height: 30),
                isRegister ? _loginButton(bloc) : _registerButton(bloc),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  child: isRegister
                      ? Text("¿Aun no estas registrado?")
                      : Text("¿Ya estas registrado?"),
                  onTap: () {
                    setState(() {
                      isRegister = !isRegister;
                    });
                  },
                ),
                Divider(),
                FacebookSignInButton(
                  borderRadius: 5,
                  onPressed: () {
                    _validators.loginWithFacebook(context).then((onValue) {
                      if (onValue != null) {
                        myUser = onValue;
                        currentSesion = 'Facebook';
                        isLogged = true;
                        setState(() {});
                      }
                    });
                  },
                  text: "Continuar con Facebook",
                ),
                SizedBox(
                  height: 16,
                ),
                GoogleSignInButton(
                  borderRadius: 5,
                  onPressed: () async {
                    await _validators.logInWithGoogle();
                  },
                  text: "   Continuar con Google   ",
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton.icon(
                  onPressed: () async {
                    await _validators.logInPhone(context);
                  },
                  icon: Icon(Icons.phone),
                  label: Text("Ingresar con numero de telefono"),
                ),
              ],
            ),
          ),
          Text("Olvidaste tu contraseña"),
          SizedBox(
            height: 100,
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                ),
                hintText: "****",
                labelText: 'Contrase��a',
                counterText: snapshot.data,
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
        return RaisedButton(
          textColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text("Ingresar"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          color: Colors.green,
          onPressed: snapshot.hasData
              ? () {
                  _logInEmail(bloc.email, bloc.password).then((user) {
                    isLogged = true;
                    myUser = user;
                    currentSesion = 'Email';
                    setState(() {
                      emailBloc = bloc.email;
                      passwordBloc = bloc.password;
                    });
                  });
                }
              : null,
        );
      },
    );
  }

  //------------------Crear input de tipo boton para registrar con validacion en bloc ---------------------------------------
  Widget _registerButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          textColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text("Registrar"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          color: Colors.blue,
          onPressed: snapshot.hasData
              ? () {
                  _signUpWithEmail(bloc.email, bloc.password);
                  setState(() {
                    emailBloc = bloc.email;
                    passwordBloc = bloc.password;
                  });
                }
              : null,
        );
      },
    );
  }

  //------------------Crear fondo para formulario  --------------------------------------------------------------------------
  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(0, 100, 0, 1.0),
            Color.fromRGBO(0, 100, 0, 0.8)
          ],
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
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90, left: 30, child: circulo),
        Positioned(top: -40, right: -30, child: circulo),
        Positioned(bottom: -50, right: -10, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 90),
          child: Column(
            children: <Widget>[
              // isLogged && myUser.photoUrl != null
              //     ? Image.network(myUser.photoUrl)
              //     : Icon(Icons.person_pin_circle,
              //         color: Colors.white, size: 100),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                isLogged ? "${myUser.displayName}" : "Iniciar Sesión",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
