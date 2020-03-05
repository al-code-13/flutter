import 'package:flutter/material.dart';
import 'package:loginmockup/src/pages/login_page.dart';
import 'package:loginmockup/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chef Menu",
        initialRoute: 'LoginPage',
        routes: getRoutes(),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => LoginPage());
        },
      );
  
  }
}
