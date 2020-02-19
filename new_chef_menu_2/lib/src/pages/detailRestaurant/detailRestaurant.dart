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
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 112,
                      width: 112,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.lista[index].img, scale: 200),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Sub de atun",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    Text("descripcion de  el sandwuichito"),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  height: 112,
                  child: Text("11.500"),
                ),
              ],
            ),
            index != widget.lista.length
                ? Divider()
                : Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 2),
                  ),
          ],
        );
      },
    );
  }
}
