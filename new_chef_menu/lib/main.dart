import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/carrousel_page.dart';
import 'package:new_chef_menu/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chef Menu",
      initialRoute: 'CarrouselPage',
      routes: getRoutes(),
    
    onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => CarrouselPage()
          );
      },
    );
  }
}

