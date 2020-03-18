import 'package:bloc/utils/action_button.dart';
import 'package:flutter/material.dart';
import '../blocs/counter_bloc.dart';
import '../flutter_bloc/bloc_builder.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter - Local state"),
      ),
      body: Center(
        child: BlocBuilder(bloc: _counterBloc,
         builder:(BuildContext context,int state){
           return Text(
             '$state',
             style: TextStyle(
               fontSize:100,
               fontWeight: FontWeight.bold
             ),
           );
         },)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              iconData: Icons.add,
              onPressed: (){
                _counterBloc.dispatch(CounterEvent.increment);
              },
            ),
            ActionButton(
              iconData: Icons.remove,
              onPressed: (){
                _counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
            ActionButton(
              iconData: Icons.replay,
              onPressed: (){
                _counterBloc.dispatch(CounterEvent.reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}
