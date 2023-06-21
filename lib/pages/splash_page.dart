import 'package:flutter/material.dart';

///es la primera pagina que se abrira
class SplashPage extends StatelessWidget {
  ///constructor de splashpage
  const SplashPage({super.key});
  ///nombre de la ruta
  static String get routeName => 'splash';
  ///localizacion de la ruta
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context) => const Scaffold(
      body: Center(child: Text('Splash Page')),
    );
}
