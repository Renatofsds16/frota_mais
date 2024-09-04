import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:frota_mais/help_firebase/help_firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(0,0));
  final HelpFirebaseAuth _auth = HelpFirebaseAuth();
  final List<String> _options = ['Manutencao', 'Sair'];
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  @override
  void initState() {
    _requestPemision();
    _addLocationListner();
    super.initState();
  }

  _addLocationListner() async {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((
        Position position) {
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude,position.longitude),zoom: 18);
      _movimentarCamera(_cameraPosition);
        }
    );
  }

  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _completer.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: Container(
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreate,
        ),
      ),
    );
  }

  _selectUser(String value) async {
    switch (value) {
      case 'Manutencao':
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

  _onMapCreate(GoogleMapController controller) {
    _completer.complete(controller);
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
