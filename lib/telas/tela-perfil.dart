import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  String? _idUsuarioLogado;
  String? _nome;
  String? _contacto;
  String? _pais;
  String? _email;
  String? _url;



  Future _recuperarDadosUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
    });


    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('usuarios')
        .doc(_idUsuarioLogado)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;

      if(_idUsuarioLogado != null){
        setState(() {
          _nome = data['nome'];
          _contacto = data['contacto'];
          _pais = data['pais'];
          _email = data['email'];
          _url = data['url'];

          print("DADOS:  ${data}");

        });
      }

    });

  }

  @override
  void initState() {
    _recuperarDadosUsuario();
    _idUsuarioLogado != null;
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                    },
                    child:
                    Icon(
                      Icons.star_border,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child:
                    Icon(
                      Icons.share,
                      size: 30,
                      color: Colors.grey,
                     ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'informacoes');
                    },
                    child: Icon(
                      Icons.info,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                        image: NetworkImage( _url?? "https://firebasestorage.googleapis.com/v0/b/monografia-f9e0a."
                            "appspot.com/o/uploads%2Ficon_a.png?alt=media&token=5f2c2023-0ce8-4aba-88e2-5ef47a21434a")),
                  ),
                   // child: NetworkImage("", fit: BoxFit.cover,);
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'tela-mapa');
                    },
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'editarDados');
                    },
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Nome:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),

             Text(_nome?? "nome", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),

              SizedBox(height: 10,),
              Text("Contacto:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(_contacto??"contacto", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),

              SizedBox(height: 10,),
              Text("País de Orígem:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(_pais??"Pais", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),
              SizedBox(height: 10,),
              Text("Email:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(_email??"email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),
            ],
          ),
        ),
      ),
    );
  }
}
