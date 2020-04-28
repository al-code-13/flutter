import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import '../../../backend/authentication_bloc/authentication_bloc.dart';
import '../../../backend/authentication_bloc/bloc.dart';
import '../../../backend/user_repository/user_repository.dart';
import '../../widgets/sideMenu.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> initialImg = [
    'https://images.unsplash.com/photo-1568632234165-47bb34c35708?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://www.inoutviajes.com/galerias-noticias/galerias/8796/medium/IB-BOG-NOCH-Atardecer.jpg',
    'https://i.ytimg.com/vi/0x6Aq_x63rI/maxresdefault.jpg',
    'https://www.kienyke.com/sites/default/files/styles/amp_1200x675_16_9/public/wp-content/uploads/2019/10/Bogota-noche.jpg?itok=LisfTPiD'
  ];
  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Convocatorias"),
      ),
      drawer: MenuSide(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: new TinderSwapCard(
          orientation: AmassOrientation.LEFT,
          totalNum: 4,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) => Card(
            child: 
                Image.network('${initialImg[index]}', fit: BoxFit.cover),
               // Text("data"),
              
            //child: Image.asset('${initialImg[index]}'),
          ),
          cardController: controller,
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              print("se largo a la izquierda");
            } else if (align.x > 0) {
              print("se largo a la derecha");
            }
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            print("se largo acabo");
          },
        ),
      ),
      // floatingActionButton: RaisedButton(
      //   child: Text("data"),
      //   onPressed: () {
      //     showAlertDialog(context);
      //   },
      // ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        UserRepository().signOut();
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Cerrar sesión"),
      content: Text("¿Realmente desea cerrar sesión? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

//listados de convocatorias (aceptar,
//  compartir y rechazar) aceptadas, vencidas y rechazadas

