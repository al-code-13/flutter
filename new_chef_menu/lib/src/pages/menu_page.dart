
import 'package:flutter/material.dart';

TextStyle styles = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calle 70 # 8 -33"),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.motorcycle,
                size: 30.0,
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      title: Text("Escoja el servicio que desea obtener"),
                      content: getServices(),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  
  getServices() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(right: 16),
          leading: Icon(
            Icons.home,
            size: 40.0,
            color: Colors.green,
          ),
          title: Text('Domicilios',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(right: 16),
          leading: Icon(
            Icons.shopping_basket,
            size: 40.0,
          ),
          title: Text('Recoger', style: styles),
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(right: 16),
          leading: Icon(
            Icons.wc,
            size: 40.0,
          ),
          title: Text('Reservacion', style: styles),
        ),
      ],
    );
  }
}
