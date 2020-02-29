import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogged = false;
  String currentSesion;
  bool isRegister = true;

  FirebaseUser myUser;
  AuthCredential oldUser;
  List<AuthCredential> credentials;
  String email;
  String password;
  //--------------INICIO DE SESION CON FACEBOOK----------------------------------------------------------------------------
  Future<FirebaseUser> _loginWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookLoginResult facebookLoginResult =
            await facebookLogin.logIn(['email', 'public_profile']);
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        FirebaseUser user;
        oldUser = authCredential;
        user =
            (await _auth.signInWithCredential(authCredential).catchError((e) {
          print(e);
          try {
            _accountValidator(email, "password");
          } catch (e) {
            _showAlert("El email ya esta registrado");
          }
        }))
                .user;
        return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showAlert("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.error:
        _showAlert("Fallo al iniciar, intente de nuevo.");
        break;
    }
    return null;
  }

  //--------------INICIO DE SESION CON GOOGLE------------------------------------------------------------------------------
  Future<FirebaseUser> _logInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      _accountValidator(googleUser.email, "google.com");
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      _showAlert(e.toString());
      print("--------------------------------" +
          e +
          "-------------------------------------)");
      return null;
    }
  }

  //--------------INICIO DE SESION CON EMAIL Y PASSWORD--------------------------------------------------------------------
  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _accountValidator(email, 'password');
      _showAlert("Usuario o contraeña invalidos");
    });
    FirebaseUser user = result.user;
    isLogged = true;
    myUser = user;
    currentSesion = 'Email';
    setState(() {});
    return user;
  }

//------------------Crear usuario con email y password---------------------------------------------------------------------
  Future<FirebaseUser> _signUpWithEmail(String email, String password) async {
    final FirebaseUser user = (await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .catchError((e) {
      _accountValidator(email, 'password');
    }))
        .user;
    myUser = user;
    isLogged = true;
    currentSesion = 'Email';
    setState(() {});
    return user;
  }

//---------------------------------------Validador para linkear las cuentas---------------------------------------
  Future<FirebaseUser> _accountValidator(String email, String key) async {
    List<String> providers =
        await _auth.fetchSignInMethodsForEmail(email: email);
    print(providers);
    if (providers.length != 0) {
      for (var x in providers) {
        if (x == key) {
          _showAlert("El email ya existe en base de datos");
        } else {
          switch (x) {
            case 'google.com':
              final GoogleSignInAccount googleUser =
                  await _googleSignIn.signIn();
              final GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;
              final AuthCredential credential =
                  GoogleAuthProvider.getCredential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );
              credentials.add(credential);
              break;
            case 'facebook.com':
              final result = await facebookLogin.logIn(['email']);
              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  final FacebookLoginResult facebookLoginResult =
                      await facebookLogin.logIn(['email', 'public_profile']);
                  FacebookAccessToken facebookAccessToken =
                      facebookLoginResult.accessToken;
                  AuthCredential authCredential =
                      FacebookAuthProvider.getCredential(
                          accessToken: facebookAccessToken.token);
                  //credentials.add(authCredential);
                  break;
                case FacebookLoginStatus.cancelledByUser:
                  // _showAlert("Cancelado por el usuario");
                  break;
                case FacebookLoginStatus.error:
                  _showAlert("Fallo al iniciar, intente de nuevo.");
                  break;
              }
              break;
            case 'password':
              switch (key) {
                case 'google.com':
                  break;
                case 'facebook.com':
                  break;
              }
              break;
          }
        }
      }
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (credentials.length != 0) {
          for (var x in credentials) {
            user.user.linkWithCredential(x);
          }
        }
      });
    } else {
      if (key == 'google.com') {
        try {
          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
        } catch (e) {
          _showAlert(e.toString());
          print("--------------------------------" +
              e +
              "-------------------------------------)");
        }
      }
    }
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

//------------------Mostrar Alerta en caso de error iniciando sesion  -----------------------------------------------------
  Future<void> _showAlert(String titulo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$titulo'),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    _loginWithFacebook().then((onValue) {
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
                  onPressed: () {
                    _logInWithGoogle().then((onValue) {
                      if (onValue != null) {
                        myUser = onValue;
                        currentSesion = 'Google';
                        isLogged = true;
                        setState(() {});
                      }
                    });
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
              // counterText: snapshot.data,
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
                labelText: 'Contraseña',
                // counterText: snapshot.data,
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
                  _logInEmail(bloc.email, bloc.password);
                  setState(() {
                    email = bloc.email;
                    password = bloc.password;
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
                    email = bloc.email;
                    password = bloc.password;
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
              isLogged && myUser.photoUrl != null
                  ? Image.network(myUser.photoUrl)
                  : Icon(Icons.person_pin_circle,
                      color: Colors.white, size: 100),
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
