import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller abstract
abstract class Controller<T> {
  /// Get all
  Future<List<T>> getAll();
  /// Create
  Future<T?> create(T data) async => null;
  /// Update
  Future<void> update(T data) async {}
  /// Delete
  Future<void> delete(DocumentReference<Object?> reference) async {}
}
