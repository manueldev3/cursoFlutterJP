import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_m4/model/position.dart';

/// User model
class UserModel {
  /// Se define la variable position
  late DocumentReference<Map<String, dynamic>> positionRef;

  /// Constructor
  UserModel({
    required this.positionRef,
  });

  /// UserModel definido desde un documento de firestore
  UserModel.fromDocument(DocumentSnapshot<Object?> document) {
    final Map<String, dynamic> json = document.data()! as Map<String, dynamic>;
    positionRef = json['positionRef'];
  }

  /// User model to json
  Map<String, dynamic> toJson() => <String, dynamic>{
    'positionRef': positionRef
  };

  /// Get position
  Future<PositionModel> get getPosition async {
    final DocumentSnapshot<Map<String, dynamic>> document = await positionRef
    .get();

    return PositionModel.fromDocument(document);
  }
}
