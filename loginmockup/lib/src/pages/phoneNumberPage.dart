import 'package:flutter/material.dart';





class PhoneNumberPage {
  bool accept = false;
  Widget phoneNumberPage(BuildContext context) {
    final leftMargin = MediaQuery.of(context).size.width * 0.08;

    return Stack(
      children: <Widget>[
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
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                hintText: '123-456 78 90',
                labelText: 'Escribe tu número',
              ),
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
                  "Verificar",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {

              }),
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
