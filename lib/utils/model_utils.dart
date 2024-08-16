import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModelUtils {
  static const Map<String, IconData> catergoryIconList = {
    "Food": Icons.food_bank,
    "Transportation": Icons.emoji_transportation,
    "Care": Icons.health_and_safety,
    "Entertainment": Icons.shopify,
    "Others": Icons.help_outline_sharp,
  };

  static IconData? getIcon(String category) {
    return catergoryIconList[category];
  }

  static String decimalFormatter(double amount) {
    return NumberFormat('#,###').format(amount);
  }

  static String dateTimeFormatter(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
