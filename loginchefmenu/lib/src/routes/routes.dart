import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/pages/isLog.dart';
import 'package:loginchefmenu/src/pages/otherMethods.dart';
import 'package:loginchefmenu/src/pages/personalData.dart';
import 'package:loginchefmenu/src/pages/phoneAuth.dart';
import 'package:loginchefmenu/src/pages/phoneNumberPage.dart';


import '../pages/login_page.dart';


Map<String,WidgetBuilder> getRoutes(){
  return<String,WidgetBuilder>{

    'LoginPage'   :(_) => LoginPage(),
    'PhoneAuth'   :(_) => PhoneAuth(),
    'PersonalData':(_) => PersonalData(),
    'OtherMethods':(_) => OtherMethods(),
    'PhoneNumberPage':(_) => PhoneNumberPage(),
    'IsLog':(_) => IsLog(),
    
  };
}