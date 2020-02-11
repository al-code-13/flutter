import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icon_string_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    //print( menuProvider.opciones);
    
    return FutureBuilder(
    future: menuProvider.cargarData(),
    initialData: [],
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

      return ListView(
        children: _listaItems(snapshot.data,context),
      );
    },
    );
  }

  List<Widget> _listaItems(List<dynamic> data,BuildContext context) {
    final List<Widget> opciones = [];
    if(data == null){return [];}
    data.forEach((opt){
      final widgetTem = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan),
        onTap: (){
          Navigator.pushNamed(context, opt['ruta']);
          //final route = MaterialPageRoute(
          //  builder:(context){
          //    return AlertPage();
          //  }
          //   );
          // Navigator.push(context, route);
        },
      );
      opciones..add(widgetTem)
      ..add(Divider());
    });
    return opciones;
  }
  
}