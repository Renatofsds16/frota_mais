import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/models/usuario.dart';
import 'package:frota_mais/pages/cadastro.dart';
import 'package:frota_mais/pages/details.dart';
import 'package:frota_mais/pages/home_empregador.dart';
import 'package:frota_mais/pages/home_fila_espera.dart';
import 'package:frota_mais/pages/home_funcionario.dart';
import 'package:frota_mais/pages/local_funcionario.dart';
import 'package:frota_mais/pages/login.dart';
import 'package:frota_mais/pages/novo_colaborador.dart';


class Rotas{
  static const String loginBarra = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String homeEmpregador = '/home_empregador';
  static const String homeFilaEspera = '/home_fila_espera';
  static const String homeFuncionario = '/home_funcionario';
  static const String localFuncionario = '/localFuncionario';
  static const String novoColaborador = '/novoColaborador';
  static const String details = '/details';

  static Route<dynamic> gerarRotas(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case loginBarra:
        return MaterialPageRoute(builder: (_)=> Login());
      case login:
        return MaterialPageRoute(builder: (_)=> Login());
      case cadastro:
        return MaterialPageRoute(builder: (_)=> const Cadastro());
      case homeEmpregador:
        return MaterialPageRoute(builder: (_)=> HomeEmpregador(user: {'user':args},));
      case homeFilaEspera:
        return MaterialPageRoute(builder: (_)=> const HomeFilaEspera());
      case homeFuncionario:
        return MaterialPageRoute(builder: (_)=> const HomeFuncionario());
      case localFuncionario:
        return MaterialPageRoute(builder: (_)=> LocalFuncionario(usuario: {'usuario':args},));
      case novoColaborador:
        return MaterialPageRoute(builder: (_)=> NovoColaborador(usuario: {'user':args},));
      case details:
        return MaterialPageRoute(builder: (_)=> Details(usuario: {'user':args},));

      default:
        return MaterialPageRoute(builder: (_)=> _erroView());
    }

  }
  static Widget _erroView(){
    return Scaffold(
      appBar: AppBar(title: const Text('Tela nao encotrada'),backgroundColor: Colors.deepOrange,),
      body: const Center(
        child: Text('Tela nao encontrada!'),
      ),
    );
  }
}

