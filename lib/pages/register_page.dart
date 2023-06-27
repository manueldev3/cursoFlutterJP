import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:proyecto_m4/controllers/auth_controller.dart';
import 'package:proyecto_m4/providers/form_provider.dart';

///Se iniciaria como anonimo 
class RegisterPage extends ConsumerWidget {
  ///constructor del Login
  RegisterPage({super.key});
  ///Nombre de la ruta
  static String get routeName => 'register';
  ///URL de la ruta
  static String get routeLocation => '/$routeName';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _emailController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController(); 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///hacemos referencia a nuestro hidepasswordProvider
    final bool hidePassword = ref.watch(hidePasswordProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de usuario'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            ///Envolvimos el Column en otro Widget para no tener problemas
            ///con la pantalla (daba warning por tamaño)
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  
                  const FlutterLogo(size: 150),
            
                  const SizedBox(
                    height: 20,
                  ),
            
                  ///NOMBRE
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Nombre',
                      prefixIcon: const Icon(Icons.person_outline_sharp),
                    ),
            
                    validator: (String? value) {
                      if(value != null && value.isEmpty) {
                        return 'El nombre es requerido';
                      }
                      return null;
                    },
                  ),
            
                  const SizedBox(
                    height: 16,
                  ),
            
                  ///CORREO
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
            
                  ///CONTRASEÑA 
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
            
                  ///VERIFICACION CONTRASEÑA
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Repetir contraseña',
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
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Debe repertir la contraseña';
                      } else if (
                        value != null && value != _passwordController.text
                      ) {
                        return 'Las contraseñas deben ser iguales';
                      }
                      return null;
                    },
                  ),
            
                  const SizedBox(
                    height: 16,
                  ),
            
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if(
                        _formKey.currentState != null && 
                        _formKey.currentState!.validate()
                      ) {
                        AuthController.signUp(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                      return;
                    }, 
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
