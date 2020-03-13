import 'package:flutter/material.dart';
import 'package:loginchefmenu/src/pages/phoneNumberPage.dart';

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
        initialRoute: 'PhoneNumberPage',
        routes: getRoutes(),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => PhoneNumberPage());
        },
      ),
    );
  }
}
