import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/cadastrar_paciente_next3.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class cadastrarPacienteNext2 extends StatefulWidget {
  final Usuario usuario;
  final Paciente paciente2;

  const cadastrarPacienteNext2({
    Key key,
    @required Usuario this.usuario,
    @required Paciente this.paciente2,
  }) : super(key: key);

  @override
  State<cadastrarPacienteNext2> createState() => _cadastrarPacienteNext2State();
}

class _cadastrarPacienteNext2State extends State<cadastrarPacienteNext2> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> cadastrarPaciente = {
    'enderecoDescricao': '',
    'logradouro': '',
    'numero': '',
    'complemento': '',
    'cidade': '',
    'uf': '',
    'cep': '',
  };

  _cancelarCadastro(Usuario usuario) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(usuario: usuario)),
    );
  }

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

  _proximoContinuarCadastro(Usuario usuario, Paciente paciente2) {
    _formKey.currentState?.save();

    Paciente paciente = Paciente(
      nome: paciente2.nome,
      email: paciente2.email,
      nomeMae: paciente2.nomeMae,
      nomePai: paciente2.nomePai,
      enderecoDescricao: cadastrarPaciente['enderecoDescricao'],
      logradouro: cadastrarPaciente['logradouro'],
      numero: cadastrarPaciente['numero'],
      complemento: cadastrarPaciente['complemento'],
      cidade: cadastrarPaciente['cidade'],
      uf: cadastrarPaciente['uf'],
      cep: cadastrarPaciente['cep'],
    );

    if (paciente.enderecoDescricao == '') {
      _showErroPaciente("Erro", "Favor preencher a descrição do endereço");
    } else if (paciente.logradouro == '') {
      _showErroPaciente("Erro", "Favor preencher o logradouro");
    } else if (paciente.numero == '') {
      _showErroPaciente("Erro", "Favor preencher o numero");
    } else if (paciente.complemento == '') {
      _showErroPaciente("Erro", "Favor preencher o complemento");
    } else if (paciente.cidade == '') {
      _showErroPaciente("Erro", "Favor preencher a cidade");
    } else if (paciente.uf == '') {
      _showErroPaciente("Erro", "Favor preencher a UF");
    } else if (paciente.cep == '') {
      _showErroPaciente("Erro", "Favor preencher o CEP.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              cadastrarPacienteNext3(usuario: usuario, paciente: paciente),
        ),
      );
    }
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
                            hintText: "Endereço descrição",
                            prefixIcon: Icon(Icons.app_registration),
                          ),
                          onSaved: (enderecoDescricao) =>
                              cadastrarPaciente['enderecoDescricao'] =
                                  enderecoDescricao ?? '',
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
                            hintText: "Logradouro",
                            prefixIcon: Icon(Icons.app_registration),
                          ),
                          onSaved: (logradouro) =>
                              cadastrarPaciente['logradouro'] =
                                  logradouro ?? '',
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
                              hintText: "Numero",
                              prefixIcon: Icon(Icons.art_track_outlined),
                            ),
                            onSaved: (numero) =>
                                cadastrarPaciente['numero'] = numero ?? ''),
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
                              hintText: "Complemento",
                              prefixIcon: Icon(Icons.all_inbox),
                            ),
                            onSaved: (complemento) =>
                                cadastrarPaciente['complemento'] =
                                    complemento ?? ''),
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
                              hintText: "Cidade",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (cidade) =>
                                cadastrarPaciente['cidade'] = cidade ?? ''),
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
                              hintText: "Uf",
                              prefixIcon: Icon(Icons.eleven_mp),
                            ),
                            onSaved: (uf) =>
                                cadastrarPaciente['uf'] = uf ?? ''),
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
                              hintText: "Cep",
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (cep) =>
                                cadastrarPaciente['cep'] = cep ?? ''),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _proximoContinuarCadastro(
                            widget.usuario, widget.paciente2),
                        child: const Text("PRÓXIMO"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text("VOLTAR"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () => _cancelarCadastro(widget.usuario),
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
