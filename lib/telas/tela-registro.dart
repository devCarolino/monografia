import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monografia/model/Usuario.dart';
import 'package:monografia/paleta-cores.dart';
import 'package:monografia/ferramentas/rotas.dart';
import 'package:monografia/widgets/background-image.dart';
import 'package:monografia/widgets/botao-geral.dart';
import 'package:monografia/widgets/campos-texto.dart';
import 'package:monografia/widgets/password-input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TelaRegistro extends StatefulWidget {
  @override
  State<TelaRegistro> createState() => _TelaRegistroState();
}

class _TelaRegistroState extends State<TelaRegistro> {

  TextEditingController _nome = TextEditingController();
  TextEditingController _email = TextEditingController(text: "carolino@hotmail.com");
  TextEditingController _cont = TextEditingController();
  TextEditingController _senha = TextEditingController();
  TextEditingController _csenha = TextEditingController();
  TextEditingController _pais = TextEditingController();

  String? _nivel;
  String? idUsuarioLogado;
  String? _url;

  bool _subindoImagem = false;
  String _mensagemErro = "";


  File? _image ;
  final _picker = ImagePicker();

  Future _pegarImagem() async {
    final XFile? imagemSelecionada =
        (await _picker.pickImage(source: ImageSource.gallery))!;

    if (imagemSelecionada != null) {
      setState(() {
        _image = File(imagemSelecionada.path);
      });
    }
  }

  _validarCampos() {
    String nome = _nome.text;
    String contato = _cont.text;
    String email = _email.text;
    String senha = _senha.text;
    String csenha = _csenha.text;
    String pais = _pais.text;
    String nivel = _nivel.toString();
    String url = _url.toString();

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty) {
          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.contato = contato;
          usuario.email = email;
          usuario.senha = senha;
          usuario.csenha = csenha;
          usuario.pais = pais;
          usuario.nivel = nivel;
          usuario.url = url;

          _cadastrarUsuario(usuario);
          _uploadImagem();

        } else {
          setState(() {
            _mensagemErro = "Senha ivalido";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "email invalido ";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Nome ivalido";
      });
    }
  }

  _cadastrarUsuario( Usuario usuario ) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
    ).then((firebaseUser) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection('usuarios')
          .doc(firebaseUser.user!.uid)
          .set(usuario.toMap());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(nome: '',),
          ));
    }).catchError((error) {
      setState(() {
        _mensagemErro = "Erro ao Cadastrar Usuario";
      });

      print("erro app: " + error.toString());
    });
  }


  _uploadImagem() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    idUsuarioLogado = usuarioLogado.uid;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz.child('uploads')
        .child(idUsuarioLogado! +'.jpg');

    UploadTask task = arquivo.putFile(_image!);

    //Controlar o progresso do upload

   task.snapshotEvents.listen((TaskSnapshot snapshot){
    var progresso = (snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble()) * 100;

      if(progresso < 100.0) {
          _subindoImagem = true;
        print("Carregando $progresso%");
      } else if(progresso==100.0) {
         _recuperarUrlImagem(snapshot);
         _subindoImagem = false;
      }

    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    idUsuarioLogado = usuarioLogado.uid;

      String urlImage = await snapshot.ref.getDownloadURL();
        FirebaseFirestore db = FirebaseFirestore.instance;
        db.collection('usuarios')
            .doc(idUsuarioLogado)
            .set({
          "url": urlImage
        });
        _url = urlImage;
      print("URL: $_url");

    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/fundo.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400]?.withOpacity(0.4),
                        radius: 60.0,
                        child: _image == null
                            ? Icon(
                                FontAwesomeIcons.user,
                                color: kWhite,
                                size: size.width * 0.1,
                              )
                            : new CircleAvatar(
                                backgroundImage: new FileImage(_image!),
                                radius: 60.0,
                                backgroundColor:
                                    Colors.grey[400]?.withOpacity(0.4),
                              ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.11,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kWhite,
                            width: 2,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: _pegarImagem,
                          child: const Icon(
                            FontAwesomeIcons.camera,
                            color: kWhite,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.06,
                ),
                Column(
                  children: [
                    _subindoImagem == true?
                    CircularProgressIndicator() : Text(""),

                    TextInputField(
                        controller: _nome,
                        icon: FontAwesomeIcons.solidUser,
                        hint: 'Nome Completo',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    TextInputField(
                        controller: _cont,
                        icon: FontAwesomeIcons.phone,
                        hint: 'Contacto',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    TextInputField(
                        controller: _email,
                        icon: FontAwesomeIcons.solidEnvelope,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next),
                    PasswordInput(
                        controller: _senha,
                        icon: FontAwesomeIcons.lock,
                        hint: 'Senha',
                        inputAction: TextInputAction.next),
                    PasswordInput(
                        controller: _csenha,
                        icon: FontAwesomeIcons.lock,
                        hint: 'Confirmar Senha',
                        inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                        controller: _pais,
                        icon: FontAwesomeIcons.hotel,
                        hint: 'País de Origem',
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done),
                    const SizedBox(height: 10),
                    Text(
                      _mensagemErro,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundedButton(
                      onPressed: () {
                          _validarCampos();

                      },
                      buttonName: 'Registrar',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já tem uma conta?",
                          style: kBodyText,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, 'tela-login')
                          },
                          child: Text(
                            "Entrar",
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
