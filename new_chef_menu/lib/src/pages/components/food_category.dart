import 'package:flutter/material.dart';
import 'package:new_chef_menu/src/utils/icon_string_util.dart';

import '../data.dart';

class FoodCategoryPage extends StatefulWidget {
  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

TextStyle styleFont = TextStyle(fontSize: 10);
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
                style: styleFont,
              ),
            ],
          );
        },
      ),
    );
  }
}
