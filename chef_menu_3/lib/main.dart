import 'package:chef_menu_3/src/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'src/routes/routes.dart';

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
      theme: ThemeData(primarySwatch: Colors.green),
    
    onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => HomePage()
          );
      },
    );
  }
}