import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monografia/ferramentas/Card.dart';
import 'package:monografia/ferramentas/configuracoes.dart';
import 'package:monografia/ferramentas/rotas.dart';
import 'package:monografia/telas/tela-login.dart';
import 'package:monografia/telas/tela-perfil.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.nome}) : super(key: key);

  final String nome;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? colorName;
  Color? color;
  String? _emailUsuario = "";
  String? _nomelUsuario = "";
  String? idUsuarioLogado;
  String? _imagem = "https://firebasestorage.googleapis.com/v0/b/monografia-f9e0a.appspot.com/o/img_local%2Ficone.png?alt=media&token=eb4eb5b9-f1e3-4ba9-b9cf-4ebaf5f1c6b3";
  var _url;

  List<String> itensMenu = [
    "Configurações",
    "Perfil",
  ];

  bool _logado = false;

  _escolherMenuItem(String escolherMenu) {
    switch (escolherMenu) {
      case "Configurações":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Configuracoes()));
        break;
      case "Perfil":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Perfil()));
        break;
    }
  }

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;

    /*  FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await db.collection("usuarios")
    .get();

    for(DocumentSnapshot item in snapshot.docs){
      var dados = item.data();
    print("dados usuarios: " + dados.toString());

    } */

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('usuarios')
        .doc(idUsuarioLogado)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;

      setState(() {
        _nomelUsuario = data['nome'];
        _url = data['url'];
      });
      print("Nome: " + _nomelUsuario!);
    });

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

  Future _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, 'tela-home');
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;

    if (usuarioLogado != null) {
      setState(() {
        _logado = true;
      });
    }
  }

  Future _recuperarIdUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    idUsuarioLogado = usuarioLogado.uid;
  }

  @override
  void initState() {
    _recuperarIdUsuario();
    _verificarUsuarioLogado();
    _recuperarDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    Widget menuDrawer() {
      return Drawer(
        elevation: 0.0,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  _logado
                      ? Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Perfil()))
                      : null;
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  //  backgroundColor: Colors.grey[400]?.withOpacity(0.4),
                  radius: 60.0,
                  backgroundImage: NetworkImage(_url ?? _imagem),
                ),
              ),
              accountName: _logado == true
                  ? Text(_nomelUsuario!)
                  : Text("Seja Muito Bem Vindo"),
              accountEmail: _logado == true
                  ? Text(_emailUsuario!)
                  : Text("Estás no modo Convidado"),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.home, color: Colors.green),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              onTap: () {
                _logado == true
                    ? Navigator.pushNamed(context, 'informacoes')
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                                child: Text(
                              "Atenção",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                            content: Text(
                              "Para acessar este caminho precisa efetuar o Login!",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Sair",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TelaLogin()));
                                      },
                                      child: Text(
                                        "Entrar",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              )
                            ],
                          );
                        });
              },
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text(
                "Sobre nós",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'administrador');
                });
              },
              leading: Icon(Icons.contact_page, color: Colors.red),
              title: Text(
                "Contacta-nos",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                Navigator.pushNamed(context, 'configuracoes');
                });
              },
              leading: Icon(Icons.settings, color: Colors.purpleAccent),
              title: Text(
                "Configurações",
                style: TextStyle(color: Colors.purpleAccent),
              ),
            ),
            _logado == false
                ? ListTile(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                      Navigator.pushNamed(context, 'tela-login');

                    },
                    leading: Icon(Icons.lock, color: Colors.brown),
                    title: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.brown),
                    ),
                  )
                : ListTile(
                    onTap: () {
                      _deslogarUsuario();
                    },
                    leading: Icon(Icons.lock_open, color: Colors.deepOrange),
                    title: Text(
                      "Terminar sessão",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          _logado == true
              ? Row(
                children: [
                  PopupMenuButton<String>(
                    iconSize: 40.0,
                    icon: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(_url ?? _imagem),
                    ),
                      //Icon(Icons.person),
                      onSelected: _escolherMenuItem,
                      itemBuilder: (context) {
                        return itensMenu.map((String item) {
                          return PopupMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList();
                      }),
                ],
              )
              : Container(),
        ],
      ),

      drawer: menuDrawer(),
      body:
      _logado == true?
      SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: 330,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(90.0)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.0,
                    ),
                    Text(
                      "Where you want to go?",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search, size: 30,),
                            hintText: "Search...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sugestões",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),

                ],
              ),
            ),
            CardHome(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Melhores Lugar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),

                ],
              ),
            ),
            CardHome(),
          ],
        ),
      ) :
      Center(
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Voce precisa Entrar para ver o resto"
            , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          )),

      //========================================

    );

  }
}
