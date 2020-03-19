//imports
import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:loginchefmenu/src/bloc/authentication_bloc/bloc.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  //Constructor
  UserRepository(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin();
  //SignInWithGoogle
  Future<void> signInWithGoogle() async {
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
          value.linkWithCredential(credential).then((value) {
            print(
              "Cuenta vinculada exitosamente.",
            );
            return value;
          }).catchError((e) => throw (e));
        } else {
          throw ("El corrreo no coincide.");
        }
      } else {
        _auth.fetchSignInMethodsForEmail(email: googleUser.email).then((value) {
          if (value != null && value.length > 0) {
            if (value.contains("google.com")) {
              _auth.signInWithCredential(credential).then((value) {
                return value;
              });
            } else {
              throw ("Este correo ya se encuentra registrado");
            }
          } else {
            throw ("Debes registrarte primero");
          }
        });
      }
    });
  }

  //SignInWithFacebook
  Future<void> loginWithFacebook() async {
    FacebookLoginResult result =
        await _facebookLogin.logIn(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken facebookAccessToken = result.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        _auth.currentUser().then((value) async {
          if (value != null) {
            value.linkWithCredential(authCredential).then((value) {
              print(
                "Cuenta vinculada exitosamente.",
              );
              return value;
            }).catchError((e) => throw (e));
          } else {
            final faceEmail = await getProfile(facebookAccessToken);
            _auth.fetchSignInMethodsForEmail(email: faceEmail).then((value) {
              if (value != null && value.length > 0) {
                if (value.contains("facebook.com")) {
                  _auth.signInWithCredential(authCredential).then((user) {
                    return user;
                  });
                } else {
                  throw ("Este correo ya se encuentra registrado");
                }
              } else {
                throw ("Debes registrarte primero");
              }
            });
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        throw (result.errorMessage);
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

//Verificacion con numero de telefono
  String smsCode;
  String phoneVerificationId;
  Future<void> verifyPhone(String phone, context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      phoneVerificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeRedend]) async {
      phoneVerificationId = verId;
      print("a");
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      _auth.signInWithCredential(auth).then((value) {
        if (value.user != null) {
          if (value.user.email != null) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          } else {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(LoggedInWithOutEmail());
          }
          return value.user;
        } else {
          throw ('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        throw ('Something has gone wrong, please try later auto verificacion');
      });
    };
    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      if (exception.message.contains('not authorized'))
        throw ('}no se encuentra autorizado para realizar esta accion.');
      else if (exception.message.contains('Network'))
        throw ('Por favor revise su conexion a internet e intentelo de nuevo');
      else
        throw ('Algo salio mal, intente mas tarde.');
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrive,
      timeout: const Duration(minutes: 2),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );
  }

  Future<void> signInWithPhoneNumber(context) async {
    final phoneCredential = PhoneAuthProvider.getCredential(
        verificationId: phoneVerificationId, smsCode: smsCode);
    _auth.signInWithCredential(phoneCredential).then((value) {
      if (value.user.email != null) {
        print(value.user.email);
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      } else {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedInWithOutEmail());
      }
    }).catchError((onError) {
      throw ('Algo salio mal, por favor intentalo de nuevo');
    });
  }

  //SignInWithEmail&Password
  Future<void> logInEmail(String email, String password) async {
    return await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((u) {})
        .catchError((e) {});
  }

  //SignUp Registro
  Future<void> signUpWithEmail(String email, String password) async {
    return await _auth
        .currentUser()
        .then((value) => value.linkWithCredential(
            EmailAuthProvider.getCredential(email: email, password: password)))
        .then((value) {})
        .catchError((error) {});
  }

  //SignOut Salir
  Future<void> signOut() async {
    return Future.wait([_auth.signOut()]);
  }

  //IsLog
  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  //Current User
  Future<FirebaseUser> getUser() async {
    return (await _auth.currentUser());
  }
}
