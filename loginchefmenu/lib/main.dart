import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/pages/login_page.dart';

import 'src/bloc/provider.dart';

import 'src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chef Menu",
        initialRoute: 'LoginPage',
        routes: getRoutes(),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => LoginPage());
        },
      ),
    );
  }
}
