import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/ciruclar_icon.dart';
import 'package:your_money_flutter/models/transaction_model.dart';
import 'package:intl/intl.dart';
import '../../../assets/material_properties.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('dd/MM/yyyy HH:mm').format(transaction.dateTime!);
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 65,
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MaterialProperties.transactionWhiteColor,
          border: Border.all(color: MaterialProperties.transactionBorderColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TranscIcon(
                icon: Icons.food_bank,
                color: MaterialProperties.primaryBlueColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${transaction.notes}",
                      style: const TextStyle(fontSize: 16)),
                  Text(formattedDateTime, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Text(
            "Rp ${transaction.amount}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
