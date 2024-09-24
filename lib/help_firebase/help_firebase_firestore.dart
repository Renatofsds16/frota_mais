import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frota_mais/models/usuario.dart';

import 'help_firebase_auth.dart';

class HelpFirebaseFirestore{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final HelpFirebaseAuth _auth = HelpFirebaseAuth();

  collectionUser(Usuario user)async{
    _db.collection('user')
        .doc(user.id)
        .set(user.toMap());
  }
  Future<String?> getTypeUse() async{
    String? idUser = await _auth.checkLoggedUser();
    String? type;
    if(idUser != null){
      DocumentSnapshot documentSnapshot = await _db
          .collection('user')
          .doc(idUser)
          .get();
      type = await documentSnapshot.get('tipo');
    }
    return type;
  }
}