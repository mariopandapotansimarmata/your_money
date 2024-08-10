import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_money_flutter/models/transaction_model.dart';

class TransactionRepositry {
  final db = FirebaseFirestore.instance;

  Future<void> add(TransactionModel transaction) async {
    await db.collection("transactions").add(transaction.toMap()).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<List<TransactionModel>> readAll() async {
    try {
      var snapshot = await db.collection("transactions").get();
      var result = snapshot.docs.map((data) {
        return TransactionModel.fromSnapshot(data);
      }).toList();
      print("Fetched transactions: $result");
      return result;
    } catch (e) {
      print("Error fetching transactions: $e");
      return [];
    }
  }
}
