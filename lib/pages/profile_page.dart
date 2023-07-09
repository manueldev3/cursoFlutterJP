import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_m4/controllers/auth_controller.dart';
import 'package:proyecto_m4/controllers/storage_controller.dart';
import 'package:proyecto_m4/model/position.dart';
import 'package:proyecto_m4/model/user_model.dart';
import 'package:proyecto_m4/pages/home_page.dart';
import 'package:proyecto_m4/providers/form_provider.dart';
import 'package:proyecto_m4/providers/position_provider.dart';

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
  String name = '';
  File? _photo;
  User? _currentUser;
  PositionModel? _currentPosition;
  PositionModel? _position;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late StreamSubscription<UserModel?> profileSubscription;

  @override
  void initState() {
    final User? currentUser = AuthController.currentUser();
    ref.read(loadingButtonProvider.notifier).state = false;
    ref.read(positionsProvider.notifier).getAll();
    setState(() {
      _currentUser = currentUser;
      name = currentUser?.displayName ?? '';
    });
    _nameController.text = currentUser?.displayName ?? '';
    _emailController.text = currentUser?.email ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileSubscription = AuthController.streamUser().listen(
        (UserModel? user) async {
          if (user != null) {
            final PositionModel position = await user.getPosition;
            setState(() {
              _position = position;
              _currentPosition = position;
            });
          }

          if (context.mounted) {
            if (user != null && !context.canPop()) {
              context.pushReplacement(HomePage.routeLocation);
            }
          }
        }
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<PositionModel> positions = ref.watch(positionsProvider);
    final bool loadingButton = ref.watch(loadingButtonProvider);
    return Scaffold(
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
                        onChanged: (String? value) {
                          setState(() {
                            name = value!;
                          });
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
                          helperText: 'Debe solicitarnos el cambio de su'
                              ' correo',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),

                        validator: ValidationBuilder().email().build(),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      if (positions.isNotEmpty)
                      DropdownButtonFormField<PositionModel>(
                        decoration: InputDecoration(
                          labelText: 'Cargo',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: _position != null ? positions.where(
                          (PositionModel item) => item.id == _position!.id,
                        ).first : positions.first,
                        items: positions.map((PositionModel position) =>
                          DropdownMenuItem<PositionModel>(
                            value: position,
                            child: Text(position.name),
                          ),
                        ).toList(),
                        onChanged: (PositionModel? position) {
                          setState(() {
                            _position = position;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _currentUser?.displayName != name ||
                      _position != null && _position?.id != positions.first.id
                        ||
                      _position != null && _position?.id != _currentPosition?.id
                        ? () async {
                      try {
                        if (_nameController.text != _currentUser?.displayName) {
                          await _currentUser?.updateDisplayName(
                            _nameController.text,
                          );
                        }
                        if (_position?.id != _currentPosition?.id) {
                          await AuthController.updateProfile(
                            UserModel(
                              positionRef: _position!.reference,
                            ),
                          );
                        }
                      } on FirebaseException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message ?? ''),
                            showCloseIcon: true,
                          ),
                        );
                      }
                    } : null,
                    child: loadingButton ?
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )  :
                      const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    profileSubscription.cancel();
    super.dispose();
  }
}
