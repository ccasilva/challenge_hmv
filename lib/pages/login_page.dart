import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/registrar_page.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:challenge_hmv/widgets/btn_widget.dart';
import 'package:challenge_hmv/widgets/herder_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            if (!isKeyboard) HeaderContainer("Entrar"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(hint: "E-mail", icon: Icons.email),
                    _textInput(hint: "Senha", icon: Icons.vpn_key),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: const Text("Esqueceu a senha?")
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                            );
                          },
                          btnText: "ENTRAR",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Não possui uma conta? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Criar",
                            style: TextStyle(color: azulHmv),
                            recognizer: TapGestureRecognizer()..onTap = (){
                                 Navigator.push(context,
                                 MaterialPageRoute(
                                     builder: (context) => RegistrarPage()));
                          }
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
