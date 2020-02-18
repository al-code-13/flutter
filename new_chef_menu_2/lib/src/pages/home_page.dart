import 'package:flutter/material.dart';
import 'package:new_chef_menu_2/src/data/data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'dart:io';


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
  typeFood(title: "Beidas"),
  typeFood(title: "Galletas"),
  typeFood(title: "Beidas"),
  typeFood(title: "Galletas"),
  typeFood(title: "Beidas"),
  typeFood(title: "Galletas"),
];
List<product> produto=[
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Atun",value: "10.200"),

  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Pollo",value: "3.950"),

  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Sub Carne",value: "8.200"),
  
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  product(img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",title: "Red Velet",value: "18.900"),
  
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
            //backgroundColor: Colors.transparent,
            pinned: true,
            title: Text("SubWay"),
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://i.ytimg.com/vi/WQSnHQ6Bxvk/maxresdefault.jpg",
                fit: BoxFit.cover,
              ),
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
                              // Spacer(flex: 2,),
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
                controller: _controller,
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
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg'),
                        foregroundColor: Colors.green,
                      ),
                    ],
                  ),
                  title: Text('Sub Atun'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[Text('11.500')],
                  ),
                ),
                childCount: 16,
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
