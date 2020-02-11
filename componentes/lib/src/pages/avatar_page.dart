import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://ichef.bbci.co.uk/news/410/cpsprodpb/A85B/production/_104299034_tv050571340.jpg')
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
      body: 
      Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 10),
          image: NetworkImage('https://ichef.bbci.co.uk/news/410/cpsprodpb/A85B/production/_104299034_tv050571340.jpg'),
        ),
      )
    );
  }
}