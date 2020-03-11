import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/utils/pinInput.dart';
import 'dart:convert';

import '../isLog.dart';

class Validators {
  final facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsCode;
  String phoneVerificationId;
  Widget _navegador;

  Future<void> verifyPhone(BuildContext context, String phone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.phoneVerificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeRedend]) async {
      this.phoneVerificationId = verId;
      await _smsCodeDialog(context);
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      _auth.signInWithCredential(auth).then((value) {
        if (value.user != null) {
          showAlert('Authentication successful', context);
          return value.user;
        } else {
          showAlert('Invalid code/invalid authentication', context);
        }
      }).catchError((error) {
        showAlert('Something has gone wrong, please try later', context);
      });
    };
    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      if (exception.message.contains('not authorized'))
        showAlert('Something has gone wrong, please try later', context);
      else if (exception.message.contains('Network'))
        showAlert(
            'Please check your internet connection and try again', context);
      else
        showAlert('Something has gone wrong, please try later', context);
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrive,
      timeout: const Duration(minutes: 10),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );
  }

  Future<void> signInWithPhoneNumber() async {
    final phoneCredential = PhoneAuthProvider.getCredential(
        verificationId: phoneVerificationId, smsCode: smsCode);
    _auth.signInWithCredential(phoneCredential).then((value) {
      if (value.user.email != null) {
        _navegador = IsLog();
      } else {
        _navegador = PersonalData();
      }
    }).catchError((onError) {
      print('Something has gone wrong, please try later');
    });
  }

  Future<bool> _smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ingrese su codigo de verificacion"),
            content: VerificationCodeInput(
              keyboardType: TextInputType.number,
              length: 6,
              autofocus: true,
              onCompleted: (String value) {
                smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      _auth.signOut().then((value) {
                        signInWithPhoneNumber().then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => _navegador))
                                .catchError((onError) {
                              showAlert(onError, context);
                            }));
                      });
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                      signInWithPhoneNumber().then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => _navegador))
                              .catchError((onError) {
                            showAlert(onError, context);
                          }));
                    }
                  });
                },
                child: Text("Done"),
              ),
            ],
          );
        });
  }

  // +57 3004896662
  //menuchef46@gmail.com
  //--------------INICIO DE SESION CON FACEBOOK----------------------------------------------------------------------------
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
            value.linkWithCredential(authCredential);
          } else {
            final faceEmail = await getProfile(facebookAccessToken);
            _auth.fetchSignInMethodsForEmail(email: faceEmail).then((value) {
              if (value != null && value.length > 0) {
                _auth.signInWithCredential(authCredential);
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
        showAlert("Fallo al iniciar, intente de nuevo.", context);
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

  //--------------INICIO DE SESION CON GOOGLE------------------------------------------------------------------------------
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
        value.linkWithCredential(credential);
      } else {
        _auth.fetchSignInMethodsForEmail(email: googleUser.email).then((value) {
          if (value != null && value.length > 0) {
            _auth.signInWithCredential(credential);
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
