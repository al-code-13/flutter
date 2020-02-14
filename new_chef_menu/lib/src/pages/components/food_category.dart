import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/utils/icon_string_util.dart';

import '../data.dart';

class FoodCategoryPage extends StatefulWidget {
  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

TextStyle styleFont = TextStyle(fontSize: 12);
List<data> foodCategory = [
  data(icon: "accessibility", category: "Postres"),
  data(icon: "bug_report", category: "Hamburguesa"),
  data(icon: "bug_report", category: "Pizza"),
  data(icon: "bug_report", category: "Pollo"),
  data(icon: "bug_report", category: "Saludable"),
  data(icon: "bug_report", category: "Desayuno"),
  data(icon: "bug_report", category: "Asiatica"),
  data(icon: "bug_report", category: "Colombiana"),
  data(icon: "bug_report", category: "Carnes"),
  data(icon: "bug_report", category: "Americana"),
  data(icon: "bug_report", category: "Pasta"),
  data(icon: "bug_report", category: "Italiana"),
];

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: Colors.black12),
      margin: EdgeInsets.only(top: 16.0),
      height: 100.0,
      child: ListView.builder(
        itemCount: foodCategory.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              alignment: Alignment(0.0, 0.0),
              //width: 64,
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: Colors.white,
                    child: ClipOval(
                      child: getIcon(
                        foodCategory[index].icon,
                      ),
                    ),
                  ),
                  Text(
                    foodCategory[index].category,
                    style: styleFont,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}