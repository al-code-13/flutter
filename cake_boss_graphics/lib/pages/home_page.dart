import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VentasPage extends StatelessWidget {
  const VentasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int ventasTotales = 10542800;
    List<Venta> ventas = [
      Venta('Ventas telefonicas', 1500800, Colors.purple),
      Venta('Ventas por plataformas', 3040000, Colors.blue),
      Venta('Ventas en punto', 6002000, Colors.green),
      Venta('Ticket promedio', 170133, Colors.orangeAccent[700]),
    ];
    List<charts.Series<Venta, String>> _dataCanales() {
      return [
        charts.Series<Venta, String>(
          id: 'Canales',
          data: ventas,
          domainFn: (Venta venta, __) => venta.title,
          measureFn: (Venta venta, __) => venta.value,
          labelAccessorFn: (Venta venta, _) {
            return '${((venta.value * 100) / ventasTotales).round()} %';
          },
          colorFn: (Venta venta, __) =>
              charts.ColorUtil.fromDartColor(venta.color),
        )
      ];
    }

    var dataVentas = [
      Ventas('Bog. cedritos', 3000, Colors.blue),
      Ventas('Medellin', 2000, Colors.purple),
      Ventas('Cali', 1000, Colors.green),
      Ventas('Bog. Suba', 3000, Colors.orangeAccent[700]),
      Ventas('Bogota', 4000, Colors.red),
    ];
List<charts.Series<Ventas, String>> _dataVentas() {
      return [
        charts.Series<Ventas, String>(
          id: 'Ventas',
          data: dataVentas,
          domainFn: (Ventas venta, __) => venta.tipo,
          measureFn: (Ventas venta, __) => venta.valor,
          labelAccessorFn: (Ventas venta, _) {
            return '${venta.valor} %';
          },
          colorFn: (Ventas venta, __) =>
              charts.ColorUtil.fromDartColor(venta.color),
        )
      ];
    }
    var chefMenu = [
      PuntosDeVenta('Cedritos', 24),
      PuntosDeVenta('Chapinero', 36),
      PuntosDeVenta('Plaza', 13),
      PuntosDeVenta('Bogota Cedritos', 30),
      PuntosDeVenta('Bogota Chapinero', 40),
      PuntosDeVenta('Bogota Plaza', 10),
      PuntosDeVenta('Bogota Kennedy', 10),
      PuntosDeVenta('Chia', 10),
      PuntosDeVenta('Cartagena', 10),
      PuntosDeVenta('Bog. Centro Mayor ', 10),
      PuntosDeVenta('Bogota Fontibon ', 10),
      PuntosDeVenta('Bogota Suba ', 10),
      PuntosDeVenta('Medellin ', 10),
    ];
    var domicilios = [
      PuntosDeVenta('Cedritos', 67),
      PuntosDeVenta('Chapinero', 15),
      PuntosDeVenta('Plaza', 23),
      PuntosDeVenta('Bogota Cedritos', 30),
      PuntosDeVenta('Bogota Chapinero', 40),
      PuntosDeVenta('Bogota Plaza', 10),
      PuntosDeVenta('Bogota Kennedy', 10),
      PuntosDeVenta('Chia', 10),
      PuntosDeVenta('Cartagena', 10),
      PuntosDeVenta('Bog. Centro Mayor ', 10),
      PuntosDeVenta('Bogota Fontibon ', 10),
      PuntosDeVenta('Bogota Suba ', 10),
      PuntosDeVenta('Medellin ', 10),
    ];
    var uberEats = [
      PuntosDeVenta('Cedritos', 55),
      PuntosDeVenta('Chapinero', 27),
      PuntosDeVenta('Plaza', 12),
      PuntosDeVenta('Bogota Cedritos', 30),
      PuntosDeVenta('Bogota Chapinero', 40),
      PuntosDeVenta('Bogota Plaza', 10),
      PuntosDeVenta('Bogota Kennedy', 10),
      PuntosDeVenta('Chia', 10),
      PuntosDeVenta('Cartagena', 10),
      PuntosDeVenta('Bog. Centro Mayor ', 10),
      PuntosDeVenta('Bogota Fontibon ', 10),
      PuntosDeVenta('Bogota Suba ', 10),
      PuntosDeVenta('Medellin ', 10),
    ];
    var rappi = [
      PuntosDeVenta('Cedritos', 55),
      PuntosDeVenta('Chapinero', 27),
      PuntosDeVenta('Plaza', 12),
      PuntosDeVenta('Bogota Cedritos', 30),
      PuntosDeVenta('Bogota Chapinero', 40),
      PuntosDeVenta('Bogota Plaza', 10),
      PuntosDeVenta('Bogota Kennedy', 10),
      PuntosDeVenta('Chia', 10),
      PuntosDeVenta('Cartagena', 10),
      PuntosDeVenta('Bog. Centro Mayor ', 10),
      PuntosDeVenta('Bogota Fontibon ', 10),
      PuntosDeVenta('Bogota Suba ', 10),
      PuntosDeVenta('Medellin ', 10),
    ];
    List<charts.Series<PuntosDeVenta, String>> _dataPuntos() {
      return [
        charts.Series<PuntosDeVenta, String>(
          id: 'Ridder',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: chefMenu,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
        ),
        charts.Series<PuntosDeVenta, String>(
          id: 'Domicilios',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: domicilios,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
        ),
        charts.Series<PuntosDeVenta, String>(
          id: 'Restaurante',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: uberEats,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        ),
      ];
    }

    List<charts.Series<PuntosDeVenta, String>> _dataPlataforma() {
      return [
        charts.Series<PuntosDeVenta, String>(
          id: 'Chefmenu',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: chefMenu,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.purple),
        ),
        charts.Series<PuntosDeVenta, String>(
          id: 'Domicilios',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: domicilios,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        ),
        charts.Series<PuntosDeVenta, String>(
          id: 'uberEats',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: uberEats,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
        ),
        charts.Series<PuntosDeVenta, String>(
          id: 'Rappi',
          domainFn: (PuntosDeVenta punto, __) => punto.nombre,
          measureFn: (PuntosDeVenta punto, __) => punto.valor,
          data: rappi,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
        )
      ];
    }

    return SafeArea(
      bottom: true,
      top: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  child: Text("Totales"),
                ),
                Tab(
                  child: Text("Punto de venta"),
                ),
                Tab(
                  child: Text("Plataforma"),
                ),
              ],
            ),
            title: Text('Ventas'),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Ventas totales',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black45)),
                              ),
                              Text(
                                '\$ 10542800',
                                style: TextStyle(fontSize: 40),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Canales de venta',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: charts.PieChart(
                                  _dataCanales(),
                                  animate: true,
                                  behaviors: [
                                    charts.DatumLegend(
                                      horizontalFirst: false,
                                      showMeasures: true,
                                      desiredMaxColumns: 1,
                                      outsideJustification:
                                          charts.OutsideJustification.start,
                                      legendDefaultMeasure: charts
                                          .LegendDefaultMeasure.firstValue,
                                    ),
                                  ],
                                  defaultRenderer: charts.ArcRendererConfig(
                                      arcRendererDecorators: [
                                        charts.ArcLabelDecorator(
                                            labelPosition:
                                                charts.ArcLabelPosition.auto),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Ventas totales',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: charts.PieChart(
                                  _dataVentas(),
                                  animate: true,
                                  behaviors: [
                                    charts.DatumLegend(
                                      desiredMaxColumns: 1,
                                      outsideJustification:
                                          charts.OutsideJustification.start,
                                    )
                                  ],
                                  defaultRenderer: charts.ArcRendererConfig(
                                      arcRendererDecorators: [
                                        charts.ArcLabelDecorator(
                                            labelPosition:
                                                charts.ArcLabelPosition.auto)
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Ventas por punto de venta',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: charts.BarChart(
                                  _dataPuntos(),
                                  primaryMeasureAxis: charts.NumericAxisSpec(
                                      tickProviderSpec:
                                          charts.BasicNumericTickProviderSpec(
                                              desiredMinTickCount: 5)),
                                  vertical: false,
                                  animate: true,
                                  behaviors: [
                                    charts.SeriesLegend(
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                    ),
                                  ],
                                  barGroupingType:
                                      charts.BarGroupingType.grouped,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 16),
                            Center(
                                child: Text(
                              'Ventas por punto de venta',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            SizedBox(height: 16),
                            DataTable(
                              columnSpacing:
                                  MediaQuery.of(context).size.width * 0.05,
                              columns: [
                                DataColumn(label: Text('Sedes')),
                                DataColumn(
                                  label: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage("assets/moto.png")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTBa3GKIXSk8rN2DlUfkSA_g-cpATEpoAdCg2jzH8p9RmoJ3_h9&usqp=CAU")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://as1.ftcdn.net/jpg/02/14/80/30/500_F_214803030_YXG1yaWJ12K6TdBx166hdt4XXF2PNPNm.jpg")),
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Cedritos')),
                                    DataCell(Text('24000')),
                                    DataCell(Text('50000')),
                                    DataCell(Text('70000')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bogota Chapinero')),
                                    DataCell(Text('910003')),
                                    DataCell(Text('986364')),
                                    DataCell(Text('475613')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Plaza')),
                                    DataCell(Text('500000')),
                                    DataCell(Text('600000')),
                                    DataCell(Text('800000')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bogota Kennedy')),
                                    DataCell(Text('500000')),
                                    DataCell(Text('600000')),
                                    DataCell(Text('800000')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Chia')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Cartagena')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bog. Centro Mayor')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bogota Fontibon')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Suba')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Medellin')),
                                    DataCell(Text('805000')),
                                    DataCell(Text('86000')),
                                    DataCell(Text('100000')),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        child: Container(
                          //height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Ventas por plataforma',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: charts.BarChart(
                                  _dataPlataforma(),
                                  primaryMeasureAxis: charts.NumericAxisSpec(
                                      tickProviderSpec:
                                          charts.BasicNumericTickProviderSpec(
                                              desiredMinTickCount: 5)),
                                  vertical: false,
                                  animate: true,
                                  behaviors: [
                                    charts.SeriesLegend(
                                      outsideJustification: charts
                                          .OutsideJustification.endDrawArea,
                                    ),
                                  ],
                                  barGroupingType:
                                      charts.BarGroupingType.grouped,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 16),
                            Center(
                                child: Text(
                              'Ventas por plataforma',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            SizedBox(height: 16),
                            DataTable(
                              columnSpacing:
                                  MediaQuery.of(context).size.width * 0.02,
                              columns: [
                                DataColumn(label: Text('Sedes')),
                                DataColumn(
                                  label: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/logo_chef.png")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://img.pystatic.com/whitelabel/domicilios/social_image.png")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://lh3.googleusercontent.com/9xqvAl1nJlwWlCEONxSzKr4HHdgf3brNuyuggZtR-0I1B6r7SEOTDhgeFhWIA3NBtA")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://static.chollometro.com/threads/thread_full_screen/default/308909_1.jpg")),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width: 35,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://static.chollometro.com/threads/thread_full_screen/default/308909_1.jpg")),
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Cedritos')),
                                    DataCell(Text('42')),
                                    DataCell(Text('11')),
                                    DataCell(Text('20')),
                                    DataCell(Text('12')),
                                    DataCell(Text('12')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bogota Chapinero')),
                                    DataCell(Text('64')),
                                    DataCell(Text('34')),
                                    DataCell(Text('53')),
                                    DataCell(Text('53')),
                                    DataCell(Text('53')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Plaza')),
                                    DataCell(Text('50')),
                                    DataCell(Text('50')),
                                    DataCell(Text('60')),
                                    DataCell(Text('80')),
                                    DataCell(Text('80')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Chia')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Cartagena')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bog. Centro Mayor')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Fontibon')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Bogota Suba')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                                DataRow(
                                  selected: true,
                                  cells: [
                                    DataCell(Text('Bogota Suba')),
                                    DataCell(Text('85')),
                                    DataCell(Text('85')),
                                    DataCell(Text('80')),
                                    DataCell(Text('10')),
                                    DataCell(Text('10')),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Venta {
  final String title;
  final int value;
  final Color color;
  Venta(this.title, this.value, this.color);
}

class Ventas {
  final String tipo;
  final double valor;
  final Color color;
  Ventas(this.tipo, this.valor, this.color);
}

class PuntosDeVenta {
  final String nombre;
  final double valor;

  PuntosDeVenta(this.nombre, this.valor);
}
