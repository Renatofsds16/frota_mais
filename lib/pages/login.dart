import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../help_firebase/help_firebase_auth.dart';
import '../models/usuario.dart';



class Login extends StatefulWidget {


  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final HelpFirebaseAuth _auth = HelpFirebaseAuth();
  String? _id;
  final TextEditingController _controllerEmail = TextEditingController(text: 'renatofss16@gmail.com');
  final TextEditingController _controllerSenha = TextEditingController(text: '12345678');
  String? _mensagemError;

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'E-mail',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: _controllerSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: ElevatedButton(
                        onPressed: _validarCampos,
                        child: const Text('Entrar'),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: const Text('Nao tem conta? cadastre-se'),
              )

            ],
          ),
        ),
      ),
    );
  }
  _validarCampos(){

    String email = _controllerEmail.text;
    String password = _controllerSenha.text;

    if(email.isNotEmpty && email.contains('@gmail.com')){
      if(password.isNotEmpty && password.length>=6){
        Usuario usuario = Usuario.login(email: email,password: password);
        usuario.email = email;
        usuario. password = password;
        _loginUser(usuario);
      }else{
        setState(() {
          _mensagemError = 'sua senha deve conter pelo menos 6 caractere';
        });
      }

    }else{
      setState(() {
        _mensagemError = 'Digite seu email: Exemple@gmail.com.';
      });
    }

  }

  _loginUser(Usuario usuario){
    _auth.loginUser(context,usuario);
  }
  _verificarUsuarioLogado()async{
    _id = await _auth.checkLoggedUser();
    if(_id != null){
      Navigator.pushNamedAndRemoveUntil(context, '/home', (context)=> false);
    }
  }
}

