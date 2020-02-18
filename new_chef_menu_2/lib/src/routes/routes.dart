import 'package:flutter/material.dart';
import 'package:new_chef_menu_2/src/pages/home_page.dart';



Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    'HomePage':(BuildContext) => HomePage(),
  };
}

