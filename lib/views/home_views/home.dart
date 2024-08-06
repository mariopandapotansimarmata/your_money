import 'package:flutter/material.dart';
import 'package:your_money_flutter/views/home_views/home_widgets/expense_card.dart';
import '../assets/material_properties.dart';
import 'home_widgets/transaction_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _containerHeight = 100.0; // Initial height of the container
  final ScrollController _scrollController = ScrollController();
  bool _isScrollable = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    print(_scrollController.offset);
    if (_scrollController.offset == 0) {
      _containerHeight = 100.1;
      setState(() {
        _isScrollable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MaterialProperties.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            setState(() {
              _containerHeight += details.delta.dy;
              if (_containerHeight > 400) {
                _containerHeight = 400;
              }
              if (_containerHeight < 100) {
                _containerHeight = 100;
              }
              _isScrollable = _containerHeight == 100;
            });
          },
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: _containerHeight,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      child: ExpenseCard(
                        parentScrollerHeight: _containerHeight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                height: (screenHeight * 0.85) - _containerHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: MaterialProperties.whiteBackgroundColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Transaction",
                      style: TextStyle(
                        color: MaterialProperties.blackTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      height: (screenHeight * 0.78) - _containerHeight,
                      child: ListView.builder(
                        controller: _isScrollable ? _scrollController : null,
                        physics: _isScrollable
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: TransactionCard(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
