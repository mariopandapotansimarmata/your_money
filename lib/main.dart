import 'package:flutter/material.dart';
import 'package:your_money_flutter/views/assets/material_properties.dart';

import 'screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                accentColor: MaterialProperties.primaryBlueColor,
                backgroundColor: MaterialProperties.whiteTextColor,
                cardColor: MaterialProperties.whiteTextColor)),
        title: 'Flutter Demo',
        home: const Screen());
  }
}
