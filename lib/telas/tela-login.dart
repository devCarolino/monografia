import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monografia/model/Usuario.dart';
import 'package:monografia/paleta-cores.dart';
import 'package:monografia/telas/tela-home.dart';
import 'package:monografia/widgets/background-image.dart';
import 'package:monografia/widgets/botao-geral.dart';
import 'package:monografia/widgets/campos-texto.dart';
import 'package:monografia/widgets/password-input.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  TextEditingController _email = TextEditingController(text: "carolino@hotmail.com");
  TextEditingController _senha = TextEditingController();

   bool _subindoImagem = false;
   String _mensagemErro = "";
  // String? _idUsuarioLogado;

  _validarCampos(){
    String email = _email.text;
    String senha = _senha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty){
        setState(() {
          _mensagemErro = "";
          _subindoImagem = true;
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);


      } else{
        setState(() {
          _mensagemErro = "Preencha a Senha ";
        });
      }
    } else{
      setState(() {
        _mensagemErro = "Preencha o email usando @ ";
      });
    }
  }


    void _logarUsuario(Usuario usuario){
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha
      ).then((firebaseUser) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(nome: '',)));
        setState(() {
          _subindoImagem = false;
        });
        print(_subindoImagem);

      }).catchError((error){
        setState(() {
          _subindoImagem = false;
          _mensagemErro = "Erro ao autenticar Usuário, Virifica Email e Senha";
        });

      });

    }

  Future _verificarUsuarioLogado() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;

    if(usuarioLogado != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(nome: '',)));

    }

  }

 /* _condicaoEdntrada(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('usuarios')
        .doc(_idUsuarioLogado)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;

      if(_idUsuarioLogado != null) {
        if(data['nivel'] == "Admin"){
          Navigator.pushReplacementNamed(context, 'administrador');
          print("TODOS DADOS:  ${data}");
        } else{
          Navigator.pushReplacementNamed(context, 'tela-login');
          print("TODOS DADOS:  ${data}");
        }
      }
      });
  } */

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(
          image: 'assets/images/soyo.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    "Bem-Vindos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ),
              _subindoImagem == false ?
              Text("")
                  : CircularProgressIndicator(),
              SizedBox(height: 14,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Campo do Email
                   TextInputField(
                     controller: _email,
                    hint: 'Insira o seu email',
                    icon: FontAwesomeIcons.solidEnvelope,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  //Campo da Palavra passe
                   PasswordInput(
                     controller: _senha,
                    hint: 'Palavra Passe',
                    icon: FontAwesomeIcons.userLock,
                    inputAction: TextInputAction.done,
                  ),

                  Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'esqueceu-senha'),
                    child: const Text(
                      "Esqueceu sua palavra-passe?",
                      style: kBodyText,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                   RoundedButton(
                    onPressed: () {
                        _validarCampos();
                        } ,
                    buttonName: "Entrar",
                   ),

                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, 'tela-registro'),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: kWhite,
                          ))),
                  child: const Text(
                    'Criar Nova Conta',
                    style: kBodyText2,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
