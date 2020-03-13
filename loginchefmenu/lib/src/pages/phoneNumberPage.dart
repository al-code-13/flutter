import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/bloc/login_bloc.dart';
import 'package:loginchefmenu/src/bloc/provider.dart';
import 'package:loginchefmenu/src/pages/createBackground.dart';
import 'package:loginchefmenu/src/pages/futures/validators.dart';
import 'package:loginchefmenu/src/pages/isLog.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/utils/pinInput.dart';

import 'otherMethods.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key key}) : super(key: key);

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String smsCode;
  String phoneVerificationId;
  Widget _navegador;
  bool sent = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  Future<void> verifyPhone(BuildContext context, String phone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.phoneVerificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeRedend]) async {
      this.phoneVerificationId = verId;
      sent = true;
      setState(() {});
      print("a");
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      _auth.signInWithCredential(auth).then((value) {
        if (value.user != null) {
          print("Autenticacion vergas");
          if (value.user.email != null) {
            _navegador = IsLog();
            _navigators(context, _navegador);
          } else {
            _navegador = PersonalData();
            _navigators(context, _navegador);
          }
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
        _navegador = IsLog();
        _navigators(context, _navegador);
      } else {
        _navegador = PersonalData();
        _navigators(context, _navegador);
      }
    }).catchError((onError) {
      print('Something has gone wrong, please try later');
    });
  }

  Future _navigators(context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _logOut() async {
    await _auth.signOut();
  }

  bool accept = false;
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return sent ? smsBuild(context) : phoneBuild(context);
  }

  Widget phoneBuild(BuildContext context) {
    final bloc = Provider.of(context);
    final leftMargin = MediaQuery.of(context).size.width * 0.08;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              CreateBackground().createBigBackground(context),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: leftMargin,
                child: Text(
                  "Ingresar con tu celular",
                  style: TextStyle(fontSize: 24, color: Colors.black54),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.55,
                left: leftMargin,
                child: StreamBuilder(
                  stream: bloc.phoneStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        onTap: () {
                          _scrollController.animateTo(
                              (MediaQuery.of(context).size.height * 0.34),
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 1600));
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          labelText: 'Escribe tu número',
                          hintText: "123-456-7890",
                          errorText: snapshot.error,

                          // counter: Text(snapshot.data),
                        ),
                        onChanged: bloc.changePhone,
                      ),
                    );
                  },
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                left: MediaQuery.of(context).size.width * 0.16,
                right: MediaQuery.of(context).size.width * 0.16,
                child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: Text(
                        "Verificar",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: () {
                      verifyPhone(context, "+57" + bloc.phone);
                    }),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.74,
                left: MediaQuery.of(context).size.width * 0.29,
                right: MediaQuery.of(context).size.width * 0.16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherMethods()));
                  },
                  child: Text(
                    "Ingresar con otro metodo",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              // +57 3004896661 @
              Positioned(
                left: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      value: accept,
                      onChanged: (value) {
                        setState(() {
                          accept = !accept;
                        });
                      },
                    ),
                    Text(
                      "Acepto terminos y condiciones",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget smsBuild(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CreateBackground().createSlimBackground(context),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.16,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Text(
              "Mi código es:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.06,
            child: Text(
              "300 4896662",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: VerificationCodeInput(
                keyboardType: TextInputType.number,
                length: 6,
                autofocus: true,
                onCompleted: (String value) {
                  smsCode = value;
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            left: MediaQuery.of(context).size.width * 0.16,
            right: MediaQuery.of(context).size.width * 0.16,
            child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: Text(
                    "Continuar",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                onPressed: () {
                  signInWithPhoneNumber(context);
                }),
          ),
        ],
      ),
    );
  }
}
