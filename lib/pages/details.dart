
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/models/usuario.dart';
import 'package:frota_mais/rotas.dart';

class Details extends StatefulWidget {
  Map<String, dynamic>? args;
  Details({super.key, required this.args});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String? _cnpjUsuarioLogado;
  Usuario? _usuario;
  User? _usuaioLogado;
  String textoBotao = 'exibir local';

  @override
  void initState() {
    _verificarUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('${_usuario?.nome}'),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          Container(
                            width: (width * 0.25),
                            height: (width * 0.30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://i.pinimg.com/originals/73/14/cc/7314cc1a88bf3cdc48347ab186e12e81.jpg'))),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8,right: 0),
                                child: Container(
                                  width: (width * 0.65  ),
                                  height: (width * 0.30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(' ${_usuario?.nome}',style: const TextStyle(fontSize: 20),),
                                      const Text(' 83986560141',style: TextStyle(fontSize: 20),),
                                      Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text('${_usuario?.email}')
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: (){
                                      print('configuracoes');
                                    },
                                      child: const Icon(Icons.settings,size: 40,)
                                  )
                              ),
                            ],
                          ),

                        ],

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: AlignmentDirectional.topStart,
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('situacao: ${_usuario?.tipo}',style: const TextStyle(fontSize: 18),),
                          Text('situacao: ${_usuario?.cnpj}',style: const TextStyle(fontSize: 18),),
                          Text('regiao: ${_usuario?.regiao}',style: const TextStyle(fontSize: 18)),
                          Text('rota: ${_usuario?.rota}',style: const TextStyle(fontSize: 18)),
                          Text('tipo de contrato: ${_usuario?.tipoContrato}',style: const TextStyle(fontSize: 18)),
                          Text('latitude: ${_usuario?.latitude}',style: const TextStyle(fontSize: 18)),
                          Text('longitude: ${_usuario?.longitude}',style: const TextStyle(fontSize: 18)),
                          Text('cpf: ${_usuario?.cpf}',style: const TextStyle(fontSize: 18)),
                          Text('patrao: ${_usuario?.owner}',style: const TextStyle(fontSize: 18)),
                          Text('cpf: ${_usuario?.id}',style: const TextStyle(fontSize: 18)),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 10,
                right: 10,
                left: 10,

                child: ElevatedButton(
              child: Text(textoBotao),
              onPressed: (){
                if(_usuario != null && _usuario?.owner == null && _cnpjUsuarioLogado != null.toString()){
                  _adicionaFuncionario(_usuario);
                  Navigator.pushNamedAndRemoveUntil(context, Rotas.homeEmpregador, (context)=>false);
                  return;
                }
                _localUsuario();


              },
            )
            )
          ]
        ),
      ),
    );
  }

  _adicionaFuncionario(Usuario? usuario)async{
    _usuario?.owner = _usuaioLogado?.uid;
    _usuario?.tipo = 'funcionario';
    if(usuario != null){
      await _db.collection('user').doc(usuario.id).update(usuario.toMap());
    }

  }
  _verificarUsuario()async{
    _usuaioLogado = _auth.currentUser;
    _usuario = widget.args?['args'];
    DocumentSnapshot documentSnapshot = await _db.collection('user').doc(_usuaioLogado?.uid).get();
    String cnpjUsuarioLogado = documentSnapshot.get('cnpj');
    if(_usuario?.owner == null && cnpjUsuarioLogado != null.toString()){
      setState(() {
        textoBotao = 'adicionar';
      });
    }
  }
  _localUsuario(){
    Navigator.pushNamed(context, Rotas.localFuncionario);
  }

}
