import 'package:flutter/material.dart';

class CardPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardType1(),
          SizedBox(height: 30.0,),
          _cardType2(),
        ],
      ),
      );
  }

  _cardType1() {
    return Card(
      elevation: 30.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(title: Text('Title'),
          subtitle: Text('subTitle'),
          leading: Icon(Icons.photo_album)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){},
              ),
              FlatButton(
                onPressed: (){},
                child: Text('Cancel'),
              )
            ],
          )
        ],
      ) ,
    );
  }

  Widget _cardType2() {
    final card = Container(
      // clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage('https://wallpaperplay.com/walls/full/d/3/6/13585.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 5),
            height: 300.0,
            fit: BoxFit.cover,
          ),
                
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('xd'),
            
          ),
        ],
      ),
      );
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,  
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(4, 6)
            )
          ]
        ),
        child: ClipRRect(
          child: card,
          borderRadius: BorderRadius.circular(30.0),
        ),
      );
  }
}