import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_m4/model/user_model.dart';

/// User provider
class UserNotifier extends StateNotifier<UserModel?> {
  /// Constructor
  UserNotifier() : super(null);

  /// Si el documento existe lo obtenemos
  Future<void> getUserDocument(String? uid) async {
    if (uid != null) {
      final DocumentSnapshot<Map<String, dynamic>> userDocument =
      await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDocument.exists) {
        state = UserModel.fromDocument(userDocument);
      } else {
        state = null;
      }
    }
  }
}

/// User notifier provider
final StateNotifierProvider<UserNotifier, UserModel?> userNotifierProvider =
StateNotifierProvider<UserNotifier, UserModel?>(
  (StateNotifierProviderRef<UserNotifier, UserModel?> ref) => UserNotifier(),
);
