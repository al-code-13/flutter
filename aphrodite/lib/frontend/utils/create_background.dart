import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CreateBackground {
  Widget createMediumBackground(BuildContext context) {
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.4; // from 0-1.0
    final size = MediaQuery.of(context).size;
    final banner = Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://as.com/tikitakas/imagenes/2019/04/07/portada/1554591966_143306_1554592537_noticia_normal.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
          child: Container(
            color: Colors.purple.withOpacity(_opacity),
          ),
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            banner,
          ],
        ),
      ],
    );
  }
}
