import 'package:flutter/material.dart';

import '../data.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

TextStyle styleRest = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
TextStyle styleSubText = TextStyle(fontSize: 10, color: Colors.black87);
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

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 170,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(restaurant.length, (index) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  restaurant[index].title,
                  textAlign: TextAlign.left,
                  style: styleRest,
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      restaurant[index].img,
                      width: 160,
                    ),
                  )),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      restaurant[index].value,
                      style: styleSubText,
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      restaurant[index].rating,
                      style: styleSubText,
                    ),
                  ),
                ],
              )
            ],
          ));
        }),
      ),
    );
  }
}
