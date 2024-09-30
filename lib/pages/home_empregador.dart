import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frota_mais/models/empregador.dart';
import 'package:frota_mais/models/usuario.dart';
import 'package:frota_mais/widgets/show_list.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/help_firebase/help_firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeEmpregador extends StatefulWidget {
  Map<String, dynamic> user;
  HomeEmpregador({super.key, required this.user});

  @override
  State<HomeEmpregador> createState() => _HomeEmpregadorState();
}

class _HomeEmpregadorState extends State<HomeEmpregador> {
  final FirebaseAuth _user = FirebaseAuth.instance;
  String? _idUsuario;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Usuario? _usuario;

  final HelpFirebaseAuth _auth = HelpFirebaseAuth();
  final List<String> _options = ['Manutencao', 'Sair', 'novo motorista'];

  @override
  void initState() {
    _verificarTipoUsuario();
    _requestPemision();
    super.initState();
  }

  _verificarTipoUsuario() async {
    _usuario = widget.user['user'];
    if (_usuario != null && _usuario?.tipo == 'empregador') {
      _idUsuario = _usuario?.id;
    } else {
      User? user = _user.currentUser;
      _idUsuario = user?.uid;
    }
  }

  Future<List<Usuario>> _recuperarListaFuncionaio() async {

    List<Usuario> lista = [];
      Query<Map<String, dynamic>> query =
      _db.collection('user').where('owner', isEqualTo: _idUsuario);
      QuerySnapshot querySnapshot = await query.get();
      for (DocumentSnapshot item in querySnapshot.docs) {
        Usuario usuario = Usuario.fromMap(item);
        lista.add(usuario);
      }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus Funcionarios'),
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
      body: ShowList(future: _recuperarListaFuncionaio, idUsuarioLogado: _idUsuario,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _showAlertDialog,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selecionar novo colaborador'),
            content: const Text('Um ja existem ou novo?'),
            actions: [
              Row(
                children: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);

                  }, child: const Text('cancelar')),

                  TextButton(onPressed: () {
                    Navigator.pushNamed(context,'/home_fila_espera');
                  }, child: const Text('Ja existente')),

                ],
              )
            ],
          );
        });
  }

  _selectUser(String value) async {
    switch (value) {
      case 'Manutencao':
        break;
      case 'novo motorista':
        break;
      case 'Sair':
        _logofUser();
        break;
    }
  }

  _logofUser() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  _requestPemision() async {
    bool? servideEnabled;
    LocationPermission? locationPermission;
    servideEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servideEnabled) {
      return Future.error('Os serviços de localizacao estao desabilitado');
    }
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return Future.error('voce nao tem permisao');
    }
    if (locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('sua permisao foi totalmente negada');
    }
    return await Geolocator.getCurrentPosition();
  }
}
