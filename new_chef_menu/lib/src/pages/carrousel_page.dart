import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/components/favoritos_page.dart';
import 'package:new_chef_menu/src/pages/components/food_category.dart';
import 'package:new_chef_menu/src/pages/components/promociones_page.dart';
import 'package:new_chef_menu/src/pages/components/restaurant_page.dart';
import 'package:new_chef_menu/src/utils/icon_string_util.dart';

import 'data.dart';

PageController pageController;
TextStyle styleFont = TextStyle(fontSize: 10);


List list = [
  'https://chefmenu.co/restaurantes/bogota/mr-lee/combo-cerdito-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-combo-delicias-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-bowl-beef-oriental.jpg'
];




class CarrouselPage extends StatefulWidget {
  CarrouselPage({Key key}) : super(key: key);
  @override
  _CarrouselPageState createState() => _CarrouselPageState();
}

class _CarrouselPageState extends State<CarrouselPage> {
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calle 70 Nº8 -33"),
        ),
        body: Column(
          children: <Widget>[
            //------------------------------------------------------CARRUSEL------------------------------------------------------
            PromocionesPage(),
            //------------------------------------------------------FOOD CATEGORY------------------------------------------------------
            FoodCategoryPage(),
            //------------------------------------------------------RESTAURANTES CERCA DE TI------------------------------------------------------
            FavoritosPage(),
            //------------------------------------------------------RESTAURANTES------------------------------------------------------
            RestaurantPage(),
          ],
        ));
  }
}
