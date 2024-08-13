import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../feature/chart/chart.dart';
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

  Stream<List<ChartData>> readChartPercentage(int days) async* {
    await for (var snapshot in db
        .collection(transactionField)
        .where("dateTime",
            isGreaterThan: DateTime.now().subtract(Duration(days: days)))
        .snapshots()) {
      double food = 0;
      double transportation = 0;
      double care = 0;
      double entertainment = 0;
      double others = 0;
      for (var doc in snapshot.docs) {
        if (doc.data()["category"] == "Food") {
          food += doc.data()["amount"];
        } else if (doc.data()["category"] == "Transportation") {
          transportation += doc.data()["amount"];
        } else if (doc.data()["category"] == "Care") {
          care += doc.data()["amount"];
        } else if (doc.data()["category"] == "Entertainment") {
          entertainment += doc.data()["amount"];
        } else if (doc.data()["category"] == "Others") {
          others += doc.data()["amount"];
        }
      }
      List<ChartData> chartData = [
        ChartData('Food', food, Colors.blue[300]!),
        ChartData('Transportation', transportation, Colors.red[400]!),
        ChartData('Care', care, Colors.green[400]!),
        ChartData(
            'Entertainment', entertainment, Color.fromRGBO(255, 189, 57, 1)),
        ChartData('Others', others, Colors.grey[700]!)
      ];

      yield chartData;
    }
  }
}
