import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:your_money_flutter/feature/home/home_widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        height: screenHeight * 0.45,
        width: screenWidth,
        decoration: BoxDecoration(
            color: MaterialProperties.whiteBackgroundColor,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height * 0.42,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    "Recent Transaction",
                    style: TextStyle(
                        color: MaterialProperties.blackTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: TransactionCard(),
                  );
                }
              },
            ),
          )
        ]));
  }
}
