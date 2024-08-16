import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../repository/transaction_repositry.dart';
import '../../utils/overlay_utils.dart';

class FormViewModel {
  final TransactionRepositry _transactionRepositry = TransactionRepositry();
  List<String> catergoryList = [
    "Food",
    "Transportation",
    "Care",
    "Entertainment",
    "Others"
  ];
  void addTransaction(
    BuildContext context,
    TextEditingController amountController,
    TextEditingController categoryController,
    TextEditingController dateTimeController,
    TextEditingController notesController,
  ) {
    if (amountController.text == "") {
      amountController.text = "0";
    }
    if (categoryController.text == "") {
      categoryController.text = "Food";
    }
    _transactionRepositry.add(TransactionModel(
        amount: double.parse(amountController.text.replaceAll(RegExp(','), '')),
        category: categoryController.text,
        dateTime: DateTime.parse(dateTimeController.text),
        notes: notesController.text));

    OverlayUtils.showOverlay(context, "Saving transaction", action: () async {
      Navigator.pop(context);
    });
  }

  void editTransaction(
    BuildContext context,
    String documentId,
    TextEditingController amountController,
    TextEditingController categoryController,
    TextEditingController dateTimeController,
    TextEditingController notesController,
  ) {
    if (amountController.text == "") {
      amountController.text = "0";
    }
    if (categoryController.text == "") {
      categoryController.text = "Food";
    }
    _transactionRepositry.update(TransactionModel(
        documentId: documentId,
        amount: double.parse(amountController.text.replaceAll(RegExp(','), '')),
        category: categoryController.text,
        dateTime: DateTime.parse(dateTimeController.text),
        notes: notesController.text));

    OverlayUtils.showOverlay(context, "Saving transaction", action: () async {
      Navigator.pop(context);
    });
  }
}
