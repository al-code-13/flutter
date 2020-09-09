import 'package:ecomers_chairs/constans.dart';
import 'package:ecomers_chairs/models/products.dart';
import 'package:ecomers_chairs/screens/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icon/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text("Back".toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2),
      actions: [
        IconButton(
            icon: SvgPicture.asset("assets/icon/cart_with_item.svg"),
            onPressed: () {})
      ],
    );
  }
}
