import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Private constructor to prevent instantiation from outside
  FirestoreService._();

  // Singleton instance
  static final FirestoreService _instance = FirestoreService._();

  // Factory constructor to provide access to the singleton instance
  factory FirestoreService() => _instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getter to access the Firestore instance
  FirebaseFirestore get firestore => _firestore;
}
