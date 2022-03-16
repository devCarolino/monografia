import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  bool _modo = false;

  @override
  Widget build(BuildContext context) {
    late Color _cor1;
    late Color _cor2;
    if(_modo == false){
      _cor1 = Colors.black;
      _cor2 = Colors.deepOrange;
    } else{
     _cor1 = Colors.white;
     _cor2 = Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações", style: TextStyle(fontSize: 16),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: _modo == false? Colors.white
        : Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Alterar Modo", style: TextStyle(
                    color: _modo == false? _cor1: _cor1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("(modo noturno)", style: TextStyle(
                    color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Switch(
                      activeColor: Colors.white,
                    value: _modo,
                    onChanged: (bool valor) {
                        setState(() {
                          _modo = !_modo;
                        });
                    },),
                  ),
                ),
              ],
            ),

            Center(child: Icon(Icons.person, size: 50, color: _modo == false? _cor2: _cor2,)),

          ],
        ),
      ),
    );
  }
}
