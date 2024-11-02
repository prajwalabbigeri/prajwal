import 'package:flutter/material.dart';

import 'bottomnavigation.dart';
import 'home.dart';
import 'homepage.dart';
void main()  {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: ('inter'),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}