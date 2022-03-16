import 'package:flutter/material.dart';

class Restaurante extends StatefulWidget {
  const Restaurante({Key? key}) : super(key: key);

  @override
  _RestauranteState createState() => _RestauranteState();
}

class _RestauranteState extends State<Restaurante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Bem vindo ao Restaurante"),
      ),
    );
  }
}

