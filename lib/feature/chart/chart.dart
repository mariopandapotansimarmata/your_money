import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_view_model.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  ChartViewModel _chartVM = ChartViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Container(
          height: 450,
          width: 400,
          child: StreamBuilder(
              stream: _chartVM.streamPercentage(),
              builder: (context, snapshot) {
                print("ini adalah ${snapshot.data}");
                if (!snapshot.hasData) {
                  return const Text("No Data");
                }
                print("ini adalah ${snapshot.data!}");
                return SfCircularChart(
                    title: ChartTitle(
                      text: "Transaction Chart",
                    ),
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
                            return (snapshot.data![index].y / 100).toString();
                          },
                          dataSource: snapshot.data!,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]);
              }),
        )
      ],
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
