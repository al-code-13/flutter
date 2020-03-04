import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/pages/phoneAuth.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';


Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{
    'HomePage':(_) => HomePage(),
    'LoginPage':(_) => LoginPage(),
    'PhoneAuth':(_) => PhoneAuth(),
  };
}