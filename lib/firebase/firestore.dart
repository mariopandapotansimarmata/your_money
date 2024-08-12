import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  static final Firebase _instance = Firebase._internal();

  factory Firebase() {
    return _instance;
  }

  Firebase._internal() {
    _database = FirebaseFirestore.instance;
  }

  static FirebaseFirestore? _database;

  // Getter to access the Firestore instance
  FirebaseFirestore get database {
    return _database!;
  }
}
