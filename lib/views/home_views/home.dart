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
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 400,
            child: ResizableContainer(),
          ),
          TransactionList()
        ],
      )),
    );
  }
}

class ResizableContainer extends StatefulWidget {
  const ResizableContainer({super.key});

  @override
  State<ResizableContainer> createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double _containerHeight = 100.0; // Initial height of the container

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: _containerHeight,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                      child: ExpenseCard(
                    parentScrollerHeight: _containerHeight,
                  )),
                  Positioned(
                    bottom: 10,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        setState(() {
                          _containerHeight += details.delta.dy;
                          if (_containerHeight > 400) {
                            _containerHeight = 400;
                          }
                          if (_containerHeight < 100) {
                            _containerHeight = 100;
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40.0,
                        color: Colors.red.withOpacity(0),
                        child: const Center(
                          child:
                              Icon(Icons.drag_handle, color: Color(0xffFFFFFF)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
