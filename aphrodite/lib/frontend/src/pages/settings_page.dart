import 'package:aphrodite/frontend/utils/create_background.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(fontSize: 22);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onPressed: null)
        ],
        backgroundColor: Colors.transparent,
        title: Text("Settings"),
      ),
      body: Stack(
        children: <Widget>[
          CreateBackground().createMediumBackground(context),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Profile Settings",
                      style: title,
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Theme"),
                      trailing: Text("Ligth >"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Send push notifications"),
                      trailing: IconButton(
                          icon: Icon(Icons.radio_button_checked),
                          onPressed: null),
                    ),
                    Text(
                      "Account",
                      style: title,
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Two-factor authentication"),
                      trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: null),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Mobile data use"),
                      trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: null),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Lenguage"),
                      trailing: Text("English >"),
                    ),
                    Text(
                      "Support",
                      style: title,
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("Call us"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text("FeedBack"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22,
            left: MediaQuery.of(context).size.width * 0.08,
            child: CircleAvatar(
              maxRadius: 70,
              backgroundImage: NetworkImage(
                  "https://as.com/tikitakas/imagenes/2019/04/07/portada/1554591966_143306_1554592537_noticia_normal.jpg"),
            ),
          ),
          // Positioned(
          //   top: MediaQuery.of(context).size.height * 0.82,
          //   left: MediaQuery.of(context).size.width * 0.12,
          //   right: MediaQuery.of(context).size.width * 0.12,
          //   child: Column(
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: RaisedButton(
          //           textColor: Colors.white,
          //           child: Container(
          //             width: 250,
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: 80, vertical: 12),
          //             child: Text("Cerrar Sesión"),
          //           ),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           elevation: 0,
          //           color: Colors.red,
          //           onPressed: () {},
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
