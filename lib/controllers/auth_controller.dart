import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Auth controller
class AuthController {
  AuthController._();

  /// Funcion para obtener el usuario logeado
  static User? currentUser() => FirebaseAuth.instance.currentUser;

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

  /// Función para registrarse o loguearse con google
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}
