import 'package:your_money_flutter/repository/chart_repository.dart';
import 'package:your_money_flutter/repository/transaction_repositry.dart';

import '../../../models/transaction_model.dart';

class HomeViewModel {
  final TransactionRepositry _transactionRepo = TransactionRepositry();
  final ChartRepository _chartRepo = ChartRepository();

  Stream<List<TransactionModel>> streamAllTransaction() async* {
    yield* _transactionRepo.streamReadAll();
  }

  Stream<double> streamTotalExpense() async* {
    yield* _chartRepo.readTotalExpense();
  }

  Stream<DateTime> streamLastTransaction() async* {
    yield* _chartRepo.readLastTransaction();
  }
}
