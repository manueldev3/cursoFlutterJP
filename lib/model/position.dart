import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:proyecto_m4/model/collections.dart';

/// Position model
class PositionModel {
  /// Id for position
  final String id;
  /// Name for position
  final String name;
  /// Description for position
  final String description;
  /// Status for position
  final bool status;

  /// Constructor
  PositionModel({
    required this.name,
    required this.description,
    required this.status,
    required this.id,
  });

  /// Position from document snapshot
  PositionModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ):
    id = document.id,
    name = document.data()!['name'],
    description = document.data()!['description'],
    status = document.data()!['status'];

  /// Get reference for this position
  DocumentReference<Map<String, dynamic>> get reference => Collections
      .positions.doc(id);
}
