import 'dart:async';

import 'package:chef_menu_3/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

PageController pageController = PageController(
  initialPage: 0,
  keepPage: true,
);
int totalValue;
int allValue = 0;
int currentPage = 0;
Color primaryColors = Colors.white;
TextStyle styleProduct = TextStyle(fontSize: 20.0);
TextStyle titulos = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
bool acept = false;
bool entregaInmediata = false;
final Completer<WebViewController> _webController =
    Completer<WebViewController>();

List<Order> orders = [
  Order(
      product: "Combo Arroz Mixto",
      optionals: "Coca Cola Tradicional.",
      observations: null,
      count: 1,
      value: 10000),
  Order(
      product: "Fusión Pekin Costilla",
      optionals: "Coca Cola Tradicional.",
      observations: "Calientita por favor",
      count: 1,
      value: 12900),
];

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _progressAnimation;
  AnimationController _progressAnimcontroller;
  @override
  @override
  void initState() {
    super.initState();

    _progressAnimcontroller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
        .animate(_progressAnimcontroller);

    _setProgressAnim(0, 1);
  }

  double growStepWidth, beginWidth, endWidth = 0.0;
  int totalPages = 5; //un valor mas

  _setProgressAnim(double maxWidth, int curPageIndex) {
    setState(() {
      growStepWidth = maxWidth / totalPages;
      beginWidth = growStepWidth * (curPageIndex - 1);
      endWidth = growStepWidth * curPageIndex;

      _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
          .animate(_progressAnimcontroller);
    });

    _progressAnimcontroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    var maxWidth = mediaQD.size.width;
    return Scaffold(
      appBar: AppBar(
          title: Align(
        alignment: Alignment.center,
        child: Text(
          "Carrito de compras",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      )),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            color: Colors.green,
            child: Row(
              children: <Widget>[
                AnimatedProgressBar(
                  animation: _progressAnimation,
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: pageController,
          //physics: new NeverScrollableScrollPhysics(), ---------------//
          onPageChanged: (i) {
            _progressAnimcontroller.reset();
            _setProgressAnim(maxWidth, i + 1);
          },
          children: <Widget>[
            Container(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 0, 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        orders[index].product,
                                        style: styleProduct,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: Text(
                                      "❌",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Text("Opcionales:"),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                              child: Text(orders[index].optionals),
                            ),
                            orders[index].observations != null
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text("Opcionales:"))
                                : SizedBox(),
                            orders[index].observations != null
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                    child: Text(orders[index].observations))
                                : SizedBox(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (orders[index].count > 1) {
                                              orders[index].count--;
                                              totalValue =
                                                  orders[index].totalValue -
                                                      orders[index].value;
                                              orders[index].totalValue =
                                                  totalValue;
                                              allValue -= totalValue;
                                            }
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 35,
                                          height: 35,
                                          color: Colors.red,
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 35,
                                        height: 35,
                                        color: Colors.white,
                                        child: Text(
                                            orders[index].count.toString()),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            orders[index].count++;
                                            totalValue = orders[index].value *
                                                orders[index].count;
                                            orders[index].totalValue =
                                                totalValue;
                                                allValue += totalValue;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 35,
                                          height: 35,
                                          color: Colors.green,
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: orders[index].totalValue != null
                                        ? Text("\$" +
                                            orders[index].totalValue.toString())
                                        : Text("\$" +
                                            orders[index].value.toString()),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      index == orders.length - 1
                          ? TextField(
                              decoration:
                                  InputDecoration(hintText: "Comentarios"))
                          : SizedBox()
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "¿Cuando lo quieres?",
                    style: titulos,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text("Hoy"),
                    items: <String>['Hoy', 'Mañana', 'Pasado mañana']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: entregaInmediata,
                          onChanged: (bool val) {
                            setState(() {
                              entregaInmediata = val;
                            });
                          }),
                      Text("Entrega inmediata"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "¿Como lo quieres pagar?",
                    style: titulos,
                  ),
                  RaisedButton(
                    color: Colors.black,
                    onPressed: null,
                    textColor: Colors.white,
                    child: Text("Contra entrega"),
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text("Efectivo"),
                    items: <String>[
                      'Efectivo',
                      'Datafono',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Cambio de ..."),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Contacto",
                    style: titulos,
                  ),
                  Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(hintText: "Nombre"),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Apellido"),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration(hintText: "Correo electronico"),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Movil o fijo"),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Dirección de contacto",
                      style: titulos,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ciudad",
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text("Bogota"),
                          items: <String>['Bogota'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: null,
                        ),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: "KR 72 R BIS # 42 B - 24 SUR"),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "101 "),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: acept,
                          onChanged: (bool val) {
                            setState(() {
                              acept = val;
                            });
                          }),
                      Text("Si, he leido y acepto los",
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  title: Text("Terminos y condiciones"),
                                  //content: //getServices(),
                                );
                              });
                        },
                        child: Text(
                          " terminos y condiciones ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("de Chefmenu.",
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Text("Descuento"), title: Text("Total:")),
            BottomNavigationBarItem(
              icon: Text(""),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Text("\$0"),
              title: Text("\$"+allValue.toString()),
            )
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          pageController.animateToPage(currentPage,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          currentPage += 1;
        },
        color: Colors.yellow,
        child: Text("SIGUIENTE"),
      ),
    );
  }

  getServices() {
    return WebView(
      initialUrl: "https://www.chefmenu.co/tyc2018",
      javascriptMode: JavascriptMode.disabled,
      onWebViewCreated: (WebViewController webViewController) {
        _webController.complete(webViewController);
      },
    );
  }
}

class AnimatedProgressBar extends AnimatedWidget {
  AnimatedProgressBar({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: 6.0,
      width: animation.value,
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
