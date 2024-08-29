class Usuario{
  String? id;
  String? nome;
  String email;
  String password;
  String? tipo;
  Usuario({required this.email,required this.password,this.nome = '',this.tipo = ''});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    return map;
  }
}