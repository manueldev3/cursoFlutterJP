import 'package:cloud_firestore/cloud_firestore.dart';

/// Position model
class PositionModelCreate {
  /// Name for position
  final String name;
  /// Description for position
  final String description;
  /// Status for position
  final bool status;

  /// Constructor
  PositionModelCreate({
    required this.name,
    required this.description,
    required this.status,
  });

  /// Position from document snapshot
  PositionModelCreate.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ):
    name = document.data()!['name'],
    description = document.data()!['description'],
    status = document.data()!['status'];
}

/// Position
class PositionModel extends PositionModelCreate {
  /// Id for position
  final String id;

  /// Constructor
  PositionModel({
    required this.id,
    required super.name,
    required super.description,
    required super.status,
  });

  /// Copy with position Model
  PositionModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? status,
  }) => PositionModel(
    id: id ?? this.id,
    name: name ?? super.name,
    description: description ?? super.description,
    status: status ?? super.status,
  );
}
