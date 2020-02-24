import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

PageController pageController;

class PromocionesPage extends StatefulWidget {
  PromocionesPage({Key key}) : super(key: key);

  @override
  _PromocionesPageState createState() => _PromocionesPageState();
}

int currentPage = 0;
List list = [
  'https://chefmenu.co/restaurantes/bogota/mr-lee/combo-cerdito-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-combo-delicias-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-bowl-beef-oriental.jpg'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(
  list,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. $index image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

class _PromocionesPageState extends State<PromocionesPage> {
  void initState() {
    pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Column(
          children: <Widget>[
            CarouselSlider(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              enableInfiniteScroll: true,
              autoPlay: true,
              height: 150,
              items: list.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: Card(
                            child: Image.network(i),
                          ),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                list,
                (index, url) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index
                            ? Color.fromRGBO(0, 128, 0, 1)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                },
              ),
            ),
          ],
        ));
    return Column(
      children: <Widget>[
        CarouselSlider(
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          enableInfiniteScroll: true,
          autoPlay: true,
          height: 150,
          items: list.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: Card(
                        child: Image.network(i),
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            list,
            (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Color.fromRGBO(0, 128, 0, 1)
                        : Color.fromRGBO(0, 0, 0, 0.4)),
              );
            },
          ),
        ),
      ],
    );
  }
}
