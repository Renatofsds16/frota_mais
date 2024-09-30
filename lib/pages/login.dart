

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/rotas.dart';

import '../models/usuario.dart';



class Login extends StatefulWidget {


  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? _id;
  final TextEditingController _controllerEmail = TextEditingController(text: 'renatofss16@gmail.com');
  final TextEditingController _controllerSenha = TextEditingController(text: '12345678');
  String? _mensagemError;
  String? _mensagemErrorEmail;
  String? _mensagemErrorSenha;

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
                      errorText: _mensagemErrorEmail,
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
                    errorText: _mensagemErrorSenha,
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
        loginUser(usuario);
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

  loginUser(Usuario usuario)async{
    final navigator = Navigator.of(context);
      _auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password
      ).then((firebaseUser)async{
        User? user = firebaseUser.user;
        DocumentSnapshot snapshot = await _db.collection('user').doc(user?.uid).get();
        String? typeUser = await snapshot.get('tipo');
        print('usuario logado com sucesso');
        if(typeUser != null){
          switch (typeUser){
            case 'empregador':
              navigator.pushNamedAndRemoveUntil(Rotas.homeEmpregador, (context)=>false);
              return;
            case 'funcionario':
              navigator.pushNamedAndRemoveUntil(Rotas.localFuncionario,arguments: usuario,(context)=>false);
              return;
            case 'procurando_emprego':
              navigator.pushNamedAndRemoveUntil(Rotas.homeFilaEspera,(context)=>false);
              return;

          }
        }
      }).catchError((e,strace){
        FirebaseAuthException firibaseErro = e;
        if(firibaseErro.code == 'user-not-found'){
          setState(() {
            _mensagemErrorEmail = 'usuario nao encontrado verifique seu cadastro!';
            _mensagemErrorSenha = null;
          });
        }else if(firibaseErro.code == 'wrong-password'){
          _mensagemErrorSenha = 'A senha esta incorreta';
          _mensagemErrorEmail = null;
        }else if(firibaseErro.code == 'invalid-credential'){
          setState(() {
            _mensagemErrorEmail = null;
            _mensagemErrorSenha = 'Credenciais invalidas verifique email e senha';
          });
        }

      });

  }
  _verificarUsuarioLogado()async{
    User? user = _auth.currentUser;
    DocumentSnapshot snapshot = await _db.collection('user').doc(user?.uid).get();
    String? typeUser = await snapshot.get('tipo');
    if(typeUser != null){
      switch (typeUser){
        case 'empregador':
          Navigator.pushReplacementNamed(context, Rotas.homeEmpregador);
          return;
        case 'funcionario':
          Navigator.pushReplacementNamed(context, Rotas.homeFuncionario);
          return;
        case 'procurando_emprego':
          Navigator.pushReplacementNamed(context, Rotas.homeFilaEspera);
          return;
        default:
          _erroView();
          return;
      }
    }else{
      print('o tipo de usuario e nulo ********************');
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

