import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/carrousel_page.dart';
import 'package:new_chef_menu/src/pages/menu_page.dart';


Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    '/'            :(BuildContext) => MenuPage(),
    'CarrouselPage':(BuildContext) => CarrouselPage(),
  };
}

