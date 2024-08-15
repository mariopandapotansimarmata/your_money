import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:your_money_flutter/assets/profile_icon.dart';
import 'package:your_money_flutter/auth/firebaseauth.dart';
import 'package:your_money_flutter/feature/home/home_view_model/home_view_model.dart';
import 'package:your_money_flutter/repository/utils/model_utils.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key, required this.parentScrollerHeight});
  final double parentScrollerHeight;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double ratio = widget.parentScrollerHeight / 400;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        height: screenHeight * 0.4,
        width: screenWidth,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            color: MaterialProperties.primaryBlueColor,
            borderRadius: BorderRadius.circular(24)),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween, (ratio - 0.25) / (1 - 0.25) * 100
          children: [
            Positioned(
              top: 13,
              // right: (ratio - 0.25) / (0.25) * 100,
              child: Text(
                "Hello, ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: MaterialProperties.whiteTextColor
                        .withOpacity(((ratio - 0.25) / (1 - 0.25)))),
              ),
            ),
            Positioned(
              top: 13,
              right: 50 + (ratio - 0.25) / (0.25) * 35,
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: MaterialProperties.whiteTextColor),
              ),
            ),
            Positioned(
                top: 2,
                right: 0,
                child: InkWell(
                    onTap: () {
                      Auth.logOut();
                    },
                    child: const ProfileIcon())),
            // Text("$screenWidth"),

            Positioned(
              left: (ratio) * 25,
              top: ratio * (screenHeight * 0.12),
              child: SizedBox(
                width: (screenWidth - 105),
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.black)),
                child: Center(
                  child: Text(
                    "Total Expanse",
                    style: TextStyle(
                        fontSize: 16 + (11 * ratio),
                        color: MaterialProperties.whiteTextColor
                            .withOpacity((((ratio - 0.25) / (1 - 0.25))))),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: _homeViewModel.streamTotalExpense(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Positioned.fill(
                  left: (ratio - 0.25) / (0.25) * 18,
                  top: (ratio - 0.25) / (0.25) * 50,
                  child: Text(
                    "Rp ${ModelUtils.decimalFormatter(snapshot.data!)}",
                    style: TextStyle(
                      fontSize: 10 + (36 * ratio),
                      color: MaterialProperties.whiteTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: (ratio - 0.25) / (0.25) * 40,
              top: screenWidth - 135,
              child: Text(
                "Last Transaction",
                style: TextStyle(color: MaterialProperties.whiteTextColor),
              ),
            ),
            StreamBuilder(
                stream: _homeViewModel.streamLastTransaction(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Positioned(
                    left: (ratio - 0.25) / (0.25) * 39,
                    top: 7 + (20 + (ratio - 0.25) / (0.25) * 90),
                    child: Column(
                      children: [
                        Text(
                          "${ModelUtils.dateTimeFormatter(snapshot.data!)}",
                          style: TextStyle(
                              color: MaterialProperties.whiteTextColor),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
