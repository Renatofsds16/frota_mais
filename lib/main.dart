import 'package:flutter/material.dart';
import 'package:frota_mais/pages/home.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Frota +',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      useMaterial3: true,
    ),
    home: const Home(),
  ));
}