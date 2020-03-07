import 'package:flutter/material.dart';

class PersonalData {
  bool vivblePass = false;
  Widget personalData(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.16,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Text(
            "Bienvenido",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.08,
          top: MediaQuery.of(context).size.height * 0.22,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.green,
                    ),
                    hintText: 'Ingrese su nombre',
                    labelText: 'Nombre',
                  ),
                ),
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
                  obscureText: vivblePass,
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
              onPressed: () {}),
        ),
      ],
    );
  }
}
