import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monografia/ferramentas/rotas.dart';
import 'package:monografia/widgets/botao-geral.dart';
import 'package:monografia/widgets/campos-texto.dart';
import 'package:monografia/widgets/password-input.dart';
import '../paleta-cores.dart';

class EditarDados extends StatefulWidget {
  const EditarDados({Key? key}) : super(key: key);

  @override
  _EditarDadosState createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> {

  TextEditingController _editNome = TextEditingController();
  TextEditingController _editContacto = TextEditingController();
  TextEditingController _editSenha = TextEditingController();
  TextEditingController _editCsenha = TextEditingController();
  TextEditingController _editPais = TextEditingController();

  String _mensagemErro = "";
  bool _subindoImagem = false;
  String? _idUsuarioLogado;
  String? urlImg;

  bool _aparece = false;

  File? _image;
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


  _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child('uploads')
        .child(_idUsuarioLogado! + '.jpg');
    UploadTask task = arquivo.putFile(_image!);

    task.snapshotEvents.listen((TaskSnapshot snapshot){
      var progresso = (snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble()) * 100;

      if(progresso < 100.0) {
        setState(() {
          _subindoImagem = true;
        });
        print("Carregando $progresso%");
      } else if(progresso==100.0) {
        setState(() {
          _subindoImagem = false;
          _recuperarUrlImagem(snapshot);
          //_atualizarOutrosDadosFirestore();
          setState(() {
            _idUsuarioLogado != null;
          });
            Navigator.pop(context);

        });
      }

    });
  }
/*
 void _toastPersonalizado(){
    Fluttertoast.showToast(
        msg: "Dados Atualizados Com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  } */

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async{
    String urlImage = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(urlImage);
    setState(() {
      urlImg = urlImage;
    });
    print("URL: $urlImage");

  }

  _recuperarDadosUsuarios() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
     db.collection("usuarios")
    .doc(_idUsuarioLogado)
    .get().then((DocumentSnapshot documentSnapshot) {

      Map<String, dynamic> dadosUsuario = documentSnapshot.data()! as Map<String, dynamic>;

      if(dadosUsuario["url"] != null){
        setState(() {
          _aparece = true;
          urlImg = dadosUsuario["url"];
        });

      }
      _editNome.text = dadosUsuario["nome"];
      _editContacto.text = dadosUsuario["contacto"];
      _editPais.text = dadosUsuario["pais"];

      return null;
    });

   //Map<String, dynamic> dadosUsuario = snapshot.data as Map<String, dynamic>;



  }

  _atualizarOutrosDadosFirestore(){

    String nome = _editNome.text;
    String contacto = _editContacto.text;
    String pais = _editPais.text;

    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "nome" : nome,
      "contacto" : contacto,
      "pais" : pais,
    };
    db.collection("usuarios")
        .doc(_idUsuarioLogado)
        .update(dadosAtualizar);

  }

  _atualizarUrlImagemFirestore(String? urlImage){

    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "url" : urlImage
    };
    db.collection("usuarios")
    .doc(_idUsuarioLogado)
    .update(dadosAtualizar);

  }

  @override
  void initState() {
   urlImg;
   _recuperarDadosUsuarios();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar os dados", style: TextStyle(fontSize: 16),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.1,
            ),
            Stack(
              children: [
                Center(
                  child:
                  _aparece == true?
                  CircleAvatar(
                    backgroundColor: Colors.grey[400]?.withOpacity(0.4),
                    radius: 60.0,
                      backgroundImage: NetworkImage( urlImg?? ""),
                   // child: Image.network(urlImg!),
                  ) :
                  CircleAvatar(
                    backgroundColor: Colors.grey[400]?.withOpacity(0.4),
                    radius: 60.0,
                /*  child: Center(
                    child: Text("Carregando...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),*/
                    backgroundImage: Image.file(_image!).image,
                   //  child: Image.file(_image!),
                    //Image.network(urlImg!),
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
                      onTap: (){
                        _pegarImagem();
                        _aparece = false;
                      },
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
                _subindoImagem == false ?
                Text("")
                    : CircularProgressIndicator(),
                TextInputField(
                    controller: _editNome,
                    icon: FontAwesomeIcons.solidUser,
                    hint: 'Nome Completo',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next),
                TextInputField(
                    controller: _editContacto,
                    icon: FontAwesomeIcons.phone,
                    hint: 'Contacto',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next),
                PasswordInput(
                    controller: _editSenha,
                    icon: FontAwesomeIcons.lock,
                    hint: 'Editar Senha',
                    inputAction: TextInputAction.next),
                PasswordInput(
                  controller: _editCsenha,
                  icon: FontAwesomeIcons.lock,
                  hint: 'Confirmar Senha Editada',
                  inputAction: TextInputAction.next,
                ),
                TextInputField(
                    controller: _editPais,
                    icon: FontAwesomeIcons.hotel,
                    hint: 'Editar País',
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
                    _uploadImagem();
                    _atualizarOutrosDadosFirestore();
                    _aparece = true;
                  },
                  buttonName: 'Atualizar',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
