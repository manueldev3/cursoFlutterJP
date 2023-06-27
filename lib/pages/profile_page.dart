import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:proyecto_m4/controllers/auth_controller.dart';
import 'package:proyecto_m4/controllers/storage_controller.dart';

/// Profile page
class ProfilePage extends ConsumerStatefulWidget {
  /// Constructor
  const ProfilePage({super.key});
  ///Nombre de la ruta
  static String get routeName => 'profile';
  ///URL de la ruta
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  File? _photo;
  User? _currentUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    final User? currentUser = AuthController.currentUser();
    setState(() {
      _currentUser = currentUser;
    });
    _nameController.text = currentUser?.displayName ?? '';
    _emailController.text = currentUser?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(128),
                      child: _photo != null ?
                        Image.file(
                          _photo!,
                          width: 128,
                          height: 128,
                        ) :
                        Image.network(
                          _currentUser?.photoURL != null ?
                            _currentUser?.photoURL ?? '' :
                            'https://via.placeholder.com/128',
                          width: 128,
                          height: 128,
                          fit: BoxFit.contain,
                        ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton.filled(
                        onPressed: () async {
                          final File? filePath = await StorageController
                              .imgFromGallery();
                          setState(() {
                            _photo = filePath;
                          });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
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
                        enabled: false,
                        controller: _emailController,

                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Correo',
                          helperText: 'Debe solicitarnos el cambio de su correo',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),

                        validator: ValidationBuilder().email().build(),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // DropdownButtonFormField(
                      //   items: [
                      //
                      //   ],
                      //   onChanged: onChanged,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
}
