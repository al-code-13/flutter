import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:math' as math;

class CreateBackground {
//------------------Crear fondo para formulario  --------------------------------------------------------------------------
  Widget createCircleBackground(BuildContext context) {
    final circulo = Container(
      width: MediaQuery.of(context).size.width * 1.2,
      height: MediaQuery.of(context).size.width * 1.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromRGBO(53, 176, 63, 68),
            Color.fromRGBO(53, 176, 63, 68),
          ],
        ),
        shape: BoxShape.circle,
      ),
    );
    return Stack(
      children: <Widget>[
        
        Positioned(
          top: -MediaQuery.of(context).size.height * 0.06,
          left: -MediaQuery.of(context).size.width * 0.19,
          child: CircleAvatar(
            maxRadius: 168,
            backgroundImage: NetworkImage(
                "https://previews.123rf.com/images/seamartini/seamartini1702/seamartini170200159/70978472-cartel-de-comida-r%C3%A1pida-en-forma-redonda-con-aperitivos-vector-comida-de-hamburguesas-con-queso-y-pizz.jpg"),
          ),
        ),
        Positioned(
          left: -MediaQuery.of(context).size.width * 0.1,
          top: -100,
          child: circulo,
        ),
      ],
    );
  }

//------------------Crear fondo para formulario  --------------------------------------------------------------------------
  Widget createMediumBackground(BuildContext context) {
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.5; // from 0-1.0
    final size = MediaQuery.of(context).size;
    final banner = Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        height: size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://s1.1zoom.me/big0/841/Meat_products_Vegetables_457159.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
          child: Container(
            color: Colors.black.withOpacity(_opacity),
          ),
        ),
      ),
    );
    final greenLine = Container(
      color: Colors.green,
      height: 10,
      width: double.infinity,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
    );
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            banner,
            greenLine,
          ],
        ),
        // Positioned(
        //   top: 160,
        //   right: 90,
        //   child: Image.network(
        //       "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA01JREFUeNrkWoFto0AQBCsF8BWEVPB0YL6C91fwdgVJKghfgeMK7K8gdgU4FZgOTCowHfC70qA/RY65g4Pbs1c6YTnIZIfZ3dm9CwNBVtd1TJcXWrHydUFrFYZhGVyzkfPz+rJl1+x8WutZdq0ArGt9S2w+eyIEg9jg3jdmjK0H33lIGAYrJxAKJMgPvlKS3Hb5sVBC/MMpXvfK59jwpxiMBQFRiAMA5Y0d/U4r6eigjlW0HgiEyvVbjVDWOLmd6nEtc+24C6dVOzoJAX7jdFnSilznFQoBbb/uLDm/psvcRw0yseB8Jsz57WghgBKWC3upPygC9oOEACc5lLEAD3kU5vyzifPaAEB/c5s6U76rQLdyoJquW/d/NUJokPrPMV7LtvlgSRDZ/UV4Iv/Zq2S21PW1J9XsW1f6Ty5o96VH5XxmOwQeJSi6McIg/IIBh6bc+WIm8leHAV45j5c2swmAjza1CcDeQwBSmwD89RCABFK9PwCUTzaesiCxmQNYY7cNGAuNe8SHgU4vcPpq9oYx2EFIX2DcmoeaIERQWzE6sK26WYm/Hxx2hY2V9H89jDYQOdMy5wIUpFFfYE0HYENi4VsitCqEsD3152YBAAhZjxJqY6ITOQVAKaFdnCktgDB1DgCS0KIjfbdjxstgzRDywauDUEgDKQaRdDQUMyy6nvqoITHtMELhuUMSq/qwACM9GfMAhIJpXP+mterx2DiQZPxGOmyZJz222VMxDAALyg5vNNVgTuUFAxQmmCTEA1jQeiCizymRsWeCJjI5wRvWmUnI0wGWJk3cgg86nnMxFTZhAVeDjaaE9gMA7N/vDcIgaEmG0Znfm0pmgCkLOAx2LdXi3acQMGXBVOPewisAYLq6IIWOKC4AWnSVzs4OS7NEpnpdaoiWGNp+pzj5fkb7b5Az5HSDGsJo3iJwlrzpabrjY3K/hNPip+D/GKuRzOfG7gkWf74/wxy+/6MRT6anxVwCwBsvudrAYI4ww7njY4/RQBz4ZHD6zdY2kegk+IneT1B9o78xCTkgHypz6xybkXBCZOfy4RIYwLQ/3iwD2lTe0CblkNTqZkNAqQSnln6/hASuNBmTELteA1/sU/3vLIO9NTi7HFu9/RNgAAWF4iGbl1aHAAAAAElFTkSuQmCC"),
        // ),
      ],
    );
  }

