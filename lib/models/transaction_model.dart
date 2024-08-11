import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? documentId;
  double? amount;
  String? category;
  DateTime? dateTime;
  String? notes;

  TransactionModel(
      {this.documentId = "",
      this.amount,
      this.category,
      this.dateTime,
      this.notes});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'dateTime': dateTime,
      'notes': notes,
    };
  }

  factory TransactionModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> docs) {
    return TransactionModel(
        documentId: docs.id,
        amount: docs.data()["amount"],
        category: docs.data()["category"],
        dateTime: (docs.data()["dateTime"] as Timestamp).toDate(),
        notes: docs.data()["notes"]);
  }
}
