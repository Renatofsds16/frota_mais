 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../rotas.dart';
import 'help_firebase_firestore.dart';

class HelpFirebaseAuth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<User?> createUserWithEmailPassword(Usuario usuario)async {
    User? user;
    await _auth.createUserWithEmailAndPassword(
        email: usuario.email, password: usuario.password
    ).then((firebaseUser){
      user = firebaseUser.user;
      usuario.id = user?.uid;
      return user;
    });
    return user;

  }
  Future<String?> checkLoggedUser()async{
    String? idUser = _auth.currentUser?.uid;
    String? id;
    if(idUser != null){
      DocumentSnapshot documentSnapshot = await _db
          .collection('user').doc(idUser).get();
      id = documentSnapshot.get('id');
    }
    return id;



  }
  loginUser(BuildContext context,Usuario usuario)async{
    _auth.signInWithEmailAndPassword(
        email: usuario.email, password: usuario.password
    ).then((firebaseUser) async {
      DocumentSnapshot snapshot = await _db.collection('user').doc(firebaseUser.user?.uid).get();
      String? typeUser = snapshot.get('tipo');
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

      }
    }).catchError((e){
      print('***************o erro foi $e ****************************');
    });
  }
  signOut()async{
    await _auth.signOut();
  }
}