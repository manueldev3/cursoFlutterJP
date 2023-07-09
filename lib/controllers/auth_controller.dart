import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_m4/model/collections.dart';
import 'package:proyecto_m4/model/user_model.dart';

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
    await FirebaseAuth
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
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Update user profile
  static Future<void> updateProfile(UserModel userModel) async {
    final User? user = currentUser();
    await Collections.users.doc(user?.uid).set(userModel.toJson());
  }

  /// Stream document user
  static Stream<UserModel?> streamUser() {
    final User? user = AuthController.currentUser();
    final Stream<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
    Collections.users.doc(user?.uid).snapshots();

    return documentSnapshot.map(
        (DocumentSnapshot<Map<String, dynamic>> document) {
      if (document.exists) {
        return UserModel.fromDocument(document);
      }
      return null;
    });
  }

  /// Cerrar sesión
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
