portaPapeles.text
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/services.dart';
import '../bloc/login_bloc.dart';
import '../bloc/provider.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final twitterLogin = new TwitterLogin(
  //   consumerKey: 'Y9KsGQiLOSKqFt4ieZCwQm23R',
  //   consumerSecret: '3q02R80J9N9VdmRkyjF8eruAODaS79u1cZ61UN2dLamHm49LKW',
  // );
  final facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogged = false;
  String currentSesion;
  bool isRegister = true;

  List<String> providers;
  FirebaseUser myUser;
  AuthCredential globalCredential;
  String emailBloc;
  String passwordBloc;

  String emailToValidate;
  String currentProvider;
  String phoneNumber;
  String smsCode;
  String phoneVerificationId;

   Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ingrese su codigo de verificacion"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: Text("Done"),
              ),
            ],
          );
        });
  }

  //------- sign in with twitter....
  // Future<FirebaseUser> _loginWithTwitter() async {
  //final TwitterLoginResult result = await twitterLogin.authorize();

// switch (result.status) {
//   case TwitterLoginStatus.loggedIn:
//     var session = result.session;
//     _sendTokenAndSecretToServer(session.token, session.secret);
//     break;
//   case TwitterLoginStatus.cancelledByUser:
//     _showAlert("Cancelado por el usuario");
//     break;
//   case TwitterLoginStatus.error:
//     _showAlert(result.errorMessage);
//     break;
// }
  //}

  //--------------INICIO DE SESION CON FACEBOOK----------------------------------------------------------------------------
  Future<FirebaseUser> _loginWithFacebook() async {
    final result = await facebookLogin.logIn(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken facebookAccessToken = result.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        FirebaseUser user;
        globalCredential = authCredential;
        //print(facebookAccessToken.token);

        user = (await _auth
                .signInWithCredential(authCredential)
                .catchError((e) async {
          print(e.toString());
          try {
            currentProvider = "facebook.com";
            emailToValidate = await (getProfile(facebookAccessToken));
            print(emailToValidate);
            await otherAccounts().catchError((onError) => print(onError));
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
        _showAlert(result.errorMessage);
        break;
    }
    return null;
  }

  Future<String> getProfile(FacebookAccessToken facebookAccessToken) async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookAccessToken.token}');
    Map perfil = json.decode(graphResponse.body);
    print(perfil['email']);
    String correo = perfil['email'];
    return correo;
  }

  //--------------INICIO DE SESION CON GOOGLE------------------------------------------------------------------------------
  Future<void> _logInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      globalCredential = credential;
      currentProvider = "google.com";
      emailToValidate = googleUser.email;
      await otherAccounts().then((value) {
        if (!value) {
          _auth.signInWithCredential(credential).then((value) {
            myUser = value.user;
            currentSesion = 'Google';
            isLogged = true;
            setState(() {});
          });
        }
      });
    } catch (e) {
      print("SE DAÑO");
    }
  }

  //--------------INICIO DE SESION CON EMAIL Y PASSWORD--------------------------------------------------------------------
  Future<FirebaseUser> _logInEmail(String email, String password) async {
    AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _showAlert("Usuario o contraseña invalidos");
    });
    return result.user;
  }

