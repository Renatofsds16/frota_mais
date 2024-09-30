import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../rotas.dart';
import 'loading_data.dart';

class ShowList extends StatelessWidget {
  final Future<List<Usuario>>? Function() future;
  final String? idUsuarioLogado;
  const ShowList({super.key,required this.future,required this.idUsuarioLogado});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: future(),
      builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const LoadingData();
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  if(snapshot.hasError){
                    return const Center(
                      child: Text('Erro desconhecido'),
                    );
                  }else if(snapshot.hasData){
                    List<Usuario>? listItens = snapshot.data;
                    late Usuario usuario;
                    if (listItens != null) {
                      usuario = listItens[index];
                      return ListTile(
                        title: Text(usuario.nome.toString()),
                        subtitle: Text(usuario.tipo.toString()),
                        onTap: () {
                          //ficha do colaborador
                            Navigator.pushNamed(context,Rotas.details,arguments: usuario);
                        },
                      );
                    }
                  }

                });
        }
      },
    );
  }
}
