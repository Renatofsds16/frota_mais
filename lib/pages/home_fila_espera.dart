import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/models/usuario.dart';
import 'package:frota_mais/widgets/show_list.dart';

import '../rotas.dart';
import '../widgets/loading_data.dart';

class HomeFilaEspera extends StatefulWidget {
  const HomeFilaEspera({super.key});

  @override
  State<HomeFilaEspera> createState() => _HomeFilaEsperaState();
}

class _HomeFilaEsperaState extends State<HomeFilaEspera> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? _idUsuarioLogado = FirebaseAuth.instance.currentUser?.uid;

  final List<String> _options = ['Manutencao', 'Sair'];
  final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<List<Usuario>> _recuperarColaboradoresDisponives()async{
     List<Usuario> lista = [];
     Usuario? usuario;
     Query query = _db.collection('user').where('tipo',isEqualTo: 'procurando_emprego');
     QuerySnapshot querySnapshot = await query.get();
     for(DocumentSnapshot item in querySnapshot.docs){
       usuario = Usuario.fromMap(item);
       lista.add(usuario);
     }

     return lista;

   }

  @override
  Widget build(BuildContext context) {
    _recuperarColaboradoresDisponives();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabalhadore disponiveis'),
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton<String>(
              onSelected: _selectUser,
              itemBuilder: (context) {
                return _options.map((String option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              }),
        ],
      ),
      body: ShowList(future: _recuperarColaboradoresDisponives, idUsuarioLogado: _idUsuarioLogado,),
    );
  }
  _selectUser(String value) async {
    switch (value) {
      case 'Manutencao':
        break;
      case 'Sair':
        _exit();
        break;
    }
  }
  _exit()async {
    final navigator = Navigator.of(context);
    await _auth.signOut();
    navigator.pushNamedAndRemoveUntil(Rotas.login, (context) => false);
  }
}
