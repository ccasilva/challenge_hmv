import 'package:challenge_hmv/data/dummy_paciente.dart';
import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/cadastrar_paciente_next3.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class cadastrarPacienteNext2 extends StatefulWidget {

  final Usuario usuario;
  const cadastrarPacienteNext2({Key key, @required Usuario this.usuario}) : super(key: key);

  @override
  State<cadastrarPacienteNext2> createState() => _cadastrarPacienteNext2State();
}

class _cadastrarPacienteNext2State extends State<cadastrarPacienteNext2> {
  final List<Paciente> loadPaciente = DUMMY_PACIENTE;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> cadastrarPaciente = {
    'nome': '',
    'cpf': '',
    'email': '',
    'senha': '',
  };

  _proximoContinuarCadastro(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => cadastrarPacienteNext3(usuario: this.widget.usuario)),
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
                            hintText: "Endereço descrição",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (enderecoDescricao) =>
                          cadastrarPaciente['enderecoDescricao'] = enderecoDescricao ?? '',
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
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (logradouro) =>
                          cadastrarPaciente['logradouro'] = logradouro ?? '',
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
                              prefixIcon: Icon(Icons.app_registration),
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
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (complemento) =>
                            cadastrarPaciente['complemento'] = complemento ?? ''),
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
                              prefixIcon: Icon(Icons.app_registration),
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
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (cep) =>
                            cadastrarPaciente['cep'] = cep ?? ''),
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
                          onPressed: _proximoContinuarCadastro,
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
                        onPressed: _proximoContinuarCadastro,
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
                      ),const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: _proximoContinuarCadastro,
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
