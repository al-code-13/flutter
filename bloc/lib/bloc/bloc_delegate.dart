import 'package:meta/meta.dart';
import 'bloc.dart';
import 'transition.dart';

class BlocDelegate {
  // Indica que cada invocación de un método que sobre-escribe m también debe invocar m
  @mustCallSuper
  void onEvent(Bloc bloc, Object event) => null;

  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) => null;

  @mustCallSuper
  void onError(Bloc bloc, Object error, StackTrace stackTrace) => null;

}
