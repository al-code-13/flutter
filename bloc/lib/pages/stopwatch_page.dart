import 'package:bloc/flutter_bloc/bloc_builder.dart';
import 'package:bloc/flutter_bloc/bloc_provider.dart';
import 'package:flutter/material.dart';
import '../utils/action_button.dart';
import '../blocs/stopwatch.dart';

class StopwatchPageLocalState extends StatefulWidget {
  StopwatchPageLocalState({Key key}) : super(key: key);

  @override
  _StopwatchPageLocalStateState createState() => _StopwatchPageLocalStateState();
}

class _StopwatchPageLocalStateState extends State<StopwatchPageLocalState> {
  StopwatchBloc _stopwatchBloc;
  @override
  void initState() {
    super.initState();
    _stopwatchBloc = StopwatchBloc();
  }
  @override
  void dispose() {
    _stopwatchBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _stopwatchBloc,
       child: StopWatchScaffold(title: 'Stopwatch - Local State'),
    );
  }
}


class StopwatchPageGlobalState extends StatelessWidget {
  const StopwatchPageGlobalState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StopWatchScaffold(
      title: 'Watch - Global State'
    );
  }
}

class StopWatchScaffold extends StatelessWidget {
  final String title;
  const StopWatchScaffold({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopWatchBloc = BlocProvider.of<StopwatchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: stopWatchBloc,
          builder: (BuildContext context, StopwatchState state) {
            return Text(
              state.timeFormated,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: stopWatchBloc,
          condition: (StopwatchState previousState,StopwatchState currentState){
            return previousState.isInitial != currentState.isInitial ||
                   previousState.isRunning != currentState.isRunning; 
          },
          builder: (BuildContext context, StopwatchState state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (state.isRunning)
                  ActionButton(
                    iconData: Icons.stop,
                    onPressed: () {
                      stopWatchBloc.dispatch(StopStopwatch());
                    },
                  )
                else
                  ActionButton(
                    iconData: Icons.play_arrow,
                    onPressed: () {
                      stopWatchBloc.dispatch(StartStopwatch());
                    },
                  ),
                if (!state.isInitial)
                  ActionButton(
                    iconData: Icons.replay,
                    onPressed: () {
                      stopWatchBloc.dispatch(ResetStopwatch());
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
