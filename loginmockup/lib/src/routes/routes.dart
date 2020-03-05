import 'package:flutter/material.dart';

import '../pages/home_page.dart';

Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    'HomePage':(_) => HomePage(),
  };
}