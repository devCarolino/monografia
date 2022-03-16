import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              //color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/inicio.jpg",

                    )
                )
            ),
          ),
        Positioned(
          top: size.height * 0.4,
            left: 10.0,
            child: InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(
                    context, 'tela-home');
              },
              child: Container(
                padding: EdgeInsets.only(left: 30),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(30),
                ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.85),
                    size: 69,
                  )
              ),
            )),
        ],
      ),

        //  Image.asset("assets/images/inicio.jpg", fit: ,),
    );
  }
}
