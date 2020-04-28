import 'package:flutter/material.dart';

import '../../utils/icon_string_util.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Events> events = [
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2016/01/Martha-Ospina-Odontologia-Integral.png?fit=200%2C200&ssl=1",
        "Martha Ospina",
        "Presupuesto: \$300.000",
        "shared"),
    Events(
        "https://i1.wp.com/italentt.com/wp-content/uploads/2016/02/colombia-model.jpg?fit=200%2C200&ssl=1",
        "Colombia Models",
        "Presupuesto: \$500.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2019/08/linka-logo2.png?fit=300%2C261&ssl=1",
        "Linka",
        "Presupuesto: \$100.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2016/01/Martha-Ospina-Odontologia-Integral.png?fit=200%2C200&ssl=1",
        "Martha Ospina",
        "Presupuesto: \$300.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2016/06/Modelos-y-Protocolo-Colombia.jpg?fit=200%2C200&ssl=1",
        "Colombia Models",
        "Presupuesto: \$500.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2019/08/linka-logo2.png?fit=300%2C261&ssl=1",
        "Linka",
        "Presupuesto: \$100.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2016/01/Martha-Ospina-Odontologia-Integral.png?fit=200%2C200&ssl=1",
        "Martha Ospina",
        "Presupuesto: \$300.000",
        "shared"),
    Events(
        "https://i1.wp.com/italentt.com/wp-content/uploads/2016/02/colombia-model.jpg?fit=200%2C200&ssl=1",
        "Colombia Models",
        "Presupuesto: \$500.000",
        "shared"),
    Events(
        "https://i2.wp.com/italentt.com/wp-content/uploads/2019/08/linka-logo2.png?fit=300%2C261&ssl=1",
        "Linka",
        "Presupuesto: \$100.000",
        "shared"),
  ];
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: TabBar(tabs: [
              Tab(
                child: Text("Postuladas"),
              ),
              Tab(
                child: Text("Rechazadas"),
              ),
              Tab(
                child: Text("Vencidas"),
              )
            ]),
            title: Text("Convocatorias"),
          ),
          body: TabBarView(
            children: [
              Center(
                child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: events.length,
                    itemBuilder: (BuildContext _, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(top: 8),
                        leading: Container(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              events[index].img,
                              fit: BoxFit.fill,
                            )),
                        title: Text(events[index].title),
                        subtitle: Text(events[index].detail),
                        trailing: getIcon(events[index].state),
                      );
                    }),
              ),
              Center(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (BuildContext _, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(top: 8),
                      leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            events[index].img,
                            fit: BoxFit.fill,
                          )),
                      title: Text(events[index].title),
                      subtitle: Text(events[index].detail),
                      trailing: getIcon(events[index].state),
                    );
                  },
                ),
              ),
              Center(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (BuildContext _, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(top: 8),
                      leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            events[index].img,
                            fit: BoxFit.fill,
                          )),
                      title: Text(events[index].title),
                      subtitle: Text(events[index].detail),
                      trailing: getIcon(events[index].state),
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      );
  }
}

class Events {
  final String img;
  final String title;
  final String detail;
  final String state;

  Events(this.img, this.title, this.detail, this.state);
}
