import 'package:flutter/material.dart';
import 'package:new_chef_menu_2/src/data/data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:new_chef_menu_2/src/pages/BLUR.dart';
import 'package:new_chef_menu_2/src/pages/SABT.dart';
import 'package:new_chef_menu_2/src/pages/detailRestaurant/detailRestaurant.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

//-------------------Aspect Radio_______________________//
PageController pageController = PageController(
  initialPage: 0,
  keepPage: true,
);
TextStyle styles = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
int bottomSelectedIndex = 0;
int currentPage = 0;
TextStyle styleFont = TextStyle(fontSize: 20, color: Colors.green);
TextStyle styleFont2 = TextStyle(fontSize: 16);

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
      title: "otros",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "otros",
      value: "10.200"),
  product(
      img: "https://topdelis.com/static/platillos/n/b6608930_943920000_n.jpg",
      title: "otros",
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

List<typeFood> foodCategory = [
  //typeFood(title: "Ofertas", ),
  typeFood(title: "Sub", lista: sub),
  typeFood(title: "Ensaladas", lista: ensaladas),
  typeFood(title: "Otros", lista: otros),
  typeFood(title: "Bebidas", lista: bebidas),
  //typeFood(title: "Galletas"),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            centerTitle: true,
            primary: true,
            pinned: true,
            stretchTriggerOffset: 20,
            floating: false,
            title: SABT(
              child: Text("Pan Pa Ya"),
            ),
            flexibleSpace: Positioned(
              child: BLUR(
                child: Positioned.fill(
                  child: Image.network(
                    "https://chefmenu.co/restaurantes/bogota/pan-pa-ya/logo.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
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
                              GestureDetector(
                                child: Text(
                                  "SubWay",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(0.0),
                                          title: Text(
                                            "Pan Pa Ya",
                                            textAlign: TextAlign.center,
                                          ),
                                          content: getServices(),
                                        );
                                      });
                                },
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
                              ),
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
              height: 60.0,
              child: ListView.builder(
                //controller: _controller,
                itemCount: foodCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () {
                      pageController.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                      currentPage = index;
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            ButtonBar(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: index == currentPage
                                              ? Colors.green
                                              : Colors.white),
                                    ),
                                  ),
                                  child: Text(
                                    foodCategory[index].title,
                                    style: styleFont,
                                  ),
                                )
                              ],
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
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    itemCount: foodCategory.length,
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                        print(currentPage);
                      });
                    },
                    itemBuilder: (_, int index) {
                      return DetailRestaurant(lista: foodCategory[index].lista);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getServices() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("brunch, diners americanos y pizza"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 24,
                ),
                Text("Desayunos, Pizza, Sandwich, Panaderia",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 32),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Sabado", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: 24,
                          ),
                          Text("07:00 AM a 21:00 PM",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
