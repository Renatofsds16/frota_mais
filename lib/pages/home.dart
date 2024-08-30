import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frota_mais/help_firebase/help_firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HelpFirebaseAuth _auth = HelpFirebaseAuth();
  final List<String> _options = ['Manutencao','Sair'];
  final Completer<GoogleMapController> _completer = Completer<GoogleMapController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepOrange,
        actions: [
          PopupMenuButton<String>(
            onSelected: _selectUser,
              itemBuilder: (context){
                return _options.map((String option){
                  return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                  );
                }).toList();
              }
          ),
        ],
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            zoom: 18,
              target: LatLng(-7.07550524958322,-34.851280219036276)
          ),
          onMapCreated: _onMapCreate,

        ),
      ),
    );
  }

  _selectUser(String value) async {
    switch(value){
      case 'Manutencao':
        break;
      case 'Sair':
        _logofUser();
        break;
    }

  }
  _logofUser()async{
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
  _onMapCreate(GoogleMapController controller){
    _completer.complete(controller);
  }

}
