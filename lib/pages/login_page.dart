import 'package:challenge_hmv/models/autenticacao.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/registrar_page.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:challenge_hmv/widgets/herder_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> logarApp = {'usuario': '', 'senha': ''};

  void _showErroLogim(String titulo, String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  _logarNoApp() async {
    setState(() => isLoading = true);
    _formKey.currentState?.save();
    Autenticacao autenticar = Provider.of(context, listen: false);

    String _emailSalvo;
    String _senhaSalva;
    String _wID;
    String _wNome;
    String _wSenha;

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailSalvo = prefs.getString("EMAIL");
      _senhaSalva = prefs.getString("SENHA");
    });

    print('Email recuperado => {$_emailSalvo}');
    print('Senha recuperada => {$_senhaSalva}');

    if (_emailSalvo == null) {

      Usuario usuario = Usuario(
        id: null,
        nome: null,
        email: logarApp['usuario'],
        senha: logarApp['senha'],
      );

      try {
        await autenticar.gerarToken(usuario);
        print("Finalizou!");
      } catch (e) {
        _showErroLogim('Erro ao autenticar', e.toString());
      }

      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _wID = prefs.getString("ID");
        _wNome = prefs.getString("NOME");
      });

      Usuario usuario1 = Usuario(
        id: _wID,
        nome: _wNome,
        email: logarApp['usuario'],
        senha: logarApp['senha'],
      );

      print(usuario1.senha);
        print(usuario1.email);
        print(usuario1.nome);
      print(usuario1.id);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(usuario: usuario1)),
      );


    } else {
      if (_emailSalvo.compareTo(logarApp['usuario']) == 1) {
        setState(() => isLoading = false);
        _showErroLogim("Erro", "Usuário não encontrado.");
      }

      if (_senhaSalva == null) {
        setState(() => isLoading = false);
        _showErroLogim("Erro", "Senha não encontrada.");
      } else {
        if (_senhaSalva.compareTo(logarApp['senha']) == 1) {
          setState(() => isLoading = false);
          _showErroLogim("Erro", "A senha informada está incorreta.");
        }
        setState(() => isLoading = false);

        Usuario usuario = Usuario(
          id: prefs.getString("ID"),
          nome: prefs.getString("NOME"),
          email: prefs.getString("EMAIL"),
          senha: prefs.getString("SENHA"),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(usuario: usuario)),
        );
      }
    }

    print('Saiu da chamada - tela de HOME');
    setState(() => isLoading = false);
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onSaved: (usuario) =>
                              logarApp['usuario'] = usuario ?? '',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Senha",
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                          onSaved: (senha) => logarApp['senha'] = senha ?? '',
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: const Text("Esqueceu a senha?")),
                      const SizedBox(height: 20),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: _logarNoApp,
                          child: const Text("ENTRAR"),
                          style: ElevatedButton.styleFrom(
                            primary: azulHmv,
                            //onPrimary: azulHmv,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 110,
                              vertical: 10,
                            ),
                          ),
                        ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "Não possui uma conta? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Criar",
                              style: TextStyle(color: azulHmv),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrarPage()));
                                }),
                        ]),
                      )
                    ],
                  ),
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
