import 'package:bloc/blocs/counter_bloc.dart';
import 'package:bloc/blocs/stopwatch.dart';
import 'package:bloc/pages/stopwatch_page.dart';
import 'package:flutter/material.dart';
import 'counter_page_v2.dart';
import '../flutter_bloc/bloc_provider.dart';
import '../flutter_bloc/bloc_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final stopwatchBloc = BlocProvider.of<StopwatchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Block Exmaple'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Contador'),
            trailing: Chip(
              label: Text("Local State"),
              backgroundColor: Colors.blue[800],
            ),
            onTap: () => _pushScreen(context, CounterPageLocalState()),
          ),
          ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Contador'),
              subtitle: BlocBuilder(
                bloc: counterBloc,
                builder: (BuildContext context, int state) {
                  return Text('$state');
                },
              ),
              trailing: Chip(
                label: Text("Global State"),
                backgroundColor: Colors.green[800],
              ),
              onTap: () => _pushScreen(context, CounterScreenWithGlobalState()),
              onLongPress: () => counterBloc.dispatch(CounterEvent.increment)),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('StopWatch'),
            trailing: Chip(
              label: Text("Local State"),
              backgroundColor: Colors.blue[800],
            ),
            onTap: () => _pushScreen(context, StopwatchPageLocalState()),
          ),
          ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('StopWatchs'),
              subtitle: BlocBuilder(
                bloc: stopwatchBloc,
                builder: (BuildContext context, StopwatchState state) {
                  return Text('${state.timeFormated}');
                },
              ),
              trailing: Chip(
                label: Text("Global State"),
                backgroundColor: Colors.green[800],
              ),
              onTap: () => _pushScreen(context, StopwatchPageGlobalState()),
              onLongPress: () {
                if(stopwatchBloc.currentState.isRunning){
                  stopwatchBloc.dispatch(StopStopwatch());
                }else{
                  stopwatchBloc.dispatch(StartStopwatch());
                }
              }),    
        ],
      ),
    );
  }
}
