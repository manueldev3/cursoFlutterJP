import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Se iniciaria como anonimo 
class LoginPage extends ConsumerWidget {
  ///constructor del Login
  const LoginPage({super.key});
  ///Nombre de la ruta
  static String get routeName => 'login';
  ///URL de la ruta
  static String get routeLocation => '/$routeName';

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            const Text('Login Page'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signInAnonymously();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
