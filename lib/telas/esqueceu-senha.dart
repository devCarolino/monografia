
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monografia/widgets/background-image.dart';
import 'package:monografia/widgets/botao-geral.dart';
import 'package:monografia/widgets/campos-texto.dart';

import '../paleta-cores.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({Key? key}) : super(key: key);

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {

  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/fundologin.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: const Text("Esqueceu a Palavra passe?"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    SizedBox(
                      width: size.height * 0.8,
                      child: const Text(
                        "Insira o seu E-mail, vamos enviar as instruções para recuperar sua senha.",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TextInputField(
                       controller: senha,
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.done),
                    const SizedBox(
                      height: 20,
                    ),
                     RoundedButton(
                       onPressed: (){

                       },
                      buttonName: 'Enviar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}