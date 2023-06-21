import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_m4/model/user_model.dart';
import 'package:proyecto_m4/providers/auth_provider.dart';
import 'package:proyecto_m4/providers/user_provider.dart';

///Definicion del pagina inicio
class HomePage extends ConsumerStatefulWidget {
  /// Constructor
  const HomePage({super.key});

  ///Nombre de la ruta
  static String get routeName => 'home';
  ///URL de la ruta
  static String get routeLocation => '/';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userNotifierProvider.notifier).getUserDocument(
        FirebaseAuth.instance.currentUser?.uid,
      );
      final UserModel? userDocument = ref.watch(userNotifierProvider);
      if (userDocument == null) {
        // context.replace('/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold();
}
