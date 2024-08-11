import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_money_flutter/models/transaction_model.dart';

class TransactionRepositry {
  String transactionsField = "transactions";
  final db = FirebaseFirestore.instance;

  Future<void> add(TransactionModel transaction) async {
    await db.collection("transactions").add(transaction.toMap()).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<List<TransactionModel>> readAll() async {
    try {
      var snapshot = await db.collection(transactionsField).get();
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

  Stream<List<TransactionModel>> streamReadAll() async* {
    try {
      await for (var snapshot in db.collection(transactionsField).snapshots()) {
        var result = snapshot.docs.map((data) {
          return TransactionModel.fromSnapshot(data);
        }).toList();
        print("Fetched transactions: $result");
        yield result;
      }
    } catch (e) {
      print("Error fetching transactions: $e");
      yield [];
    }
  }

  void update(TransactionModel transaction) {
    db.collection(transactionsField).doc(transaction.documentId).update({
      "amount": transaction.amount,
      "category": transaction.category,
      "dateTime": transaction.dateTime,
      "notes": transaction.notes
    });
  }
}
