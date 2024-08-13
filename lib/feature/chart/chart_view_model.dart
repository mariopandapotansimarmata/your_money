import 'package:your_money_flutter/feature/chart/chart.dart';

import '../../repository/chart_repository.dart';

class ChartViewModel {
  final ChartRepository _chartRepo = ChartRepository();

  Stream<List<ChartData>> streamPercentage(int days) async* {
    yield* _chartRepo.readChartPercentage(days);
  }
}
