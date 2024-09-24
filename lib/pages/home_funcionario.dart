import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeFuncionario extends StatefulWidget {
  const HomeFuncionario({super.key});

  @override
  State<HomeFuncionario> createState() => _HomeFuncionarioState();
}

class _HomeFuncionarioState extends State<HomeFuncionario> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> _options = ['Manutencao', 'Sair'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('funcionario'),
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
      body:const Center(
        child: Text('funcionario'),
      ),
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
  _exit()async{
    await _auth.signOut();
  }
}
