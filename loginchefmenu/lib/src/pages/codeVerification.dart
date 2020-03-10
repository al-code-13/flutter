import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/pages/futures/validators.dart';
import 'package:loginchefmenu/src/pages/utils/pinInput.dart';

class CodeVerification extends StatefulWidget {
  CodeVerification({Key key}) : super(key: key);

  @override
  CodeVerificationState createState() => CodeVerificationState();
}

class CodeVerificationState extends State<CodeVerification> {
  String verificationCode;
  final validators = Validators();
  Future<bool> sendData() async {
    if (verificationCode.length >= 6) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Stack(
          children: <Widget>[
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
                    verificationCode = value;
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
                  onPressed: snapshot.hasData
                      ? () {
                          validators.signInWithPhoneNumber();
                        }
                      : null),
            ),
          ],
        );
      },
    );
  }
}
