import 'package:flutter/material.dart';
import 'package:your_money_flutter/views/assets/material_properties.dart';
import 'package:your_money_flutter/views/assets/profile_icon.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        height: screenHeight * 0.4,
        width: screenWidth,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            color: MaterialProperties.primaryBlueColor,
            borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello, Mario Pandapotan S",
                  style: TextStyle(
                      fontSize: 16, color: MaterialProperties.whiteTextColor),
                ),
                const ProfileIcon()
              ],
            ),
            Column(
              children: [
                Text(
                  "Total Expense",
                  style: TextStyle(
                      fontSize: 25, color: MaterialProperties.whiteTextColor),
                ),
                Text(
                  "Rp 850.000",
                  style: TextStyle(
                      fontSize: 51,
                      fontWeight: FontWeight.bold,
                      color: MaterialProperties.whiteTextColor),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Last Transaction",
                  style: TextStyle(color: MaterialProperties.whiteTextColor),
                ),
                Text(
                  "13 July 2024",
                  style: TextStyle(color: MaterialProperties.whiteTextColor),
                ),
              ],
            ),
            Icon(
              Icons.arrow_drop_up,
              color: MaterialProperties.whiteTextColor,
            )
          ],
        ));
  }
}
