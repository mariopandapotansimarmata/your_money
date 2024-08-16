import 'package:your_money_flutter/repository/transaction_repositry.dart';

import '../../../models/transaction_model.dart';

class DetailTransactionViewModel {
  TransactionRepositry _transactionRepositry = TransactionRepositry();

  Stream<TransactionModel> streamDetailTransaction(String docId) async* {
    yield* _transactionRepositry.streamOneData(docId);
  }
}