//------------------Crear usuario con email y password---------------------------------------------------------------------
  Future<FirebaseUser> _signUpWithEmail(String email, String password) async {
    final FirebaseUser user = (await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .catchError((e) async {
      currentProvider = "password";
      emailToValidate = email;
      await otherAccounts();
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

//---------------------------------------Validador para buscar las cuentas con el mismo email---------------------------------------
  Future<bool> otherAccounts() async {
    if (emailToValidate != null) {
      print(emailToValidate);
      providers =
          await _auth.fetchSignInMethodsForEmail(email: emailToValidate);
    }
    print(providers);
    if (providers != null && providers.length != 0) {
      if (providers.length == 1 && providers[0] == currentProvider) {
        return false;
      } else {
        if (providers.length < 2) {
          print("se va por aqui");
          duplicatedAccount();
          return true;
        } else {
          _showAlert("El numero de cuentas fue excedido");
        }
      }
    } else {
      print(emailToValidate);
      return false;
    }
  }

//---------------------------------------metodo para linkear las cuentas---------------------------------------
  Future<void> _linkAccounts() async {
    for (var x in providers) {
      switch (x) {
        case 'google.com':
          if (currentProvider == 'password') {
            final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;
            final AuthCredential credential = GoogleAuthProvider.getCredential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            _auth.signInWithCredential(credential).then((value) => value.user
                .delete()
                .then((value) => _auth
                    .createUserWithEmailAndPassword(
                        email: emailBloc, password: passwordBloc)
                    .then((value) =>
                        value.user.linkWithCredential(credential).then((value) {
                          setState(() {
                            myUser = value.user;
                            currentSesion = 'Email';
                            isLogged = true;
                          });
                        }))));
          } else {
            final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;
            final AuthCredential credential = GoogleAuthProvider.getCredential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            _auth.signInWithCredential(credential).then((value) =>
                value.user.linkWithCredential(globalCredential).then((value) {
                  setState(() {
                    myUser = value.user;
                    currentSesion = 'Google';
                    isLogged = true;
                  });
                }));
          }
          break;
        case 'facebook.com':
          if (currentProvider == "password") {
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
                _auth.signInWithCredential(authCredential).then((value) =>
                    value.user.delete().then((value) => _auth
                        .createUserWithEmailAndPassword(
                            email: emailBloc, password: passwordBloc)
                        .then((value) => value.user
                                .linkWithCredential(authCredential)
                                .then((value) {
                              setState(() {
                                myUser = value.user;
                                currentSesion = 'Email';
                                isLogged = true;
                              });
                            }))));
                break;
              case FacebookLoginStatus.cancelledByUser:
                break;
              case FacebookLoginStatus.error:
                _showAlert("Fallo al iniciar, intente de nuevo.");
                break;
            }
          } else {
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
                _auth.signInWithCredential(authCredential).then((value) =>
                    value.user.linkWithCredential(authCredential).then((value) {
                      setState(() {
                        myUser = value.user;
                        currentSesion = 'Facebook';
                        isLogged = true;
                      });
                    }));
                break;
              case FacebookLoginStatus.cancelledByUser:
                break;
              case FacebookLoginStatus.error:
                _showAlert("Fallo al iniciar, intente de nuevo.");
                break;
            }
          }
          break;
        case 'password':
          linkWithEmail();
          break;
      }
    }
  }

//---------------------------------------PopUp para ingresar con numero de telefono ---------------------------------------
  Future<void> logInPhone() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ingresar con numero de telefono"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "0123456789", labelText: "Numero telefonico"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _verifyPhone();
                },
                child: Text("Ingresar"),
              ),
            ],
          ),
        );
      },
    );
  }

//---------------------------------------PopUp para linkear la cuenta con el email y el password---------------------------------------
  Future<void> linkWithEmail() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Debes vincularte con tu cuenta de email"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    emailBloc = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Example@example.com",
                    labelText: "Correo electronico"),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    passwordBloc = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "******", labelText: "Contraseña"),
              ),
              RaisedButton(
                onPressed: emailBloc == emailToValidate
                    ? () {
                        _auth
                            .signInWithEmailAndPassword(
                                email: emailBloc, password: passwordBloc)
                            .then((value) =>
                                value.user.linkWithCredential(globalCredential))
                            .then((value) {
                          myUser = value.user;
                          currentSesion = 'Email';
                          isLogged = true;
                          Navigator.of(context).pop();
                        });
                      }
                    : null,
                child: Text("Ingresar"),
              ),
            ],
          ),
        );
      },
    );
  }

//---------------------------------------PopUp para verificar la decision del usuario---------------------------------------
  Future duplicatedAccount() async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Ya exise una cuenta con este Correo electronico, ¿deseas vincularla?'),
          actions: <Widget>[
            FlatButton(
              child: Text("No (Iniciar con mi cuenta anterior)"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                _linkAccounts();
              },
            ),
          ],
        );
      },
    );
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
        return AlertDialog(£
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
                  onPressed: () async {
                    final result = await facebookLogin.logIn(['email']);
                    switch (result.status) {
                      case FacebookLoginStatus.loggedIn:
                        final FacebookLoginResult facebookLoginResult =
                            await facebookLogin
                                .logIn(['email', 'public_profile']);
                        FacebookAccessToken facebookAccessToken =
                            facebookLoginResult.accessToken;
                        AuthCredential authCredential =
                            FacebookAuthProvider.getCredential(
                                accessToken: facebookAccessToken.token);
                        myUser.linkWithCredential(authCredential);
                        break;
                      case FacebookLoginStatus.cancelledByUser:
                        break;
                      case FacebookLoginStatus.error:
                        _showAlert("Fallo al iniciar, intente de nuevo.");
                        break;
                    }
                  },
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
                  onPressed: () async {
                    final GoogleSignInAccount googleUser =
                        await _googleSignIn.signIn();
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;
                    final AuthCredential credential =
                        GoogleAuthProvider.getCredential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    myUser.linkWithCredential(credential);
                  },
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
                  onPressed: () async {
                    await _logInWithGoogle();
                  },
                  text: "   Continuar con Google   ",
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton.icon(
                  onPressed: logInPhone,
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

class Profile {
  String name;
  String firstName;
  String lastName;
  String email;
  String id;

  Profile({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.id,
  });
}
