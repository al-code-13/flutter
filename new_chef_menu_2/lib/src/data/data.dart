import 'package:flutter/material.dart';

class typeFood{
  String title;
  List<product> lista;
  typeFood({@required this.title, @required this.lista});
}
class product{
  String img;
  String title;
  String value;
  product({this.img,this.title,this.value});
}
class horario{
  String dia;
  String horaInicio;
  String horaFin;
  horario({this.dia,this.horaInicio,this.horaFin});
}
