import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _whidth = 50.0;
  double _heigth = 50.0;
  double _transition = 0.0;
  Color _color = Colors.pink;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Center(
        child: AnimatedContainer(
            width: _whidth,
            height: _heigth,
            duration: Duration(seconds: 1) ,
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: _color,
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
         setState(changeForm);
        },
      ),
    );
  }

  void changeForm() {
    final random = Random();
    _color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1);
    _heigth = random.nextInt(300).toDouble();
    _whidth = random.nextInt(300).toDouble();
    _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
  }
}