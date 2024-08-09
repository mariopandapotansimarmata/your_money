class TransactionModel {
  String? transactionId;
  double? category;
  String? dateTime;
  String? notes;

  TransactionModel(
      this.transactionId, this.category, this.dateTime, this.notes);

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'category': category,
      'dateTime': dateTime,
      'notes': notes,
    };
  }
}
