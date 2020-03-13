import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../isLog.dart';

class Validators {
  final facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future _navigators(context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  // +57 3004896662
  //menuchef46@gmail.com
  //--------------INICIO DE SESION CON FACEBOOK------------------------------------------------
  Future<void> loginWithFacebook(BuildContext context) async {
    FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken facebookAccessToken = result.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        _auth.currentUser().then((value) async {
          if (value != null) {
            value
                .linkWithCredential(authCredential)
                .then((value) =>
                    showAlert("Cuenta vinculada exitosamente.", context))
                .catchError((e) => showAlert(e, context));
          } else {
            final faceEmail = await getProfile(facebookAccessToken);
            _auth.fetchSignInMethodsForEmail(email: faceEmail).then((value) {
              if (value != null && value.length > 0) {
                if (value.contains("facebook.com")) {
                  _auth.signInWithCredential(authCredential);
                  _navigators(context, IsLog());
                } else {
                  showAlert("Este correo ya se encuentra registrado", context);
                }
              } else {
                showAlert("Debes registrarte primero", context);
              }
            });
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        showAlert(result.errorMessage, context);
        break;
    }
  }

  Future<String> getProfile(FacebookAccessToken facebookAccessToken) async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookAccessToken.token}');
    Map perfil = json.decode(graphResponse.body);
    print(perfil['email']);
    String correo = perfil['email'];
    return correo;
  }

  //--------------INICIO DE SESION CON GOOGLE------------------------------------------------------
  Future<void> logInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _auth.currentUser().then((value) {
      if (value != null) {
        if (googleUser.email == value.email) {
          value
              .linkWithCredential(credential)
              .then((value) =>
                  showAlert("Cuenta vinculada exitosamente.", context))
              .catchError((e) => showAlert(e, context));
        } else {
          showAlert("El corrreo no coincide.", context);
        }
      } else {
        _auth.fetchSignInMethodsForEmail(email: googleUser.email).then((value) {
          if (value != null && value.length > 0) {
            if (value.contains("google.com")) {
              _auth.signInWithCredential(credential);
              _navigators(context, IsLog());
            } else {
              showAlert("Este correo ya se encuentra registrado", context);
            }
          } else {
            showAlert("Debes registrarte primero", context);
          }
        });
      }
    });
  }

  //------------------Mostrar Alerta en caso de error iniciando sesion  -----------------------------------------------------
  Future<void> showAlert(String titulo, BuildContext context) async {
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
}

class Profile {
  String email;
  Profile({
    this.email,
  });
}
