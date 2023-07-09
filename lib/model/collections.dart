import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore Collections
class Collections {
  Collections._();

  /// Collection path for positions
  static CollectionReference<Map<String, dynamic>> positions =
    FirebaseFirestore.instance.collection('positions');
  /// Collection path for users
  static CollectionReference<Map<String, dynamic>> users =
  FirebaseFirestore.instance.collection('users');
}
