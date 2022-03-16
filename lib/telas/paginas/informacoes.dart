

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Informacoes extends StatelessWidget {
  const Informacoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre o App", style: TextStyle(fontSize: 16),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Center(child: Text("Aqui vai se dar toda informação sobre o aplicativo")),

          ],
        ),
      ),
    );
  }
}
