
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/usuario.dart';

class LocalFuncionario extends StatefulWidget {
  Map<String,dynamic> usuario;
  LocalFuncionario({super.key,required this.usuario});

  @override
  State<LocalFuncionario> createState() => _LocalFuncionarioState();
}

class _LocalFuncionarioState extends State<LocalFuncionario> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Usuario? _usuario;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(0,0));
  final Completer<GoogleMapController> _completer =
  Completer<GoogleMapController>();


  @override
  void initState() {
    super.initState();
    _usuario = widget.usuario['usuario'];
    _addLocationListner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('posicao atual'),),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreate,
      ),
    );
  }
  _addLocationListner() async {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((
        Position position) {
          _usuario?.latitude = position.latitude;
          _usuario?.longitude = position.longitude;

      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude,position.longitude),zoom: 18);
      _movimentarCamera(_cameraPosition);
    }
    );
  }
  _onMapCreate(GoogleMapController controller) {
    _completer.complete(controller);
  }
  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _completer.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

}
