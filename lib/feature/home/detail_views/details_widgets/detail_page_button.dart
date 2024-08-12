import 'package:flutter/material.dart';
import 'package:your_money_flutter/repository/transaction_repositry.dart';

import '../../../../assets/material_properties.dart';

class DetailPageButton extends StatelessWidget {
  const DetailPageButton(
      {super.key,
      this.transactionId,
      required this.text,
      required this.icon,
      required this.backgroundColor,
      this.page = const Placeholder()});

  final String? transactionId;
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    TransactionRepositry vm = TransactionRepositry();
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
            onPressed: () {
              if (transactionId != null) {
                vm.delete(transactionId!);
                Navigator.pop(context);
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return page;
                  },
                ));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: MaterialProperties.whiteTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text,
                  style: TextStyle(color: MaterialProperties.whiteTextColor),
                ),
              ],
            )));
  }
}
