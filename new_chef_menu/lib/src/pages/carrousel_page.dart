import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

PageController pageController;
List<String> list = [
  'https://images.deliveryhero.io/image/pedidosya/products/913429-f13eda90-fbe4-49a2-b082-133dbf1728cb.jpg?quality=80',
  'https://images.deliveryhero.io/image/pedidosya/products/925070-a7515b47-7fc0-4248-8255-68fc05f8383a.jpg?quality=80',
  'https://images.deliveryhero.io/image/pedidosya/products/841918-bcb04bf3-cf79-40ef-9b97-6cc7fee29215.jpg?quality=80',
];

class CarrouselPage extends StatefulWidget {
  CarrouselPage({Key key}) : super(key: key);
  @override
  _CarrouselPageState createState() => _CarrouselPageState();
}

class _CarrouselPageState extends State<CarrouselPage> {
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrousel"),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: list.length,
        itemBuilder: (context, position) {
          return imageSlider(position);
        },
      ),
    );
  }

  imageSlider(int position) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(       
          animation: pageController,
          builder: (context, widget) {
            double value = 1;
            if (pageController.position.haveDimensions) {
              value = pageController.page - position;
              value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: Curves.easeInOut.transform(value) *200,
                width: Curves.easeInOut.transform(value) *300,
                child: widget,
              ),
            );
          },
          child: Container(
            child: Image.network(
              list[position],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
