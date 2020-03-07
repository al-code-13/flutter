import 'package:flutter/material.dart';
import 'package:loginmockup/src/pages/codeVerification.dart';

import 'createBackground.dart';
import 'package:loginmockup/src/pages/otherMethods.dart';
import 'package:loginmockup/src/pages/personalData.dart';
import 'package:loginmockup/src/pages/phoneNumberPage.dart';


class LoginPage extends StatefulWidget {
 LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final createBackground = CreateBackground();
  final phoneNumberPage = PhoneNumberPage();
  final otherMethods = OtherMethods();
  final personalData = PersonalData();
  //final twitterLogin = new TwitterLogin(
  //   consumerKey: 'Y9KsGQiLOSKqFt4ieZCwQm23R',
  //   consumerSecret: '3q02R80J9N9VdmRkyjF8eruAODaS79u1cZ61UN2dLamHm49LKW',
  // );
  bool isLogged = false;
  String currentSesion;
  bool isRegister = true;

  String emailBloc;
  String passwordBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           createBackground.createBigBackground(context),
          //  createBackground.createSlimBackground(context),
          phoneNumberPage.phoneNumberPage(context),
          // otherMethods.otherMethods(context),
          // CodeVerification(),
          // personalData.personalData(context),
          // isLogged ? _isLog(context) : _loginForm(context),
        ],
      ),
    );
  }

  

  
}
// Container(
//                   height: 64.0,
//                   width: 56.0,
//                   child: Card(
//                     color: Color.fromRGBO(0, 0, 0, 0.2),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                       child: TextField(
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         style: TextStyle(fontSize: 24),
//                         decoration: InputDecoration(
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 4,
//                             ),
//                           ),

//                           counterText: '',
//                           hintStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
