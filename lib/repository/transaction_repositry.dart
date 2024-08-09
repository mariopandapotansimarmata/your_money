import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_money_flutter/models/transaction_model.dart';

class TransactionRepositry {
  final db = FirebaseFirestore.instance;

  TransactionModel dump =
      TransactionModel("transactionId", 23.0, "dateTime", "notes");

  Future<void> add() async {
    await db.collection("transactions").add(dump.toMap()).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
