import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  bool _mapa = false;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa e Localização",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.withOpacity(0.9),
        actions: [
          Switch(
            activeColor: Colors.brown,
            value: _mapa,
            onChanged: (bool valor) {
              setState(() {
                _mapa = !_mapa;
              });
            },),
        ],
      ),
      body: Container(
        child: GoogleMap(
          mapType: _mapa ==true? MapType.satellite :
          MapType.normal,
            //-6.138943729182407, 12.371372554485845
            initialCameraPosition: CameraPosition(
                target: LatLng(-6.138943729182407, 12.371372554485845),
              zoom: 16,
            ),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
