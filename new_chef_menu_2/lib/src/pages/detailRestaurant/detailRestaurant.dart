import 'package:flutter/material.dart';
import 'package:new_chef_menu_2/src/data/data.dart';

class DetailRestaurant extends StatefulWidget {
  final List<product> lista;
  DetailRestaurant({Key key, @required this.lista}) : super(key: key);
  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

final _controller = ScrollController();

class _DetailRestaurantState extends State<DetailRestaurant> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.lista.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 104,
                      width: 104,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.lista[index].img, scale: 200),
                      ),
                    ),
                  ],
                ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.lista[index].title,
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Delicioso sandwich de atun"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(widget.lista[index].value),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
