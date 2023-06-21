import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Flujo de datos de autentificacion desde Firebase, el cual trabaja en caliente
final StreamProvider<User?> authProvider = StreamProvider<User?>(
  (StreamProviderRef<User?> ref) => FirebaseAuth.instance.authStateChanges(),
);
