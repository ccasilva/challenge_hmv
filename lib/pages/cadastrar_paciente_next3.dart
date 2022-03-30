import 'package:challenge_hmv/models/autenticacao.dart';
import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/home.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    'codPais': '',
    'codArea': '',
    'telefone': '',
    'desTelefone': '',
    'codConvenio': '',
    'desConvenio': '',
    'numCartConvenio': '',
    'datValidade': '',
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

  void _showPacienteSucesso(String titulo, String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _salvarDadosDoPaciente(
      Usuario usuario, Paciente paciente2) async {
    _formKey.currentState?.save();
    Autenticacao autenticar = Provider.of(context, listen: false);
    String _token;

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
      codPais: cadastrarPaciente['codPais'],
      codArea: cadastrarPaciente['codArea'],
      telefone: cadastrarPaciente['telefone'],
      desTelefone: cadastrarPaciente['desTelefone'],
      codConvenio: cadastrarPaciente['codConvenio'],
      desConvenio: cadastrarPaciente['desConvenio'],
      numCartConvenio: cadastrarPaciente['numCartConvenio'],
      datValidade: cadastrarPaciente['datValidade'],
    );

    if (paciente.codArea == '') {
      _showErroPaciente("Erro", "Favor, preencher o código da Area");
    } else if (paciente.codPais == '') {
      _showErroPaciente("Erro", "Favor, preencher o código do pais");
    } else if (paciente.telefone == '') {
      _showErroPaciente("Erro", "Favor, preencher o telefone");
    } else if (paciente.codConvenio == '') {
      _showErroPaciente("Erro", "Favor, preencher o código do convênio.");
    } else if (paciente.desConvenio == '') {
      _showErroPaciente("Erro", "Favor, preencher a descrição do convênio.");
    } else if (paciente.numCartConvenio == '') {
      _showErroPaciente(
          "Erro", "Favor, preencher o número da carteira do convênio.");
    } else if (paciente.datValidade == '') {
      _showErroPaciente(
          "Erro", "Favor, preencher a data de validade convênio.");
    } else {
      try {
        await autenticar.gerarToken(usuario);
        //await autenticar.registrarCadPacienteCompleto (paciente, usuario);
        //_showPacienteSucesso('Aviso','Registro cadastro com sucesso!');
        print("Finalizou!");
      } catch (e) {
        _showErroRegPaciente('Erro ao autenticar', e.toString());
      }

      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _token = prefs.getString("TOKEN");
      });

      try {
        await autenticar.registrarCadPacienteCompleto(
          paciente,
          usuario,
          _token,
        );
        //_showPacienteSucesso('Aviso','Registro cadastro com sucesso!');
        print("Finalizou!");
      } catch (e) {
        _showErroRegPaciente('Erro ao autenticar', e.toString());
      }
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
                            hintText: "Codigo do pais",
                            prefixIcon: Icon(Icons.art_track_outlined),
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
                            prefixIcon: Icon(Icons.art_track_outlined),
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
                              prefixIcon: Icon(Icons.add_call),
                            ),
                            onSaved: (telefone) =>
                                cadastrarPaciente['telefone'] = telefone ?? ''),
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
                      //         hintText: "Descrição",
                      //         prefixIcon: Icon(Icons.app_registration),
                      //       ),
                      //       onSaved: (desTelefone) =>
                      //           cadastrarPaciente['desTelefone'] =
                      //               desTelefone ?? ''),
                      // ),
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
                              prefixIcon: Icon(Icons.add_box_outlined),
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
                              prefixIcon: Icon(Icons.add_chart),
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
                              prefixIcon: Icon(Icons.article_outlined),
                            ),
                            onSaved: (numCartConvenio) =>
                                cadastrarPaciente['numCartConvenio'] =
                                    numCartConvenio ?? ''),
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
                              hintText: "Data de validade do convenio",
                              prefixIcon: Icon(Icons.date_range),
                            ),
                            onSaved: (datValidade) =>
                                cadastrarPaciente['datValidade'] =
                                    datValidade ?? ''),
                      ),
                      const SizedBox(height: 20),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () => _salvarDadosDoPaciente(
                              widget.usuario, widget.paciente),
                          child: const Text("SALVAR"),
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
                        onPressed: () {},
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
