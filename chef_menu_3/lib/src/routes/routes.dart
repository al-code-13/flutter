import 'package:chef_menu_3/src/pages/home_page.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    'HomePage':(BuildContext) => HomePage(),
  };
}