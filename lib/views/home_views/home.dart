import 'package:flutter/material.dart';
import 'package:your_money_flutter/views/home_views/home_widgets/expense_card.dart';
import 'package:your_money_flutter/views/home_views/home_widgets/transaction_list.dart';

import '../assets/material_properties.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialProperties.backgroundColor,
      body: const SafeArea(
          child: Column(
        children: [ExpenseCard(), TransactionList()],
      )),
    );
  }
}
