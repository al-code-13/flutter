import 'package:flutter/material.dart';
import 'package:new_chef_menu_2/src/data/data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
//-------------------Aspect Radio_______________________//

TextStyle styleFont = TextStyle(fontSize: 20, color: Colors.green);
TextStyle styleFont2 = TextStyle(fontSize: 16);
List<typeFood> foodCategory = [
  typeFood(title: "Ofertas"),
  typeFood(title: "Sub"),
  typeFood(title: "Ensaladas"),
  typeFood(title: "Otros"),
  typeFood(title: "Bebidas"),
  typeFood(title: "Galletas"),
];
List<product> sub = [
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
];
List<product> ensaladas = [
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Ensalada",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Ensalada",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Ensalada",
      value: "10.200"),
];
List<product> otros = [
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "Sub Atun",
      value: "10.200"),
];
List<product> bebidas = [
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "COCAAAA",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "COCAAAA",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "COCAAAA",
      value: "10.200"),
];
final _controller = ScrollController();
final _height = 100.0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text("SubWay"),
            floating: false,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    "https://i.ytimg.com/vi/WQSnHQ6Bxvk/maxresdefault.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 32, 16, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "SubWay",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: RatingBarIndicator(
                                  rating: 4.5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Text(
                                "Pedido minimo",
                                style: styleFont2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                "11.400",
                                style: styleFont2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 48,
                          child: VerticalDivider(),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Text(
                                "Valor entrega",
                                style: styleFont2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                "3.400",
                                style: styleFont2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 50.0,
              child: ListView.builder(
                //controller: _controller,
                itemCount: foodCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () => _onTaps(index),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              foodCategory[index].title,
                              style: styleFont,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                child: Container(
                  //color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: sub.length.toDouble() * 100,
                  child: PageView.custom(
                    scrollDirection: Axis.horizontal,
                    childrenDelegate: SliverChildListDelegate([
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sub.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(sub[index].img),
                                    foregroundColor: Colors.green,
                                  ),
                                  Text(sub[index].title),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[Text(sub[index].value)],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: ensaladas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(ensaladas[index].img),
                                    foregroundColor: Colors.green,
                                  ),
                                  Text(ensaladas[index].title),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(ensaladas[index].value)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: otros.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(otros[index].img),
                                    foregroundColor: Colors.green,
                                  ),
                                  Text(otros[index].title),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(otros[index].value)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      ListView.builder(
                        controller: _controller,
                        itemCount: bebidas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Container(
                              width: 122,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(bebidas[index].img),
                              ),
                            ),
                            title: Text(bebidas[index].title),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(bebidas[index].value),
                              ],
                            ),
                          );
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTaps(int i) {
    print(i);
    _controller.animateTo(_height * 10,
        duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }
}
