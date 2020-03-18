import 'bloc_delegate.dart';

class BlocSupervisor{
  BlocDelegate _delegate = BlocDelegate();
  // Evitar que el mixin sea instanciado o extendido, fuera de la clase
  BlocSupervisor._();

  // Crear instancia del la claseMixin para tener que llamart _instance y 
  // tener que pasar por BlocDelegate
  static final BlocSupervisor _instance = BlocSupervisor._();
  static BlocDelegate get delegate => _instance._delegate; 
  
  // El metodo que permitirá instanciar a esta clase
  static set delegate(BlocDelegate d){
    _instance._delegate = d ?? BlocDelegate();
  }
}