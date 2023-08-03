import 'package:flutter/material.dart';
import 'package:rest_get_api_custom/ComplexJsonwithPlugin.dart';
import 'package:rest_get_api_custom/ComplexjsonWithoutModel.dart';
import 'package:rest_get_api_custom/GetApiWithoutModel.dart';
import 'package:rest_get_api_custom/VeryComplex.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ComplexJsonWithoutModel()
    );
  }
}


