import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final opciones = ['Uno','Dos','Tres','Cuatro'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola'),
      ),
      body: ListView(
        children: _crearListaCorta()
      ),
    );
  }
  List<Widget> _crearItems(){
    List<Widget> Lista = new List<Widget>(); 
    for (var item in opciones) {
        final tempWidget = ListTile(
          title: Text(item),
    );
      Lista..add(tempWidget)
           ..add(Divider() );
    }
    return Lista;
  }
  List<Widget> _crearListaCorta(){
    return opciones.map((item){
      return Column(
        children: <Widget>[
          ListTile(
              title: Text(item + '!') ,
              subtitle: Text('SubTitle'),
              leading: Icon(Icons.add),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){print(item);},

            ),
            Divider()
        ],
        );
    }).toList();

  }
}