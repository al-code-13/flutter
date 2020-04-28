import 'package:flutter/material.dart';

class SplassScreen extends StatelessWidget {
  const SplassScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://thumbs.gfycat.com/UntidyLinearCranefly-size_restricted.gif'),
      ),
    );
  }
}

