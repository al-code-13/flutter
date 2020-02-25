import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;

  FirebaseUser myUser;
  String image;
  String name;
  String email;
  Future<FirebaseUser> _loginWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    debugPrint(result.status.toString());
    if (result.status == FacebookLoginStatus.error) {
      debugPrint(result.errorMessage);
    }

    if (result.status == FacebookLoginStatus.loggedIn) {
      final FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email', 'public_profile']);
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
      FirebaseUser user;
      user = (await _auth.signInWithCredential(authCredential)).user;
      return user;
    }
    return null;
  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

    final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<FirebaseUser> _logInWithGoogle() async {

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.email);
    setState(() {
      isLogged=true;
    });
    return user;
  }

  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => null);
    _auth.createUserWithEmailAndPassword(email: email, password: password);
    print(result.user);
    FirebaseUser user = result.user;
    isLogged = true;
    setState(() {});
    return user;
  }


  void _logIn() {
    //_logInEmail();
  }

  void _logOut() async {
    await _auth.signOut().then((value) {
      isLogged = false;
      _handleSignOut();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          isLogged ? _isLog(context) : _loginForm(context),
        ],
      ),
    );
  }

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
                Text("${name}"),
                Text("${email}"),
                RaisedButton(
                  textColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text("Cerrar Sesión"),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: _logOut,
                ),
              ],
            ),
          ),
          Text("Olvidaste tu contraseña"),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

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
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), boxShadow: <BoxShadow>[
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
                  "Ingreso",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 60),
                _crearEmail(bloc),
                SizedBox(height: 30),
                _crearPass(bloc),
                SizedBox(height: 30),
                _crearBoton(bloc),
                Divider(),
                FacebookSignInButton(
                  borderRadius: 5,
                  onPressed: () {
                    _loginWithFacebook().then((onValue) {
                      if (onValue != null) {
                        myUser = onValue;
                        image = myUser.photoUrl;
                        name = myUser.displayName;
                        email = myUser.email;
                        isLogged = true;
                        setState(() {});
                      }
                    });
                  },
                  text: "Continuar con Facebook",
                ),
                GoogleSignInButton(
                  borderRadius: 5,
                  onPressed: () {
                    _logInWithGoogle().then((FirebaseUser user) => print(myUser = user)).catchError((e) => print(e));
                  },
                  text: "   Continuar con Google   ",
                ),
              ],
            ),
          ),
          Text("Olvidaste tu contraseña"),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
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
                color: Colors.deepPurple,
              ),
              hintText: 'example@hotmail.com',
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

  Widget _crearPass(LoginBloc bloc) {
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
                  color: Colors.deepPurple,
                ),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          textColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text("Ingresar"),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          color: Colors.deepPurple,
          onPressed: snapshot.hasData
              ? () {
                  print(bloc.password);
                  print(bloc.email);
                  _logInEmail(bloc.email, bloc.password);
                }
              : null,
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color.fromRGBO(63, 63, 156, 1.0), Color.fromRGBO(90, 70, 178, 1.0)],
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
    return Stack(children: <Widget>[
      fondoMorado,
      Positioned(top: 90, left: 30, child: circulo),
      Positioned(top: -40, right: -30, child: circulo),
      Positioned(bottom: -50, right: -10, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 90),
        child: Column(
          children: <Widget>[
            //isLogged ? Image.network(image) : Icon(Icons.person_pin_circle, color: Colors.white, size: 100),
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Text(
              isLogged ? "${name}" : "Iniciar Sesión",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      )
    ]);
  }
}
