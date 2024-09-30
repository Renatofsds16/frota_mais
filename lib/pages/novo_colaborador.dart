
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/models/usuario.dart';

class NovoColaborador extends StatefulWidget {
  Map<String,dynamic>? usuario;
  NovoColaborador({super.key,required this.usuario});

  @override
  State<NovoColaborador> createState() => _NovoColaboradorState();
}

class _NovoColaboradorState extends State<NovoColaborador> {
  final String? _idUsuarioLogado = FirebaseAuth.instance.currentUser?.uid;
  Usuario? _usuarioSelecionado;

  @override
  void initState() {
    _usuarioSelecionado = widget.usuario?['user'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Novo colaborador'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                ),
                Text('${_usuarioSelecionado?.nome.toString()}')

              ],
            )
          ],
        ),
      ),
    );
  }
}
