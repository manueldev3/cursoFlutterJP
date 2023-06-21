import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_m4/pages/home_page.dart';
import 'package:proyecto_m4/pages/login_page.dart';
import 'package:proyecto_m4/pages/register_page.dart';
import 'package:proyecto_m4/pages/splash_page.dart';
import 'package:proyecto_m4/providers/auth_provider.dart';

// ignore: always_specify_types
final _key = GlobalKey<NavigatorState>();

///constructo de nuestras rutas
final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ProviderRef<GoRouter> ref) {
  final AsyncValue<User?> authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routeLocation,
    routes:<GoRoute>[

      GoRoute(
        ///URL que se veran en WEB
        path: SplashPage.routeLocation,
        ///ID al cual llamamos y nos redirige 
        name: SplashPage.routeName,
        ///Definimos la donde navegaremos
        builder: (BuildContext context, GoRouterState state) =>
         const SplashPage(),
      ),

      GoRoute(
        path: HomePage.routeLocation,
        name: HomePage.routeName,
        builder: (BuildContext context, GoRouterState state) => 
        const HomePage(),
      ),
      
      GoRoute(
        path: LoginPage.routeLocation,
        name: LoginPage.routeName,
        builder: (BuildContext context, GoRouterState state) => 
        const LoginPage(),
      ),

      GoRoute(
        path: RegisterPage.routeLocation,
        name: RegisterPage.routeName,
        builder: (BuildContext context, GoRouterState state) => 
        RegisterPage(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Si esta cargando, no redireccione 
      if (authState.isLoading || authState.hasError) {
        return null;
      }

      ///Manejamos el estado de inicio de seccion
      final bool isAuth = authState.valueOrNull != null;

      ///Que hace en cada caso posible de inisio de seccion
      ///Tiene el enfoque WEB
      final bool isSplash = state.location == SplashPage.routeLocation;
      if (isSplash) {
        return isAuth ? HomePage.routeLocation : RegisterPage.routeLocation;
      }

      final bool isLoggingIn = state.location == LoginPage.routeLocation;
      if (isLoggingIn) {
        return isAuth ? HomePage.routeLocation : null;
      }

      final bool isRegisterIn = state.location == RegisterPage.routeLocation;
      if (isRegisterIn) {
        return isAuth ? HomePage.routeLocation : null;
      }

      return isAuth ? null : SplashPage.routeLocation;
    },
  );
});
