import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_money_flutter/auth/firebaseauth.dart';
import 'package:your_money_flutter/models/transaction_model.dart';

class TransactionRepositry {
  String transactionsField = "transactions";
  String usersField = "users";
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<User?> currentUserStream = Auth.streamIsLoggedIn();

  Future<void> add(TransactionModel transaction) async {
    User? currentUser = await currentUserStream.first;

    if (currentUser != null) {
      try {
        DocumentReference doc = await db
            .collection(usersField)
            .doc(currentUser.uid)
            .collection(transactionsField)
            .add(transaction.toMap());
        print('DocumentSnapshot added with ID: ${doc.id}');
      } catch (e) {
        print('Error adding document: $e');
      }
    } else {
      print('No user is currently logged in.');
    }
  }

  Future<List<TransactionModel>> readAll() async {
    User? currentUser = await currentUserStream.first;

    try {
      var snapshot = await db
          .collection(usersField)
          .doc(currentUser!.uid)
          .collection(transactionsField)
          .get();
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
    User? currentUser = await currentUserStream.first;

    try {
      await for (var snapshot in db
          .collection(usersField)
          .doc(currentUser!.uid)
          .collection(transactionsField)
          .snapshots()) {
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

  void update(TransactionModel transaction) async {
    User? currentUser = await currentUserStream.first;

    db
        .collection(usersField)
        .doc(currentUser!.uid)
        .collection(transactionsField)
        .doc(transaction.documentId)
        .update({
      "amount": transaction.amount,
      "category": transaction.category,
      "dateTime": transaction.dateTime,
      "notes": transaction.notes
    });
  }

  Future<void> delete(String documentId) async {
    User? currentUser = await currentUserStream.first;

    return db
        .collection(usersField)
        .doc(currentUser!.uid)
        .collection(transactionsField)
        .doc(documentId)
        .delete();
  }
}
