import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
class OtherMethods {
  bool accept = false;
  Widget otherMethods(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
              Text(
                "Bienvenido de nuevo",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )
            ],
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.08,
          top: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail_outline,
                      color: Colors.green,
                    ),
                    hintText: 'example@hotmail.com',
                    labelText: 'Correo Electronico',
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.green,
                    ),
                    hintText: "****",
                    labelText: 'Contraseña',
                  ),
                ),
              ],
            ),
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
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(
                  "Continuar",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {}),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.77,
          left: MediaQuery.of(context).size.width * 0.12,
          right: MediaQuery.of(context).size.width * 0.12,
          child: FacebookSignInButton(
            borderRadius: 5,
            onPressed: () {},
            text: "Continuar con Facebook",
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.83,
          left: MediaQuery.of(context).size.width * 0.12,
          right: MediaQuery.of(context).size.width * 0.12,
          child: GoogleSignInButton(
            borderRadius: 5,
            onPressed: () async {},
            text: "   Continuar con Google   ",
          ),
        ),
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
                    accept = !accept;
                },
              ),
              Text(
                "Acepto terminos y condiciones",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}