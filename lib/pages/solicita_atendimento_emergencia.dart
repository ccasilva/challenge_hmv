import 'package:challenge_hmv/models/autenticacao.dart';
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
  int wDor;
  int wnivelDor;
  int wsintoma1;
  int wsintoma2;
  int whabito1;
  int whabito2;
  int wtraumatico1;

  List<DropdownMenuItem<int>> _listaItensDores1 = List();
  List<DropdownMenuItem<int>> _listaItensDores2 = List();
  List<DropdownMenuItem<int>> _listaItensTraumaticos1 = List();
  List<DropdownMenuItem<int>> _listaItensTraumaticos2 = List();
  List<DropdownMenuItem<int>> _listaItensItensAssoDor1 = List();
  List<DropdownMenuItem<int>> _listaItensItensAssoDor2 = List();
  List<DropdownMenuItem<int>> _listaItensSintomas1 = List();
  List<DropdownMenuItem<int>> _listaItensSintomas2 = List();
  List<DropdownMenuItem<int>> _listaItensHabitos1 = List();
  List<DropdownMenuItem<int>> _listaItensHabitos2 = List();

  Map<String, String> parametrosSolEmergencia = {
    'relatoPaciente': '',
    'dor': '',
    'nivelDor': '',
    'sintoma1': '',
    'sintoma2': '',
    'habito1': '',
    'habito2': '',
    'traumatico1': '',
    'traumatico2': '',

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

  void _showAtendimento(String titulo, String msg, Usuario usuario) {
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

  Future<void> _solicitaAtendimentoEmergencia() async {

    print('Entrou aqui');
    _formKey.currentState?.save();
    Autenticacao autenticar = Provider.of(context, listen: false);
    String _token;

    print('wDor {$wDor}');
    print('wnivelDor {$wnivelDor}');
    print('wsintoma1 {$wsintoma1}');
    print('wsintoma2 {$wsintoma2}');
    print('whabito1 {$whabito1}');
    print('whabito2 {$whabito2}');
    print('wtraumatico1 {$wtraumatico1}');
    print(parametrosSolEmergencia['relatoPaciente']);


    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("TOKEN");
    });

    _showAtendimento('Aviso','Solicitacão de atendimento enviada com sucesso!', widget.usuario);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregaItensDoresDropdown();
    _carregaItensSintomasDropdown();
    _carregaItensHabitosDropdown();
    _carregaItensEveTraumaticosDropdown();
    _carregaItensItensAssoDorDropdown();
  }

  _carregaItensItensAssoDorDropdown(){
    _listaItensItensAssoDor1.add(
        const DropdownMenuItem(child: Text("Ligeira"), value: 1)
    );
    _listaItensItensAssoDor1.add(
        const DropdownMenuItem(child: Text("Moderada"), value: 2)
    );
    _listaItensItensAssoDor1.add(
        const DropdownMenuItem(child: Text("Intensa"), value: 3)
    );
    _listaItensItensAssoDor1.add(
        const DropdownMenuItem(child: Text("Maxima"), value: 4)
    );
    _listaItensItensAssoDor2 = _listaItensItensAssoDor1;
  }

  _carregaItensEveTraumaticosDropdown(){
    _listaItensTraumaticos1.add(
        const DropdownMenuItem(child: Text("Qd de aviao"), value: 1)
    );
    _listaItensTraumaticos1.add(
        const DropdownMenuItem(child: Text("Qd da escada"), value: 3)
    );
    _listaItensTraumaticos1.add(
        const DropdownMenuItem(child: Text("Qd de moto"), value: 1)
    );
    _listaItensTraumaticos1.add(
        const DropdownMenuItem(child: Text("atropelamento"), value: 1)
    );
  }

  _carregaItensHabitosDropdown(){
    _listaItensHabitos1.add(
        const DropdownMenuItem(child: Text("fumante"), value: 1)
    );
    _listaItensHabitos1.add(
        const DropdownMenuItem(child: Text("Corrida"), value: 2)
    );
    _listaItensHabitos2 = _listaItensHabitos1;
  }

  _carregaItensSintomasDropdown(){
    _listaItensSintomas1.add(
        const DropdownMenuItem(child: Text("febre"), value: 3)
    );
    _listaItensSintomas1.add(
        const DropdownMenuItem(child: Text("dor de cabeca"), value: 1)
    );
    _listaItensSintomas1.add(
        const DropdownMenuItem(child: Text("dor no peito"), value: 2)
    );
    _listaItensSintomas2 = _listaItensSintomas1;
  }

  _carregaItensDoresDropdown(){
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("Braços"), value: 1)
    );
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("Pernas"), value: 2)
    );
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("Barriga"), value: 3)
    );
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("Peitoral"), value: 4)
    );
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("costas"), value: 5)
    );
    _listaItensDores1.add(
        const DropdownMenuItem(child: Text("Cabeça"), value: 6)
    );

    _listaItensDores2 = _listaItensDores1;
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
                          onSaved: (relatoPaciente) =>
                          parametrosSolEmergencia['relatoPaciente'] = relatoPaciente ?? '',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                value: wDor,
                                iconSize: 15,
                                onChanged: (dor) {
                                  setState(() {
                                    wDor = dor ?? '';
                                  });
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
                                items: _listaItensDores1,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                value: wnivelDor,
                                iconSize: 15,
                                onChanged: (nivelDor) {
                                  setState(() {
                                    wnivelDor = nivelDor ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Nivel da dor',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione';
                                },
                                items: _listaItensItensAssoDor1,

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
                                value: wsintoma1,
                                iconSize: 15,
                                onChanged: (sintoma1) {
                                  setState(() {
                                    wsintoma1 = sintoma1 ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Sintomas',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione';
                                },
                                items: _listaItensSintomas1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                value: wsintoma2,
                                iconSize: 15,
                                onChanged: (sintoma2) {
                                  setState(() {
                                    wsintoma2 = sintoma2 ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Sintomas',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione';
                                },
                                items: _listaItensSintomas1,
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
                                value: whabito1,
                                iconSize: 15,
                                onChanged: (habito1) {
                                  setState(() {
                                    whabito1 = habito1 ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Habitos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione';
                                },
                                items: _listaItensHabitos1,

                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField<int>(
                                value: whabito2,
                                iconSize: 15,
                                onChanged: (habito2) {
                                  setState(() {
                                    whabito2 = habito2 ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Habitos',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15))),
                                validator: (value) {
                                  return 'Selecione';
                                },
                                items: _listaItensHabitos1,

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
                                  value: wtraumatico1,
                                  iconSize: 15,
                                  onChanged: (traumatico1) {
                                    setState(() {
                                      wtraumatico1 = traumatico1 ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Traumaticos',
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15))),
                                  validator: (value) {
                                    return 'Selecione';
                                  },
                                  items: _listaItensTraumaticos1,

                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: _solicitaAtendimentoEmergencia,
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
