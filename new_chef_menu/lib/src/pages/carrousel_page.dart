import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/data.dart';
import 'package:new_chef_menu/src/utils/icon_string_util.dart';

PageController pageController;
List list = [
  'https://chefmenu.co/restaurantes/bogota/mr-lee/combo-cerdito-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-combo-delicias-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-bowl-beef-oriental.jpg'
];
List<data> foodCategory = [
  data(icon: "accessibility", category: "pizza1"),
  data(icon: "bug_report", category: "pizza2"),
  data(icon: "bug_report", category: "pizza3"),
  data(icon: "bug_report", category: "pizza4"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
  data(icon: "bug_report", category: "pizza5"),
];

TextStyle stileFont = TextStyle(fontSize: 10);

int currentPage = 0;

class CarrouselPage extends StatefulWidget {
  CarrouselPage({Key key}) : super(key: key);
  @override
  _CarrouselPageState createState() => _CarrouselPageState();
}

class _CarrouselPageState extends State<CarrouselPage> {
  void initState() {
    pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carrousel"),
        ),
        body: Column(
          children: <Widget>[
            CarouselSlider(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              enableInfiniteScroll: false,
              // autoPlay: true,
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
            Container(
              //decoration: BoxDecoration(color: Colors.black12),
              margin: EdgeInsets.only(top: 20.0),
              height: 148.0,
              child: ListView.builder(
                itemCount: foodCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        color: Colors.white,
                        child: ClipOval(
                          child: getIcon(
                            foodCategory[index].icon,
                          ),
                        ),
                      ),
                      Text(
                        foodCategory[index].category,
                        style: stileFont,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
