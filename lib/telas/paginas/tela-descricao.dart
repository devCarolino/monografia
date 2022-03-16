import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monografia/telas/paginas/hoteis.dart';

class Descricao extends StatefulWidget {
  const Descricao({Key? key}) : super(key: key);

  @override
  _DescricaoState createState() => _DescricaoState();
}

class _DescricaoState extends State<Descricao> {
  Color? color;
  String? colorName;

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Descrição"),
        elevation: 0.0,
        centerTitle: true,


      ),
      body: Stack(
        children: [
            StreamBuilder<QuerySnapshot>(
                stream: db.collection('municipio').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else{
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/soyo.jpg'),
                              ),
                              color: Colors.lightBlueAccent,
                              borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(100.0), bottomLeft: Radius.circular(100.0) ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text("Soyo Sede",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Icon(Icons.favorite, color: Colors.red,),
                            ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Centro",
                              style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Neste trabalho, abordaremos um pouco sobre um assunto espelhado na constituição da república. "
                  "Falaremos da “Nacionalidade”, que está no artigo 9º contido na CRA (Constituição da República de Angola)."
                  "A nacionalidade ou cidadania é a qualidade de um sujeito de pertença a certo Estado, o que constitui "
                  "condição a que estão associados o exercício dos direitos e o cumprimento dos deveres inerentes."
                                  "A nacionalidade ou cidadania é a qualidade de um sujeito de pertença a certo Estado, o que constitui, "
                                  "A nacionalidade ou cidadania é a qualidade de um sujeito de pertença a certo Estado, o que constitui",
                              style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,

                              ),
                              ),
                          ),
                        ],
                      ),
                    );

                      /*Column(
                      children: snapshot.data!.docs.map((doc){
                        return Column(
                          children: [

                          ],
                        );
                          /*Card(
                          child: ListTile(
                            title: Text(doc['ponto']),
                            leading: Image.network(doc['url']),
                          ),
                        ); */
                      }).toList(),
                    ) */;
                  }
                }

            ),
          Positioned(
            child: CircularMenu(
              alignment: Alignment.bottomLeft,
              curve: Curves.bounceOut,
              reverseCurve: Curves.bounceInOut,
              toggleButtonColor: Colors.cyan[400],
              items: [
                CircularMenuItem(
                    icon: Icons.hotel,
                    color: Colors.brown,
                    onTap: () {
                      setState(() {
                        color = Colors.brown;
                        colorName = 'Brown';
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Hotel()));
                      });
                    }),
                CircularMenuItem(
                    badgeLeftOffet: 30.0,
                    icon: Icons.restaurant,
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        color = Colors.green;
                        colorName = 'Green';
                        Navigator.pushNamed(context, 'restaurante');
                      });
                    }),
                CircularMenuItem(
                    margin: 20,
                    icon: Icons.shopping_cart,
                    color: Colors.red,
                    onTap: () {
                      setState(() {
                        color = Colors.red;
                        colorName = 'red';
                      });
                    }),
                CircularMenuItem(
                    margin: 20,
                    icon: Icons.pool,
                    color: Colors.orange,
                    onTap: () {
                      setState(() {
                        color = Colors.orange;
                        colorName = 'orange';
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
