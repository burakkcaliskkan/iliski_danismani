import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for Firestore database operations
/// Handles CRUD operations for relationship status data
class FirestoreService {
  /// Reference to the 'status' collection in Firestore
  final CollectionReference statusCollection = FirebaseFirestore.instance
      .collection('status');

  /// Fetch all relationship statuses from Firestore
  /// Returns a list of status documents with their IDs
  Future<List<Map<String, dynamic>>> fetchStatusList() async {
    final snapshot = await statusCollection.get();
    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }

  /// Add a new relationship status to Firestore
  /// Creates a new document in the 'status' collection
  Future<void> addStatus(Map<String, dynamic> yeniDurum) async {
    await statusCollection.add(yeniDurum);
  }

  /// Update an existing relationship status in Firestore
  /// Updates a specific document by its ID
  Future<void> updateStatus(
    String documentId,
    Map<String, dynamic> guncelDurum,
  ) async {
    await statusCollection.doc(documentId).update(guncelDurum);
  }

  /// Delete a relationship status from Firestore
  /// Removes a specific document by its ID
  Future<void> deleteStatus(String documentId) async {
    await statusCollection.doc(documentId).delete();
  }
}
