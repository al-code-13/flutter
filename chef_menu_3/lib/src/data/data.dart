import 'package:flutter/material.dart';

class Order {
  String product;
  String optionals;
  int value;
  String observations;
  int count;
  int totalValue;
  Order({@required this.product,this.optionals,@required this.value,this.observations,this.count});
}