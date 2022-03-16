import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monografia/admin/dasboard.dart';
import 'package:monografia/ferramentas/configuracoes.dart';
import 'package:monografia/ferramentas/editarDados.dart';
import 'package:monografia/ferramentas/mapas.dart';
import 'package:monografia/splash.dart';
import 'package:monografia/telas/esqueceu-senha.dart';
import 'package:monografia/telas/paginas/hoteis.dart';
import 'package:monografia/telas/paginas/restaurantes.dart';
import 'package:monografia/telas/tela-home.dart';
import 'package:monografia/telas/tela-login.dart';
import 'package:monografia/telas/tela-perfil.dart';
import 'ferramentas/rotas.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 /* FirebaseFirestore.instance
  .collection("usuarios")
  .doc("pontuacao")
  .set({"Carlos": "80", "Paulo": "140"});

  */



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        'tela-inicial': (context) => Inicio(),
        'tela-home': (context) => Home(nome: '',),
        'tela-login': (context) => TelaLogin(),
        'tela-registro': (context) => TelaRegistro(),
        'tela-mapa': (context) => Mapa(),
        'esqueceu-senha': (context) => EsqueceuSenha(),
        'configuracoes': (context) => Configuracoes(),
        'hotel': (context) => Hotel(),
        'restaurante': (context) => Restaurante(),
        'tela-perfil': (context) => Perfil(),
        'editarDados': (context) => EditarDados(),
        'informacoes': (context) => Informacoes(),
        'administrador': (context) => Administrador(),
        'descricao': (context) => Descricao(),
      },
    );
  }
}
