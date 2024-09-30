import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text('Carregando dados...')
      ],
    );
  }
}
