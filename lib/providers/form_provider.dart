import 'package:flutter_riverpod/flutter_riverpod.dart';

///Funcion para poder ver/ocultar password (es global)
final StateProvider<bool> hidePasswordProvider = StateProvider<bool>(
  (StateProviderRef<bool> ref) => true,
);

///Funcio para poder ver/ocultar el loading del botton
final StateProvider<bool> loadingButtonProvider = StateProvider<bool>(
  (StateProviderRef<bool> ref) => false,
);
