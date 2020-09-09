import 'package:ecomers_chairs/constans.dart';
import 'package:ecomers_chairs/screens/product/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("Dashboard"),
      centerTitle: false,
      actions: [
        IconButton(
            icon: SvgPicture.asset("assets/icon/notification.svg"),
            onPressed: () {})
      ],
    );
  }
}
