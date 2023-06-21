import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_m4/providers/auth_provider.dart';

///Definicion del pagina inicio
class HomePage extends ConsumerWidget {
  ///Constructor de HomePage
  const HomePage({super.key});
  ///Nombre de la ruta
  static String get routeName => 'home';
  ///Localizacion de la ruta
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? name = ref.watch(authProvider.select(
      (AsyncValue<User?> value) => value.valueOrNull?.displayName,
    ),);

    return Scaffold(
      appBar: AppBar(title: const Text('Your phenomenal app')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Wellcome, $name. This is your homepage.'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
