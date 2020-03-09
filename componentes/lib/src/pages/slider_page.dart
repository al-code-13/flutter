import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valor = 100.0;
  bool _blockCheck = false;
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
          _checkBox(),
          _createSwicth(),
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
      onChanged: (!_blockCheck)
          ? null
          : (valor) {
              setState(() {
                _valor = valor;
              });
            },
    );
  }

  Widget _checkBox() {
    // return Checkbox(
    //   value: _blockCheck,
    //   onChanged: (value) {
    //     _blockCheck = value;
    //     setState(() {});
    //   },
    // );
    return CheckboxListTile(
      title: Text("Block Slider"),
      value: _blockCheck,
      onChanged: (value) {
        _blockCheck = value;
        setState(() {});
      },
    );
  }
  Widget _createSwicth(){
    return SwitchListTile(
      title: Text("Block Slider"),
      value: _blockCheck,
      onChanged: (value) {
        _blockCheck = value;
        setState(() {});
      },
    );
  }
  Widget _crearImagen() {
    return Image(
      image: NetworkImage(
          'https://www.imgworlds.com/wp-content/uploads/2015/12/18-CONTACTUS-HEADER.jpg'),
      width: _valor,
      fit: BoxFit.contain,
    );
  }
}
