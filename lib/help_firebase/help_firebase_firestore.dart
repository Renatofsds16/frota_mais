import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frota_mais/models/usuario.dart';

class HelpFirebaseFirestore{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  collectionUser(Usuario user)async{
    _db.collection('user')
        .doc(user.id)
        .set(user.toMap());
  }
}