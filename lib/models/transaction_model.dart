import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  double? amount;
  String? category;
  DateTime? dateTime;
  String? notes;

  TransactionModel(this.amount, this.category, this.dateTime, this.notes);

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
    return TransactionModel(docs.data()["amount"], docs.data()["category"],
        (docs.data()["dateTime"] as Timestamp).toDate(), docs.data()["notes"]);
  }
}
