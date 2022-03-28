import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/cadastrar_paciente_next2.dart';
import 'package:challenge_hmv/pages/home.dart';
import 'package:flutter/material.dart';

class cadastrarPaciente extends StatefulWidget {
  final Usuario usuario;

  const cadastrarPaciente({Key key, @required Usuario this.usuario})
      : super(key: key);

  @override
  State<cadastrarPaciente> createState() => _cadastrarPacienteState();
}

class _cadastrarPacienteState extends State<cadastrarPaciente> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> cadastrarPaciente = {
    'nome': '',
    'email': '',
    'nomeMae': '',
    'nomePai': '',
  };

  void _showErroPaciente(String titulo, String msg) {
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

  _proximoContinuarCadastro(Usuario usuario) {
    _formKey.currentState?.save();
    Paciente paciente = Paciente(
      nome: cadastrarPaciente['nome'],
      email: cadastrarPaciente['email'],
      nomeMae: cadastrarPaciente['nomeMae'],
      nomePai: cadastrarPaciente['nomePai'],
    );

    print('nome => ' + paciente.nome + '  -----> ' + cadastrarPaciente['nome']);
    print('email => ' +
        paciente.email +
        '  -----> ' +
        cadastrarPaciente['email']);
    print('nomeMae => ' +
        paciente.nomeMae +
        '  -----> ' +
        cadastrarPaciente['nomeMae']);
    print('nomePai => ' +
        paciente.nomePai +
        '  -----> ' +
        cadastrarPaciente['nomePai']);

    if (paciente.nome == '') {
      _showErroPaciente("Erro", "Favor preencher o nome.");
    } else if (paciente.email == '') {
      _showErroPaciente("Erro", "Favor preencher o e-mail.");
    } else if (paciente.nomeMae == '') {
      _showErroPaciente("Erro", "Favor preencher o nome da mãe.");
    } else if (paciente.nomePai == '') {
      _showErroPaciente("Erro", "Favor preencher o nome do pai.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              cadastrarPacienteNext2(usuario: usuario, paciente2: paciente),
        ),
      );
    }
  }

  _cancelarCadastro(Usuario usuario) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(usuario: usuario)),
    );
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
                              cadastrarPaciente['nome'] = nome ?? '',
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
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onSaved: (email) =>
                              cadastrarPaciente['email'] = email ?? '',
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
                              hintText: "Nome completo da mãe",
                              prefixIcon: Icon(Icons.account_box),
                            ),
                            onSaved: (nomeMae) =>
                                cadastrarPaciente['nomeMae'] = nomeMae ?? ''),
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
                              hintText: "Nome completo do pai",
                              prefixIcon: Icon(Icons.account_box_outlined),
                            ),
                            onSaved: (nomePai) =>
                                cadastrarPaciente['nomePai'] = nomePai ?? ''),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 10),
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     color: Colors.white,
                      //   ),
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: TextFormField(
                      //       decoration: const InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "E-mail",
                      //         prefixIcon: Icon(Icons.email),
                      //       ),
                      //       onSaved: (email) =>
                      //       cadastrarPaciente['email'] = email ?? ''),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 10),
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                      //     color: Colors.white,
                      //   ),
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: TextFormField(
                      //       decoration: const InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "Senha",
                      //         prefixIcon: Icon(Icons.vpn_key),
                      //       ),
                      //       onSaved: (senha) =>
                      //       cadastrarPaciente['senha'] = senha ?? ''),
                      // ),
                      const SizedBox(height: 20),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () =>
                              _proximoContinuarCadastro(this.widget.usuario),
                          child: const Text("PRÓXIMO"),
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
                      ElevatedButton(
                        onPressed: () => _cancelarCadastro(this.widget.usuario),
                        child: const Text("CANCELAR"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 110,
                            vertical: 10,
                          ),
                        ),
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
}
