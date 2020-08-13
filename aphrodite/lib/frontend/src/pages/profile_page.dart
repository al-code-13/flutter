import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.5; // from 0-1.0
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int _page = 0;
    PageController _pagina = PageController(
      initialPage: 0,
    );
    GlobalKey _bottomNavigationKey = GlobalKey();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_input,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: size.height / 3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://as.com/tikitakas/imagenes/2019/04/07/portada/1554591966_143306_1554592537_noticia_normal.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  color: Colors.black.withOpacity(_opacity),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.3,
            left: -size.width * 0.03,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: BorderSide(color: Colors.pink)),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(0),
                  height: size.height,
                  width: size.width,
                  // color: Colors.blue
                  child: PageView(
                    onPageChanged: (v) {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(v);
                    },
                    controller: _pagina,
                    children: <Widget>[
                      Container(
                        color: Colors.black,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                      Container(
                        color: Colors.black,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22,
            left: MediaQuery.of(context).size.width * 0.08,
            child: CircleAvatar(
              maxRadius: 60,
              backgroundImage: NetworkImage(
                  "https://as.com/tikitakas/imagenes/2019/04/07/portada/1554591966_143306_1554592537_noticia_normal.jpg"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.pink,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30), 
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {

          _pagina.jumpToPage(index);
        },
      ),
    );
  }
}