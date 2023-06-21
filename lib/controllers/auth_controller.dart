import 'package:firebase_auth/firebase_auth.dart';

/// Auth controller
class AuthController {
  AuthController._();

  /// Función por el inicio de seción del usuario
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await FirebaseAuth
      .instance
      .signInWithEmailAndPassword(email: email, password: password);
  }

  /// Función para el registor de usuario
  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await FirebaseAuth
      .instance
      .createUserWithEmailAndPassword(
        email: email,
        password: password,
    );

    await credential.user?.updateDisplayName(name);
  }
}
