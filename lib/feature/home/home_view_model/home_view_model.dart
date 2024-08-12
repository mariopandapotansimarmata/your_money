import 'package:your_money_flutter/repository/transaction_repositry.dart';

import '../../../models/transaction_model.dart';

class HomeViewModel {
  final TransactionRepositry _transactionRepo = TransactionRepositry();

  Stream<List<TransactionModel>> streamAllTransaction() async* {
    yield* _transactionRepo.streamReadAll();
  }
}
