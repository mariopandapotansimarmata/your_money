import 'package:your_money_flutter/models/transaction_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<TransactionModel> transactions;

  HomeLoaded(this.transactions);
}
