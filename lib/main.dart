import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your_money_flutter/assets/material_properties.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:your_money_flutter/auth/auth_view.dart';
import 'auth/firebaseauth.dart';
import 'firebase/firebase_options.dart';
import 'screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode('en');
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                accentColor: MaterialProperties.primaryBlueColor,
                backgroundColor: MaterialProperties.whiteTextColor,
                cardColor: MaterialProperties.whiteTextColor)),
        title: 'Flutter Demo',
        home: StreamBuilder(
            stream: Auth.StreamIsLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return const Screen();
              } else {
                return const AuthView();
              }
            }));
  }
}
