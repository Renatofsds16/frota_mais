 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    ).then((firebaseUser){
      if(firebaseUser.user != null){
        Navigator.pushReplacementNamed(context, '/home');
      }
    }).catchError((e){
      print('***************o erro foi $e ****************************');
    });
  }
  signOut()async{
    await _auth.signOut();
  }
}