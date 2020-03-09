import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/pages/animated_container.dart';
import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/input_page.dart';
import 'package:componentes/src/pages/listview_page.dart';
import 'package:componentes/src/pages/slider_page.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){
 return <String, WidgetBuilder>{
        '/'                  : (_) => HomePage(),
        'alert'              : (_) => AlertPage(),
        'avatar'             : (_) => AvatarPage(),
        'card'               : (_) => CardPage(),
        'animatedContainer'  : (_) => AnimatedContainerPage(),
        'input'              : (_) => InputPage(),
        'slider'             : (_) => SliderPage(),
        'lista'              : (_) => ListaPage(),
      };
}
