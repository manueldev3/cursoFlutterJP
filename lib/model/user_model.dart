import 'package:cloud_firestore/cloud_firestore.dart';

/// User model
class UserModel {
  /// Referencia del document de la compañia a la que pertenece
  late DocumentReference<Object?> companyRef;

  /// Constructor
  UserModel({
    required this.companyRef,
  });

  /// UserModel definido desde un documento de firestore
  UserModel.fromDocument(DocumentSnapshot<Object?> document) {
    final Map<String, dynamic> json = document.data()! as Map<String, dynamic>;
    companyRef = json['companyRef'];
  }
}
