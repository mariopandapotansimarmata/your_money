import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'chart_view_model.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  ChartViewModel _chartVM = ChartViewModel();
  final Map<String, int> items = {
    'Week': 7,
    'Month': 30,
    '3 Months': 90,
  };

  String? selectedValue;

  @override
  void initState() {
    selectedValue = "Week";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: MaterialProperties.primaryBlueColor,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              height: 60,
              child: Text(
                "Chart",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MaterialProperties.whiteTextColor),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            // margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: MaterialProperties.transactionBorderColor)),
            height: 480,
            width: 400,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.display_settings),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          items: items.keys
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 120,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: MaterialProperties.primaryBlueColor,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: IconStyleData(
                            openMenuIcon: const Icon(
                              Icons.keyboard_arrow_up,
                              size: 25,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                            ),
                            iconSize: 14,
                            iconEnabledColor: MaterialProperties.whiteTextColor,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: MaterialProperties.primaryBlueColor,
                            ),
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: WidgetStateProperty.all(6),
                              thumbVisibility: WidgetStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: StreamBuilder(
                      stream: _chartVM.streamPercentage(items[selectedValue]!),
                      builder: (context, snapshot) {
                        print("ini adalah ${snapshot.data}");
                        if (!snapshot.hasData) {
                          return const Text("No Data");
                        }
                        print("ini adalah ${snapshot.data!}");
                        return SfCircularChart(
                            margin: const EdgeInsets.all(0),
                            // title: ChartTitle(
                            //     text: "Transaction Chart",
                            //     textStyle: Theme.of(context).textTheme.titleMedium),
                            legend: Legend(
                                alignment: ChartAlignment.center,
                                isResponsive: true,
                                overflowMode: LegendItemOverflowMode.scroll,
                                position: LegendPosition.bottom,
                                isVisible: true,
                                title: LegendTitle(text: "Transaction Chart")),
                            series: <CircularSeries>[
                              // Renders doughnut chart
                              DoughnutSeries<ChartData, String>(
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true),
                                  dataLabelMapper: (datum, index) {
                                    return (snapshot.data![index].y / 100)
                                        .toString();
                                  },
                                  dataSource: snapshot.data!,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ]);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  double y;
  final Color color;

  set valueSet(double newValeu) {
    y = newValeu;
  }
}