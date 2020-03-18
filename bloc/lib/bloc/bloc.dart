import 'package:bloc/bloc/transition.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_supervisor.dart';

abstract class Bloc<Event, State> {
  // Permite enviar datos, errores y eventos realizados al oyente.
  final PublishSubject<Event> _eventSubject = PublishSubject<Event>();

  // Captura el último elemento que se ha agregado al controlador y 
  // lo emite como el primer elemento para cualquier nuevo oyente.
  BehaviorSubject<State> _stateSubject;

  State get initialState;
  State get currentState => _stateSubject.value;
  Stream<State> get state => _stateSubject.stream;

  Bloc() {
    // Añadir el dato inicial
    _stateSubject = BehaviorSubject<State>.seeded(initialState);
    _bindStateSubject();
  }
  @mustCallSuper
  void dispose() {
    // Al cerrar el widget que lo esta implementando cerrará el listener
    _eventSubject.close();
    _stateSubject.close();
  }
    // Manejo de errores, StackTrace para transmitir información al usuario 
    // sobre la secuencia de llamadas que desencadenó una excepción
  void onError(Object error, StackTrace stackTrace) => null;

    // Cuando el stream escucha que hay un evento disponible
  void onEvent(Event event) => null;
    // Se produce una Transition cuando se agrega un nuevo Event y se llama 
    // a mapEventToState
  void onTransition(Transition<Event, State> transition) => null;

    // La notificación se entregará a cualquier widget NotificationListener 
    // con los parámetros de tipo apropiados que sean ancestros del BuildContext 
    // dado. Si BuildContext es nulo, la notificación no se envía.
  void dispatch(Event event) {
    try {
    // Se entrega los parametros para poder hacer la verificacion
      BlocSupervisor.delegate.onEvent(this, event);
      onEvent(event);
    // En caso que si haya evento se agregara al StreamController
      _eventSubject.sink.add(event);
    } catch (error) {
    // En caso de no haber evento se mostrará el error...
      _handleError(error);
    }
  }
    // AsyncExpand se utiliza para garantizar que todos los eventos se procesen
    // en el orden en que se reciben . 
  Stream<State> transForm(
    Stream<Event> events,
    Stream<State> next(Event event),
  ) {
    return events.asyncExpand(next);
  }
    // Deber implementarse al extenderse de una clase bloc, toma como argumento
    // un evento y en un map devuelve un stado o varios
  Stream<State> mapEventToState(Event event);
    // Enlazar el estado con el """""TEMA"""""
  void _bindStateSubject() {
    // Variable para saber el evento acutal
    Event currentEvent;
    transForm(
      _eventSubject,
      (Event event) {
        currentEvent = event;
    // Se retorna una variable de tipo map para realizar el recorido mas adelante..    
        return mapEventToState(currentEvent).handleError(_handleError);
      },
    // Para cada evento se realiza su estado correspondiente
    ).forEach(
      (State nextState) {
    // Evitamos que se vuelva a renderizar cuando su estado actual es igual al 
    // siguiente estado
        if (currentState == nextState || _stateSubject.isClosed) return;
    // Variable instanciada de la clase Transition para la traza de todos los datos  
        final transition = Transition(
          currentState: currentState,
          event: currentEvent,
          nextState: nextState,
        );
    // Se agregan los parametros para ver la traza desde el BlocSupervisor   
        BlocSupervisor.delegate.onTransition(this, transition);
        onTransition(transition);
        _stateSubject.sink.add(nextState);
      },
    );
  }
    // En caso de haber algun error se podra ver en este metodo
  void _handleError(Object error, [StackTrace stackTrace]) {
    BlocSupervisor.delegate.onError(this, error, stackTrace);
    onError(error, stackTrace);
  }
}
