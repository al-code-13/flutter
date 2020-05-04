import 'package:aphrodite/frontend/src/pages/home_page.dart';
import 'package:aphrodite/frontend/src/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../src/pages/events.dart';
class MenuSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'iTalentt',
              style: TextStyle(color: Colors.white, fontSize: 25 ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('htstps://italentt.com/wp-content/themes/talentos/assets/img/inner-bg.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()))},
            
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()))},

          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Convocatorias'),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>EventsPage()))},
            
            
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}