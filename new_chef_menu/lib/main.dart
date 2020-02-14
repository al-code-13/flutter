import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/home_page.dart';
import 'package:new_chef_menu/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chef Menu",
      initialRoute: 'HomePage',
      routes: getRoutes(),
    
    onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => HomePage()
          );
      },
    );
  }
}

