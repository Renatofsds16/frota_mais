import 'package:flutter/material.dart';
import 'package:frota_mais/pages/cadastro.dart';
import 'package:frota_mais/pages/home.dart';
import 'package:frota_mais/pages/login.dart';


class Rotas{

  static Route<dynamic> gerarRotas(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> Login());
      case '/login':
        return MaterialPageRoute(builder: (_)=> Login());
      case '/cadastro':
        return MaterialPageRoute(builder: (_)=> const Cadastro());
      case '/home':
        return MaterialPageRoute(builder: (_)=> const Home());

      default:
        return MaterialPageRoute(builder: (_)=> const Home());
    }
  }
}