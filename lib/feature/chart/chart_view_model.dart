import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:your_money_flutter/feature/chart/chart.dart';
import 'package:your_money_flutter/repository/transaction_repositry.dart';
import 'package:your_money_flutter/utils/model_utils.dart';
import '../../repository/chart_repository.dart';
import 'package:excel/excel.dart';

class ChartViewModel {
  final ChartRepository _chartRepo = ChartRepository();
  final TransactionRepositry _transRepo = TransactionRepositry();

  Stream<List<ChartData>> streamPercentage(int days) async* {
    yield* _chartRepo.readChartPercentage(days);
  }

  void createExcel() async {
    Excel excel = Excel.createExcel();
    excel.rename('Sheet1', 'Transactions');
    DateTime now = DateTime.now();
    String dateNow =
        "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";

    Sheet sheetObject = excel['Transactions'];
    List<CellValue> dataList = [
      const TextCellValue('DateTime'),
      const TextCellValue('Category'),
      const TextCellValue('Amount'),
      const TextCellValue('Notes'),
    ];
    sheetObject.insertRowIterables(dataList, 0);

    var transactions = await _transRepo.readAll();

    for (var transaction in transactions) {
      List<CellValue> dataRow = [
        TextCellValue(ModelUtils.dateTimeFormatter(transaction.dateTime!)),
        TextCellValue(transaction.category!),
        DoubleCellValue(transaction.amount!),
        TextCellValue(transaction.notes!),
      ];

      sheetObject.appendRow(dataRow);
    }

    if (Platform.isAndroid) {
      var fileBytes = excel.save();
      try {
        final directory = await getDownloadsDirectory();
        String filePath =
            p.join(directory!.path, 'Transaction Report-$dateNow.xlsx');
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);
        print('File saved at $filePath');
      } catch (e) {
        print('Error saving Excel file: $e');
      }
    } else if (kIsWeb) {
      excel.save(fileName: 'Transaction Report-$dateNow.xlsx');
    }
  }
}
