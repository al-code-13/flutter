import 'package:flutter/material.dart';

import '../bloc/bloc.dart';

class BlocProvider<T extends Bloc<dynamic, dynamic>> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.bloc,
    this.child,
  })  : assert(bloc != null),
        super(key: key, child: child);
  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    final BlocProvider<T> provider = context
        .getElementForInheritedWidgetOfExactType<BlocProvider<T>>()
        .widget;
    if (provider == null) {
      throw FlutterError(
          'BlocProvider.of called with a context that does not contain a bloc of type $T.');
    }
    return provider?.bloc;
  }

  BlocProvider<T> copyWith(Widget child) {
    return BlocProvider<T>(
      bloc: bloc,
      key: key,
      child: child,
    );
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
