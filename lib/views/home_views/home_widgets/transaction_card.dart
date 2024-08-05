import 'package:flutter/material.dart';
import 'package:your_money_flutter/views/assets/ciruclar_icon.dart';

import '../../assets/material_properties.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Makan Malam", style: TextStyle(fontSize: 16)),
                  Text("13/06/ 2024", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const Text(
            "RP 25.000",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
