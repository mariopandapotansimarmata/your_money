import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase/firestore.dart';

class ChartRepository {
  FirebaseFirestore db = Firebase().database;
  String transactionField = "transactions";

  Stream<double> readTotalExpense() async* {
    await for (var snapshot in db.collection(transactionField).snapshots()) {
      double result = 0;
      for (var doc in snapshot.docs) {
        result += doc.data()["amount"];
      }

      yield result;
    }
  }

  Stream<DateTime> readLastTransaction() async* {
    await for (var snapshot in db
        .collection(transactionField)
        .orderBy("dateTime", descending: true)
        .limit(1)
        .snapshots()) {
      if (snapshot.docs.isNotEmpty) {
        yield (snapshot.docs.first.data()["dateTime"] as Timestamp).toDate();
      }
    }
  }
}
