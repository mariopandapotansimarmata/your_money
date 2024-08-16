import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/ciruclar_icon.dart';
import 'package:your_money_flutter/feature/home/detail_views/detail_transaction.dart';
import 'package:your_money_flutter/models/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:your_money_flutter/utils/model_utils.dart';
import '../../../assets/material_properties.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionModel transaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('dd/MM/yyyy HH:mm').format(widget.transaction.dateTime!);
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailTransaction(
              transaction: widget.transaction,
            );
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        width: screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MaterialProperties.transactionWhiteColor,
            border:
                Border.all(color: MaterialProperties.transactionBorderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  TranscIcon(
                    icon: ModelUtils.getIcon(widget.transaction.category!)!,
                    color: MaterialProperties.primaryBlueColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.transaction.notes}",
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          formattedDateTime,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
                "Rp ${ModelUtils.decimalFormatter(widget.transaction.amount!)}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