//------------------Crear fondo para formulario  --------------------------------------------------------------------------
  Widget createBigBackground(BuildContext context) {
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.5; // from 0-1.0
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
              "https://s1.1zoom.me/big0/841/Meat_products_Vegetables_457159.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
          child: Container(
            color: Colors.black.withOpacity(_opacity),
          ),
        ),
      ),
    );
    final greenLine = Container(
      color: Colors.green,
      height: 10,
      width: double.infinity,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
    );
    final title = Text(
      "Chefmenu",
      textAlign: TextAlign.end,
      style: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
    );
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            banner,
            greenLine,
          ],
        ),
        Positioned(
          top: 160,
          right: 30,
          child: Row(
            children: <Widget>[
              // Image.network(
              //     "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA01JREFUeNrkWoFto0AQBCsF8BWEVPB0YL6C91fwdgVJKghfgeMK7K8gdgU4FZgOTCowHfC70qA/RY65g4Pbs1c6YTnIZIfZ3dm9CwNBVtd1TJcXWrHydUFrFYZhGVyzkfPz+rJl1+x8WutZdq0ArGt9S2w+eyIEg9jg3jdmjK0H33lIGAYrJxAKJMgPvlKS3Hb5sVBC/MMpXvfK59jwpxiMBQFRiAMA5Y0d/U4r6eigjlW0HgiEyvVbjVDWOLmd6nEtc+24C6dVOzoJAX7jdFnSilznFQoBbb/uLDm/psvcRw0yseB8Jsz57WghgBKWC3upPygC9oOEACc5lLEAD3kU5vyzifPaAEB/c5s6U76rQLdyoJquW/d/NUJokPrPMV7LtvlgSRDZ/UV4Iv/Zq2S21PW1J9XsW1f6Ty5o96VH5XxmOwQeJSi6McIg/IIBh6bc+WIm8leHAV45j5c2swmAjza1CcDeQwBSmwD89RCABFK9PwCUTzaesiCxmQNYY7cNGAuNe8SHgU4vcPpq9oYx2EFIX2DcmoeaIERQWzE6sK26WYm/Hxx2hY2V9H89jDYQOdMy5wIUpFFfYE0HYENi4VsitCqEsD3152YBAAhZjxJqY6ITOQVAKaFdnCktgDB1DgCS0KIjfbdjxstgzRDywauDUEgDKQaRdDQUMyy6nvqoITHtMELhuUMSq/qwACM9GfMAhIJpXP+mterx2DiQZPxGOmyZJz222VMxDAALyg5vNNVgTuUFAxQmmCTEA1jQeiCizymRsWeCJjI5wRvWmUnI0wGWJk3cgg86nnMxFTZhAVeDjaaE9gMA7N/vDcIgaEmG0Znfm0pmgCkLOAx2LdXi3acQMGXBVOPewisAYLq6IIWOKC4AWnSVzs4OS7NEpnpdaoiWGNp+pzj5fkb7b5Az5HSDGsJo3iJwlrzpabrjY3K/hNPip+D/GKuRzOfG7gkWf74/wxy+/6MRT6anxVwCwBsvudrAYI4ww7njY4/RQBz4ZHD6zdY2kegk+IneT1B9o78xCTkgHypz6xybkXBCZOfy4RIYwLQ/3iwD2lTe0CblkNTqZkNAqQSnln6/hASuNBmTELteA1/sU/3vLIO9NTi7HFu9/RNgAAWF4iGbl1aHAAAAAElFTkSuQmCC"),
              title
            ],
          ),
        ),
      ],
    );
  }

  Widget createSlimBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double _sigmaX = 0.0; // from 0-10
    double _sigmaY = 0.0; // from 0-10
    double _opacity = 0.5; // from 0-1.0
    final appBar = Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        height: size.height * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://s1.1zoom.me/big0/841/Meat_products_Vegetables_457159.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
          child: Container(
            color: Colors.black.withOpacity(_opacity),
          ),
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            appBar,
            Container(
              color: Colors.green,
              height: 10,
              width: double.infinity,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.04,
          right: MediaQuery.of(context).size.width * 0.08,
          child: Text(
            "Chefmenu",
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}