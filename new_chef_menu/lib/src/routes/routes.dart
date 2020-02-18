import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/home_page.dart';
import 'package:new_chef_menu/src/pages/menu_page.dart';


Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    '/'            :(BuildContext) => MenuPage(),
    'HomePage':(BuildContext) => HomePage(),
  };
}

