import 'package:bloc/utils/action_button.dart';
import 'package:flutter/material.dart';
import '../blocs/counter_bloc.dart';
import '../flutter_bloc/bloc_builder.dart';
import '../flutter_bloc/bloc_provider.dart';

class CounterScreenWithGlobalState extends StatelessWidget {
  const CounterScreenWithGlobalState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterScaffold(title: 'Counter - Global State');
  }
}

class CounterScaffold extends StatelessWidget {
  final String title;
  CounterScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: BlocBuilder(
        bloc: counterBloc,
        builder: (BuildContext context, int state) {
          return Text(
            '$state',
            style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
          );
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              iconData: Icons.add,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
            ),
            ActionButton(
              iconData: Icons.remove,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
            ActionButton(
              iconData: Icons.replay,
              onPressed: () {
                counterBloc.dispatch(CounterEvent.reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CounterPageLocalState extends StatefulWidget {
  @override
  _CounterPageLocalStateState createState() => _CounterPageLocalStateState();
}

class _CounterPageLocalStateState extends State<CounterPageLocalState> {
  CounterBloc _counterBloc;
  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: _counterBloc,
      child: CounterScaffold(title: 'Counter - Local State'),
    );
  }
}
