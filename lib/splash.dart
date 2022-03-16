import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
      super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
          context, 'tela-inicial');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bem-Vindo",
              style: TextStyle(fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[400]?.withOpacity(0.5)),
            ),
            SizedBox(
              height: 50.0,
            ),

           Container(
             height: 350,
             width: 350,
             decoration: BoxDecoration(
                 //color: Colors.blue,
               image: DecorationImage(
                 image: AssetImage(
                     "assets/images/splash.png",
                 )
               )
             ),
           ),

            SizedBox(
              height: 100.0
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Carregando...",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue[400]?.withOpacity(0.5)),
                  strokeWidth: 3.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
