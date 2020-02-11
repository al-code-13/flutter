import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valor = 100.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(children: <Widget>[
          _crearSlider(),
          Expanded(child: _crearImagen()),
        ]),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño img',
      // divisions: 20,
      value: _valor,
      min: 10.0,
      max: 400.0,
      onChanged: (valor) {
        setState(() {
          _valor = valor;
        });
      },
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage('https://www.imgworlds.com/wp-content/uploads/2015/12/18-CONTACTUS-HEADER.jpg'),
      width: _valor,
      fit: BoxFit.contain,
    );
  }
}
