import 'package:flutter/material.dart';
/*import 'package:uber_flutter/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';*/


class Login extends StatelessWidget {

  /*final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _db = FirebaseFirestore.instance;*/
  final TextEditingController _controllerEmail = TextEditingController(text: 'renatofss16@gmail.com');
  final TextEditingController _controllerSenha = TextEditingController(text: '12345678');
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () {},
                        child: const Text('Entrar'),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  _loginUser();
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
  _loginUser(){

  }

}

