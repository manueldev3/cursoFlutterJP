import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_m4/controllers/auth_controller.dart';
import 'package:proyecto_m4/model/user_model.dart';
import 'package:proyecto_m4/pages/profile_page.dart';
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
  User? currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final User? user = AuthController.currentUser();
      setState(() {
        currentUser = user;
      });
      ref.read(userNotifierProvider.notifier).getUserDocument(user?.uid);
      final UserModel? userDocument = ref.watch(userNotifierProvider);
      if (userDocument == null) {
        context.pushReplacement(ProfilePage.routeLocation);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Bienvenido ${currentUser?.displayName}'),
    ),
    drawer: Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: currentUser != null && currentUser!.photoURL != null ?
                  Image.network(
                    currentUser!.photoURL!,
                    width: 64,
                    height: 64,
                  ) : Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        currentUser?.displayName?.substring(0, 1) ?? 'U',
                        style: Theme.of(context).textTheme.headlineLarge
                        ?.merge(const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentUser?.displayName ?? 'User',
                    ),
                    IconButton(
                      onPressed: () => context.push(ProfilePage.routeLocation),
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Cerrar Sesión'),
                  content: const Text('Estas apunto de cerrar sesión'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: <Widget>[
                    TextButton(
                      onPressed: context.pop,
                      child: const Text('Cancelar'),
                    ),
                    const FilledButton(
                      onPressed: AuthController.signOut,
                      child: Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar sesión'),
          ),
        ],
      ),
    ),
  );
}
