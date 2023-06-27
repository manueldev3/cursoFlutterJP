import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller abstract
mixin Controller<T, K> {
  /// Get all
  Future<List<T>> getAll();
  /// Create
  Future<K> create(T data);
  /// Update
  Future<void> update(T data);
  /// Delete
  Future<void> delete(DocumentReference<Object?> reference);
}
