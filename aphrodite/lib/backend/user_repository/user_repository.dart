import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> logInEmail(String email, String password) {
    print('Email:{$email} Password: {$password]');
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  //Salir
  Future<void> signOut() async {
    return Future.wait([_auth.signOut()]);
  }

  //Usuario dentro
  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  //Current User
  Future<FirebaseUser> getUser() async {
    return (await _auth.currentUser());
  }

  //Olvido la contraseña
  void forgotPassword(email) {
    _auth
        .sendPasswordResetEmail(email: email)
        .then((onValue) => print('Mensaje enviado exitosamente'))
        .catchError((onError) => throw (onError.code));
  }

  // Cambio de contraseña
  Future changePassword(
      String email, String oldPassword, String newPassword) async {
    final AuthResult result = await _auth
        .signInWithEmailAndPassword(email: email, password: oldPassword)
        .catchError((e) =>
            throw ('Error al cambiar contraseña, intenta probando con la correcta'));
    return await result.user
        .updatePassword(newPassword)
        .then((onValue) => print('cambio de contraseña exitoso'))
        .catchError((onError) =>
            throw ('Error al cambiar contraseña, intenta probando con la correcta'));
  }
}
