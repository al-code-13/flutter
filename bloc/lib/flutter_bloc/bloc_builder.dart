import 'dart:async';

import '../bloc/bloc.dart';
import 'package:flutter/material.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);
typedef BlocBuilderCondition<S> = bool Function(S previous, S current);

class BlocBuilder<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;
  final BlocBuilderCondition<S> condition;
  final BlocWidgetBuilder<S> builder;

  BlocBuilder({
    Key key,
    @required this.bloc,
    @required this.builder,
    this.condition,
  })  : assert(bloc != null),
        assert(builder != null),
        super(key: key);

  @override
  _BlocBuilderState createState() => _BlocBuilderState<E, S>();
}

class _BlocBuilderState<E, S> extends State<BlocBuilder<E, S>> {
  StreamSubscription<S> _subscription;
  S _previosState;
  S _state;

  @override
  void initState() {
    super.initState();
    _previosState = widget.bloc.currentState;
    _state = widget.bloc.currentState;
    _subscribe();
  }
  
  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
  @override
  void didUpdateWidget (BlocBuilder<E,S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc.state != widget.bloc.state) {
      if (_subscription != null) {
        _unsubscribe();
        _previosState = widget.bloc.currentState;
        _state = widget.bloc.currentState;
      }
      _unsubscribe();
    }
    
  }
  @override
  Widget build(BuildContext context) => widget.builder(context,_state);

  void _subscribe() {
    if (widget.bloc.state != null) {
      _subscription = widget.bloc.state.skip(1).listen(
            (S state) {
              if (widget.condition?.call(_previosState,state)?? true) {
                setState(() {
                  _state = state;
                });                
              }
              _previosState = state;
            },
          );
    }
  }
  void _unsubscribe(){
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
