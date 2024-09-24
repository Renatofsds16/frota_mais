import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../help_firebase/help_firebase_firestore.dart';
import '../models/usuario.dart';
import '../rotas.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? _typeUser;
  final String _empregador = 'empregador';
  final String _funcionario = 'funcionario';
  final String _procurandoEmprego = 'procurando_emprego';
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controllerNome =
      TextEditingController(text: 'Renato');
  final TextEditingController _controllerEmail =
      TextEditingController(text: 'renatofss16@gmail.com');
  final TextEditingController _controllerSenha =
      TextEditingController(text: '12345678');
  String _mensagemError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  controller: _controllerNome,
                  decoration: InputDecoration(
                      hintText: 'Digite seu nome',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Digite seu email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Column(
                  children: [
                    RadioListTile(
                        title: const Text('Empregador'),
                        subtitle: const Text(
                            'Selecione esta opção se você criar uma nova frota'),
                        value: _empregador,
                        groupValue: _typeUser,
                        onChanged: (String? value) {
                          setState(() {
                            _typeUser = value;
                          });
                          print(_typeUser);
                        }),
                    RadioListTile(
                        title: const Text('Funcionario'),
                        subtitle: const Text(
                            'Selecione esta opção se você vai trabalhar em uma frota'),
                        value: _funcionario,
                        groupValue: _typeUser,
                        onChanged: (String? value) {
                          setState(() {
                            _typeUser = value;
                          });
                          print(_typeUser);
                        }),
                    RadioListTile(
                        title: const Text('Procurando emprego'),
                        subtitle: const Text(
                            'Selecione esta opção se você esta procurando onde trabalha  ou ficar na lista de espera'),
                        value: _procurandoEmprego,
                        groupValue: _typeUser,
                        onChanged: (String? value) {
                          setState(() {
                            _typeUser = value;
                          });
                          print(_typeUser);
                        }),
                  ],
                ),
              ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    _validarCampos();
                  },
                  child: const Text('Salvar'),
                )),
              ]),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  _mensagemError,
                  style: const TextStyle(color: Colors.red, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String password = _controllerSenha.text;

    if (_typeUser != null) {
      if (nome.isNotEmpty) {
        if (email.isNotEmpty && email.contains('@gmail.com')) {
          if (password.isNotEmpty && password.length >= 6) {
            Usuario usuario =
                Usuario(nome: nome, email: email, password: password);
            usuario.nome = nome;
            usuario.email = email;
            usuario.password = password;
            usuario.tipo = _typeUser;
            _cadastraUsuario(usuario);
          } else {
            setState(() {
              _mensagemError = 'sua senha deve conter pelo menos 6 caractere';
            });
          }
        } else {
          setState(() {
            _mensagemError = 'Digite seu email: Exemple@gmail.com.';
          });
        }
      } else {
        setState(() {
          _mensagemError = 'Por favor! Preencha o nome.';
        });
      }
    } else {
      setState(() {
        _mensagemError = 'Selecione uma das opções acima';
      });
    }
  }

  _cadastraUsuario(Usuario usuario) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.password)
        .then((firebaseUser) async {
      _user = firebaseUser.user;
      String? id = _user?.uid;
      if (id != null) {
        usuario.id = id;
        usuario.tipo = _typeUser;
        await _db
            .collection('user')
            .doc(usuario.id)
            .set(usuario.toMap());
        switch (usuario.tipo) {
          case 'empregador':
            Navigator.pushReplacementNamed(context, Rotas.homeEmpregador,arguments: usuario);
            return;
          case 'funcionario':
            Navigator.pushReplacementNamed(context, Rotas.homeFuncionario);
            return;
          case 'procurando_emprego':
            Navigator.pushReplacementNamed(context, Rotas.homeFilaEspera);
            return;
        }
      }
    });
  }
}
