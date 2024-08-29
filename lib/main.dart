import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frota_mais/pages/login.dart';
import 'package:frota_mais/rotas.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: Rotas.gerarRotas,
    title: 'Frota +',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      useMaterial3: true,
    ),
    home: Login(),
  ));
}