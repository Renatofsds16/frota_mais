import 'package:flutter/material.dart';
 class Home extends StatelessWidget {
   const Home({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.deepOrange,
       title: const Text('Frota mais',style: TextStyle(color: Colors.white),),
     ),
       body: Container(
         color: Colors.blue,
         width: 200,
         height: 200,
       ),
     );
   }
 }
