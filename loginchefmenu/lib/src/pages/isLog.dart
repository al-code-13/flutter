import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginchefmenu/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:loginchefmenu/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:loginchefmenu/src/pages/utils/createBackground.dart';
import 'package:loginchefmenu/src/pages/utils/flutter_country_picker.dart';
import 'package:loginchefmenu/src/repository/user_repository.dart';

class IsLog extends StatefulWidget {
  final FirebaseUser user;
  IsLog({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              CreateBackground().createCircleBackground(context),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  "Mi Perfil",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.04,
                child: CircleAvatar(
                  maxRadius: 80,
                  backgroundImage: NetworkImage(
                      "https://thumbs.dreamstime.com/z/restaurante-logotipo-del-vector-del-caf%C3%A9-men%C3%BA-plato-comida-o-cocinero-icono-del-cocinero-69996518.jpg"),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width - 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Nombre:",
                              style: style, textAlign: TextAlign.left),
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "Aqui va el nombre",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(32.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Apellido:",
                              style: style, textAlign: TextAlign.left),
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "Aqui va el apelido",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(32.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Email:",
                              style: style, textAlign: TextAlign.left),
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "Aqui va el email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(32.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Numero:",
                              style: style, textAlign: TextAlign.left),
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              icon: CountryPicker(
                                showDialingCode: true,
                                showName: false,
                                onChanged: (Country value) {},
                              ),
                              hintText: "123-456-7890",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(32.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              fillColor: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                child: Text(
                                  "Cambiar Contraseña",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.82,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        child: Container(
                          width: 250,
                          padding:
                              EdgeInsets.symmetric(horizontal: 80, vertical: 12),
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
}