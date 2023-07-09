import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_m4/controllers/auth_controller.dart';
import 'package:proyecto_m4/pages/register_page.dart';
import 'package:proyecto_m4/providers/form_provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

///Se iniciaria como anonimo 
class LoginPage extends ConsumerWidget {
  ///constructor del Login
  LoginPage({super.key});
  ///Nombre de la ruta
  static String get routeName => 'login';
  ///URL de la ruta
  static String get routeLocation => '/$routeName';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context, WidgetRef ref) {
    ///hacemos referencia a nuestro hidepasswordProvider
    final bool hidePassword = ref.watch(hidePasswordProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const FlutterLogo(size: 150),

                const SizedBox(
                  height: 64,
                ),

                /// CORREO
                TextFormField(
                  controller: _emailController,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Correo',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),

                  validator: ValidationBuilder().email().build(),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(
                  height: 16,
                ),

                /// CONTRASEÑA
                TextFormField(
                  controller: _passwordController,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.password_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref.read(
                          hidePasswordProvider.notifier,
                        ).state = !hidePassword;
                      },
                      icon: Icon(
                        hidePassword ?
                        Icons.visibility_off :
                        Icons.visibility,
                      ),
                    ),
                  ),

                  obscureText: hidePassword,
                  validator: ValidationBuilder().minLength(6).build(),
                ),

                const SizedBox(
                  height: 16,
                ),

                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(49),
                  ),
                  onPressed: () {},
                  child: const Text('Acceder con Email'),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 1,
                        color: Colors.black,
                      ),
                      const Text('o'),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: AuthController.signInWithGoogle,
                  text: 'Acceder con Google',
                  borderRadius: 100,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: <Widget>[
            const Text(
              '¿Aún no tienes cuenta?',
            ),
            TextButton(
              onPressed: () => context.go(RegisterPage.routeLocation),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
