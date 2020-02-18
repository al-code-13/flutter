import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/pages/components/favoritos_page.dart';
import 'package:new_chef_menu/src/pages/components/food_category.dart';
import 'package:new_chef_menu/src/pages/components/promociones_page.dart';
import 'package:new_chef_menu/src/pages/components/restaurant_page.dart';

import 'data.dart';

TextStyle styleFont = TextStyle(fontSize: 10);

List list = [
  'https://chefmenu.co/restaurantes/bogota/mr-lee/combo-cerdito-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-combo-delicias-online.jpg',
  'https://chefmenu.co/restaurantes/bogota/mr-lee/promo-bowl-beef-oriental.jpg'
];
List<dataRestaurant> restaurant = [
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Don Jediondo',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "3.500",
    rating: '4.9⭐',
  ),
  dataRestaurant(
    title: 'Pan Pa Ya',
    img:
        'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
    value: "2.500",
    rating: '3.9⭐',
  ),
];

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Calle 70 Nº8 -33"),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: SizedBox(
              height: 180,
              child: Center(
                child: PromocionesPage(),
              ),
            )),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 120,
              child: Center(
                child: FoodCategoryPage(),
              ),
            )),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 160,
              child: Center(
                child: FavoritosPage(),
              ),
            )),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildListDelegate(
                restaurant
                    .map(
                      (f) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Text(
                                f.title,
                                textAlign: TextAlign.left,
                                style: styleRest,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  f.img,
                                  width: 160,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  //color: Colors.red,
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Text(
                                    f.value,
                                    style: styleSubText,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  //color: Colors.black,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: Text(
                                    f.rating,
                                    style: styleSubText,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
