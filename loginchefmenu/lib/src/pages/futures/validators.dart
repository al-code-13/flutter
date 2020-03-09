import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Validators {
  final facebookLogin = FacebookLogin();
  final _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> providers;
  FirebaseUser myUser;
  AuthCredential globalCredential;
  String emailToValidate;
  String currentProvider;
  String phoneNumber;
  String smsCode;
  String phoneVerificationId;
  Future<void> _verifyPhone(BuildContext context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.phoneVerificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeRedend]) async {
      this.phoneVerificationId = verId;
      print(verId);

      _smsCodeDialog(context).then((value) {
        print("El codigo y se mando de nuevo a firebase");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      print("Entra como satisfactorio gonorrea");
      _auth.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          print('Authentication successful');

          return value.user;
        } else {
          print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        print('Something has gone wrong, please try later');
      });
      print('cerdenciales de ingreso');
      print(auth.toString());
    };
    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print("Aca tambien se putea");

      print("Error message: " + exception.message + " es aca");
      if (exception.message.contains('not authorized'))
        print('Something has gone wrong, please try later');
      else if (exception.message.contains('Network'))
        print('Please check your internet connection and try again');
      else
        print('Something has gone wrong, please try later');
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrive,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );
  }

  Future<void> _signInWithPhoneNumber() async {
    final phoneCredential = await PhoneAuthProvider.getCredential(
        verificationId: phoneVerificationId, smsCode: smsCode);
    _auth.signInWithCredential(phoneCredential).then((value) {
      myUser = value.user;
    }).catchError((onError) {
      print('Something has gone wrong, please try later');
    }).then((FirebaseUser user) async {
      print('Authentication successful');
    });
  }

  Future<bool> _smsCodeDialog(BuildContext context) {
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
                      _auth.signOut();
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                      _signInWithPhoneNumber();
                    }
                  });
                },
                child: Text("Done"),
              ),
            ],
          );
        });
  }

  Future<void> logInPhone(BuildContext context) async {
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
                  phoneNumber = value;
                },
                decoration: InputDecoration(
                    hintText: "0123456789", labelText: "Numero telefonico"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _verifyPhone(context);
                },
                child: Text("Ingresar"),
              ),
            ],
          ),
        );
      },
    );
  }

  //--------------INICIO DE SESION CON FACEBOOK----------------------------------------------------------------------------
  Future<FirebaseUser> loginWithFacebook(BuildContext context) async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookLoginResult facebookLoginResult =
            await facebookLogin.logIn(['email', 'public_profile']);
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        myUser.linkWithCredential(authCredential);
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
  Future<void> logInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    myUser.linkWithCredential(credential);
  }
 
//---------------------------------------Validador para buscar las cuentas con el mismo email---------------------------------------
  Future<bool> otherAccounts(BuildContext context) async {
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
          duplicatedAccount(context);
          return true;
        } else {
          showAlert("El numero de cuentas fue excedido", context);
        }
      }
    } else {
      print(emailToValidate);
      return false;
    }
  }

//---------------------------------------PopUp para verificar la decision del usuario---------------------------------------
  Future duplicatedAccount(BuildContext context) async {
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
                // _linkAccounts();
              },
            ),
          ],
        );
      },
    );
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

//---------------------------------------PopUp para linkear la cuenta con el email y el password---------------------------------------
//   Future<void> linkWithEmail(BuildContext context) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Debes vincularte con tu cuenta de email"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     emailBloc = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: "Example@example.com",
//                     labelText: "Correo electronico"),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     passwordBloc = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: "******", labelText: "Contraseña"),
//               ),
//               RaisedButton(
//                 onPressed: emailBloc == emailToValidate
//                     ? () {
//                         _auth
//                             .signInWithEmailAndPassword(
//                                 email: emailBloc, password: passwordBloc)
//                             .then((value) =>
//                                 value.user.linkWithCredential(globalCredential))
//                             .then((value) {
//                           myUser = value.user;
//                           currentSesion = 'Email';
//                           isLogged = true;
//                           Navigator.of(context).pop();
//                         });
//                       }
//                     : null,
//                 child: Text("Ingresar"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

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
}

class Profile {
  String email;

  Profile({
    this.email,
  });
}
