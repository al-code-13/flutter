//imports
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<FirebaseUser> signInWithGoogle() async {
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
          }).catchError((e) => print(e));
        } else {
          print(
            "El corrreo no coincide.",
          );
        }
      } else {
        _auth.fetchSignInMethodsForEmail(email: googleUser.email).then((value) {
          if (value != null && value.length > 0) {
            if (value.contains("google.com")) {
              _auth.signInWithCredential(credential).then((value) {
                return value;
              });
            } else {
              print(
                "Este correo ya se encuentra registrado",
              );
            }
          } else {
            print(
              "Debes registrarte primero",
            );
          }
        });
      }
    });
  }

  //SignInWithFacebook
  Future<FirebaseUser> loginWithFacebook() async {
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
            }).catchError((e) => print(e));
          } else {
            final faceEmail = await getProfile(facebookAccessToken);
            _auth.fetchSignInMethodsForEmail(email: faceEmail).then((value) {
              if (value != null && value.length > 0) {
                if (value.contains("facebook.com")) {
                  _auth.signInWithCredential(authCredential).then((user) {
                    return user;
                  });
                } else {
                  print(
                    "Este correo ya se encuentra registrado",
                  );
                }
              } else {
                print(
                  "Debes registrarte primero",
                );
              }
            });
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        print(
          result.errorMessage,
        );
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
  Future<void> verifyPhone(String phone) async {
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
          print("Autenticacion vergas");
          if (value.user.email != null) {
          } else {}
          return value.user;
        } else {
          print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        print('Something has gone wrong, please try later');
      });
    };
    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      if (exception.message.contains('not authorized'))
        print('Something has gone wrong, please try later');
      else if (exception.message.contains('Network'))
        print('Please check your internet connection and try again');
      else
        print('Something has gone wrong, please try later');
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
      } else {}
    }).catchError((onError) {
      print('Something has gone wrong, please try later');
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
