import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class cadastrarPacienteNext3 extends StatefulWidget {
  final Usuario usuario;
  final Paciente paciente;

  const cadastrarPacienteNext3({
    Key key,
    @required Usuario this.usuario,
    @required Paciente this.paciente,
  }) : super(key: key);

  @override
  State<cadastrarPacienteNext3> createState() => _cadastrarPacienteNext3State();
}

class _cadastrarPacienteNext3State extends State<cadastrarPacienteNext3> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, String> cadastrarPaciente = {
    'nome': '',
    'cpf': '',
    'email': '',
    'senha': '',
  };

  _proximoContinuarCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              cadastrarPacienteNext3(usuario: this.widget.usuario)),
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
                            hintText: "Codigo do pais",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (codPais) =>
                              cadastrarPaciente['codPais'] = codPais ?? '',
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
                            hintText: "Codigo da area",
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (codArea) =>
                              cadastrarPaciente['codArea'] = codArea ?? '',
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
                              hintText: "Telefone",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (telefone) =>
                                cadastrarPaciente['telefone'] = telefone ?? ''),
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
                              hintText: "Descrição",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (desTelefone) =>
                                cadastrarPaciente['desTelefone'] =
                                    desTelefone ?? ''),
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
                              hintText: "Codigo do convenio",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (codConvenio) =>
                                cadastrarPaciente['codConvenio'] =
                                    codConvenio ?? ''),
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
                              hintText: "Descrição do convenio",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (desConvenio) =>
                                cadastrarPaciente['desConvenio'] =
                                    desConvenio ?? ''),
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
                              hintText: "Numero da carteira convenio",
                              prefixIcon: Icon(Icons.app_registration),
                            ),
                            onSaved: (numCartConvenio) =>
                                cadastrarPaciente['numCartConvenio'] =
                                    numCartConvenio ?? ''),
                      ),
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
                      ),
                      const SizedBox(height: 5),
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
