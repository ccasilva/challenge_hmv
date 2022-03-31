import 'package:challenge_hmv/models/autenticacao.dart';
import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class solicitaAtendimentoEmergencia extends StatefulWidget {
  final Usuario usuario;

  const solicitaAtendimentoEmergencia({
    Key key,
    @required Usuario this.usuario,
  }) : super(key: key);

  @override
  State<solicitaAtendimentoEmergencia> createState() =>
      _solicitaAtendimentoEmergenciaState();
}

class _solicitaAtendimentoEmergenciaState
    extends State<solicitaAtendimentoEmergencia> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<DropdownMenuItem<int>> _listaItensDores = List();
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

  void _showPacienteSucesso(String titulo, String msg, Usuario usuario) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(usuario: usuario)),
              );
            },
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
    List<DropdownMenuItem<String>> _listaItensDores1 = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];

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

        _showPacienteSucesso(
            'Aviso', 'Paciente cadastrado com sucesso!', usuario);
      } catch (e) {
        _showErroRegPaciente('Erro ao autenticar', e.toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregaItensDoresDropdown();
  }

  _carregaItensDoresDropdown(){
    _listaItensDores.add(
      DropdownMenuItem(child: Text("Dor1"), value: 1)
    );

    _listaItensDores.add(
        DropdownMenuItem(child: Text("Dor2"), value: 2)
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
                            hintText: "Relato motivo do paciente",
                            prefixIcon: Icon(Icons.art_track_outlined),
                          ),
                          onSaved: (codPais) =>
                              cadastrarPaciente['codPais'] = codPais ?? '',
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de dores',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de dores',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de Sintomas',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de Sintomas',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de habitos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lista de habitos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Eventos traumaticos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                iconSize: 25,
                                onChanged: (valor){
                                  print("Valor drop: $valor");
                                },
                                decoration: InputDecoration(
                                    labelText: 'Eventos traumaticos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione uma categoria';
                                },
                                items: _listaItensDores,

                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () => {},
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
                      //const SizedBox(height: 5),
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: const Text("VOLTAR"),
                      //   style: ElevatedButton.styleFrom(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(90),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 120,
                      //       vertical: 10,
                      //     ),
                      //   ),
                      // ),
                      //const SizedBox(height: 5),
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
