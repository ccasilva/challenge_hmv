import 'package:challenge_hmv/data/dummy_paciente.dart';
import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class cadastrarPaciente extends StatefulWidget {
  const cadastrarPaciente({Key key}) : super(key: key);

  @override
  State<cadastrarPaciente> createState() => _cadastrarPacienteState();
}

class _cadastrarPacienteState extends State<cadastrarPaciente> {
  final List<Paciente> loadPaciente = DUMMY_PACIENTE;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> cadastrarPaciente = {
    'nome': '',
    'cpf': '',
    'email': '',
    'senha': '',
  };

  _submit(){}

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
                            hintText: "Data Nascimento",
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
                              hintText: "CPF",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (cpf) =>
                            cadastrarPaciente['cpf'] = cpf ?? ''),
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
                          onPressed: _submit,
                          child: const Text("CADASTRAR"),
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
