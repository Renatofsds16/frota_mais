import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{
  String? _id;
  String? _nome;
  String? _cpf;
  String? _tipoContrato;
  String? _owner;
  String? _regiao;
  String? _rota;
  String? _foto;

  int? _latitude;
  int? _longitude;
  late String _email;
  late String _password;
  String? _tipo;

  Usuario({required email,required password,required nome});
  Usuario.login({required email,required password});
  Usuario.fromMap(DocumentSnapshot<Object?> documentSnapshot){
    nome = documentSnapshot.get('nome');
    email = documentSnapshot.get('email');
    id = documentSnapshot.get('id');
    tipo = documentSnapshot.get('tipo');
    owner = documentSnapshot.get('owner');
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map['id'] = id;
    map['nome'] = nome;
    map['email'] = email;
    map['tipo'] = tipo;
    map['owner'] = owner;
    return map;
  }

  String? get tipo => _tipo;

  set tipo(String? value) {
    _tipo = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  String? get owner => _owner;

  set owner(String? value) {
    _owner = value;
  }

  set email(String value) {
    _email = value;
  }

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  int? get latitude => _latitude;

  set latitude(int? value) {
    _latitude = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  int? get longitude => _longitude;

  set longitude(int? value) {
    _longitude = value;
  }

  String? get rota => _rota;

  set rota(String? value) {
    _rota = value;
  }

  String? get regiao => _regiao;

  set regiao(String? value) {
    _regiao = value;
  }

  String? get tipoContrato => _tipoContrato;

  set tipoContrato(String? value) {
    _tipoContrato = value;
  }

  String? get cpf => _cpf;

  set cpf(String? value) {
    _cpf = value;
  }

  String? get foto => _foto;

  set foto(String? value) {
    _foto = value;
  }
}