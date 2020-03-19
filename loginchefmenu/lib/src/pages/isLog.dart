import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginchefmenu/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:loginchefmenu/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:loginchefmenu/src/pages/utils/createBackground.dart';
import 'package:loginchefmenu/src/repository/user_repository.dart';

class IsLog extends StatefulWidget {
  final FirebaseUser user;
  IsLog({Key key, @required this.user}) :assert(user!=null), super(key: key);

  @override
  _IsLogState createState() => _IsLogState();
}

class _IsLogState extends State<IsLog> {
  FirebaseUser get _user => widget.user;
  TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle style2 = TextStyle(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CreateBackground().createMediumBackground(context),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.25,
            child: CircleAvatar(
              maxRadius: 110,
              backgroundImage: NetworkImage(
                  "https://thumbs.dreamstime.com/z/restaurante-logotipo-del-vector-del-caf%C3%A9-men%C3%BA-plato-comida-o-cocinero-icono-del-cocinero-69996518.jpg"),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nombre:", style: style, textAlign: TextAlign.left),
                  Text("${_user.displayName}", style: style2, textAlign: TextAlign.left),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Correo electrónico:",
                      style: style, textAlign: TextAlign.left),
                  Text("${_user.email}",
                      style: style2, textAlign: TextAlign.left),
                ],
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.12,
            child: Column(
              children: <Widget>[
                FacebookSignInButton(
                  borderRadius: 5,
                  onPressed: () {
                    UserRepository().loginWithFacebook();
                  },
                  text: "Continuar con Facebook",
                ),
                GoogleSignInButton(
                  borderRadius: 5,
                  onPressed: () async {
                    UserRepository().signInWithGoogle();
                  },
                  text: "   Continuar con Google   ",
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text("Cerrar Sesión"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: () {
                    UserRepository().signOut();
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
