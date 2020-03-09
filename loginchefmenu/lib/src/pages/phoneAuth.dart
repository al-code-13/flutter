import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser myUser;
  String phoneNumber;
  String smsCode;
  String phoneVerificationId;

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
                  verifyPhone();
                },
                child: Text("Ingresar"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.phoneVerificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeRedend]) async {
      this.phoneVerificationId = verId;
      print(verId);

      smsCodeDialog(context).then((value) {
        print("El codigo y se mando de nuevo a firebase");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      print("Entra como satisfactorio gonorrea");
      _auth.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          setState(() {
            print('Authentication successful');
          });
          return value.user;
        } else {
          setState(() {
            print('Invalid code/invalid authentication');
          });
        }
      }).catchError((error) {
        setState(() {
          print('Something has gone wrong, please try later');
        });
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
      setState(() {
        print('Something has gone wrong, please try later');
      });
    }).then((FirebaseUser user) async {
      setState(() {
        print('Authentication successful');
      });
    });
  }

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
                      print("no hay usuario dentro");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pruebas de verificacion con telefono xd"),
      ),
      body: Center(
        child: RaisedButton.icon(
          onPressed: logInPhone,
          icon: Icon(Icons.phone),
          label: Text("Ingresar con numero de telefono"),
        ),
      ),
    );
  }
}
