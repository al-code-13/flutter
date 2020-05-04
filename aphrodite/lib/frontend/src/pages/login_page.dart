import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../../../backend/authentication_bloc/authentication_event.dart';
import '../../../backend/authentication_bloc/bloc.dart';
import '../../../backend/bloc/bloc.dart';
import '../../../backend/user_repository/user_repository.dart';
import 'home_page.dart';
class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;
  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
final LocalAuthentication auth = LocalAuthentication();
  LoginBloc _loginBloc;

  String user;
  String password;
  static List<String> fondos = [
    'https://images.unsplash.com/photo-1568632234165-47bb34c35708?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://www.inoutviajes.com/galerias-noticias/galerias/8796/medium/IB-BOG-NOCH-Atardecer.jpg',
    'https://i.ytimg.com/vi/0x6Aq_x63rI/maxresdefault.jpg',
    'https://www.kienyke.com/sites/default/files/styles/amp_1200x675_16_9/public/wp-content/uploads/2019/10/Bogota-noche.jpg?itok=LisfTPiD'
  ];
  int fondoRandome = (Random.secure()).nextInt(fondos.length);
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.5; // from 0-1.0

  UserRepository get _userRepository => widget._userRepository;
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnable(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fallo al Iniciar Sesión"),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Iniciando Sesión..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(fondos[fondoRandome]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: Container(
                      color: Colors.black.withOpacity(_opacity),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: size.width * 0,
                top: -size.height * 0.5,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    height: size.height * 2,
                    width: size.width,
                    alignment: Alignment.center,
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height,
                      width: size.width * 0.8,
                      child: SafeArea(
                        top: true,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.white,
                            hintColor: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/italentt-transparente-negro.png',
                                  height: size.width * 0.6,
                                  width: size.width * 0.6,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (_) {
                                      return !state.isEmailValid
                                          ? 'Correo invalido'
                                          : null;
                                    },
                                    controller: _emailController,
                                    onChanged: (v) {
                                      setState(() {
                                        //print(v);
                                        user = v;
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        hintText: 'Usuario',
                                        hoverColor: Colors.white,
                                        focusColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    onChanged: (v) {
                                      setState(() {
                                        //print(v);
                                        password = v;
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                        hintText: "Contraseña",
                                        hoverColor: Colors.white,
                                        focusColor: Colors.white,
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  ButtonTheme(
                                    minWidth: size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      onPressed: () {
                                        if (_emailController.text.isNotEmpty) {
                                          
                                          _onFormSubmitted(); 
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       _biometric();
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://pc-solucion.es/wp-content/uploads/2019/09/que-es-apple-touch-id.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     Container(
                                  //       width: 50,
                                  //       height: 50,
                                  //       decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         image: DecorationImage(
                                  //           fit: BoxFit.cover,
                                  //           image: NetworkImage(
                                  //             "https://lh3.googleusercontent.com/proxy/y-yzy9zGnU86c0dDQm_FZOqhkRxQvq_oAgeD9jYdoGMRI4Gy3ULcPV2HLlFzj3kOzE1fP-KLJUxKfy5w1fTdXXpW6GmmLvkgV5OYL00IyOnLFgRuWHoGgQ",
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     Container(
                                  //       width: 50,
                                  //       height: 50,
                                  //       decoration: BoxDecoration(
                                  //         image: DecorationImage(
                                  //           fit: BoxFit.cover,
                                  //           image: NetworkImage(
                                  //             "https://img.icons8.com/color/480/google-logo.png",
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     Container(
                                  //       width: 50,
                                  //       height: 50,
                                  //       decoration: BoxDecoration(
                                  //         image: DecorationImage(
                                  //           fit: BoxFit.cover,
                                  //           image: NetworkImage(
                                  //             "https://cdn.clipart.email/8c88aafe140a747123b1752161158e21_rounded-instagram-logo-icon-png-hd-png-image-free-download_480-480.png",
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Future _biometric() async {
    bool flag = true;
    if (flag) {
      bool authenticated = false;
      const androidString = const AndroidAuthMessages(
          cancelButton: "Cancelar",
          goToSettingsButton: "Ajustes",
          signInTitle: "Autentiquese",
          fingerprintNotRecognized: "Huella no reconocida",
          fingerprintSuccess: "Success",
          goToSettingsDescription: "Configura tu huella");
      try {
        authenticated = await auth
            .authenticateWithBiometrics(
          localizedReason: "",
          useErrorDialogs: true,
          stickyAuth: true,
          androidAuthStrings: androidString,
        )
            .then((onValue) {
          if (onValue) {
            print(onValue);
            //print(authenticated);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()),
            );
          }
        });
        if (!authenticated) {
          print("ay que esperar que no se joda");
          //exit(0);
        }
      } catch (e) {
        print(e);
      }
      if (!mounted) {
        return;
      }
    }
  }
}
