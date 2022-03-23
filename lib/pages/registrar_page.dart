import 'package:challenge_hmv/models/autenticacao.dart';
import 'package:challenge_hmv/pages/login_page.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:challenge_hmv/widgets/herder_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> autorizarPaciente = {
    'nome': '',
    'cpf': '',
    'email': '',
    'senha': '',
  };

  void _showPacienteSucesso(String titulo, String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  void _showErroRegPaciente(String titulo, String msg) {
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

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() => isLoading = true);

    _formKey.currentState?.save();
    Autenticacao autenticar = Provider.of(context, listen: false);

    try {
      await autenticar.registrarPaciente(
        autorizarPaciente['nome'],
        autorizarPaciente['cpf'],
        autorizarPaciente['email'],
        autorizarPaciente['senha'],
      );
      _showPacienteSucesso('Aviso','Registro cadastro com sucesso!');
    } catch (e) {
      _showErroRegPaciente('Ocorreu um Erro', e.toString());
    }

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
            if (!isKeyboard) HeaderContainer("Registrar"),
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
                            hintText: "Nome",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (nome) =>
                              autorizarPaciente['nome'] = nome ?? '',
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
                              hintText: "CPF",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (cpf) =>
                                autorizarPaciente['cpf'] = cpf ?? ''),
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
                              hintText: "E-mail",
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (email) =>
                                autorizarPaciente['email'] = email ?? ''),
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
                            onSaved: (senha) =>
                                autorizarPaciente['senha'] = senha ?? ''),
                      ),
                      const SizedBox(height: 20),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: _submit,
                          child: const Text("REGISTRAR"),
                          style: ElevatedButton.styleFrom(
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
                              text: "Já está registrado? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Entrar",
                              style: TextStyle(color: azulHmv),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
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

  Widget _textInput(
      {controller, hint, icon, Map<String, String> paciente, String campo}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
        onSaved: (campo) => paciente[campo] = campo ?? '',
      ),
    );
  }
}
