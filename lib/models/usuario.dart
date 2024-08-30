class Usuario{
  String? _id;
  String? _nome;
  late String _email;
  late String _password;
  String? _tipo;

  Usuario({required email,required password,required nome});
  Usuario.login({required email,required password});



  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map['id'] = id;
    map['nome'] = nome;
    map['email'] = email;
    map['tipo'] = tipo;
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

  set email(String value) {
    _email = value;
  }

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }
}