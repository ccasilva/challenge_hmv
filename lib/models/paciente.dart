import 'package:flutter/material.dart';

class Paciente {
  final String id;
  final String nome;
  final String dataNascimento;
  final String cpf;
  final String telefone;
  final String convenio;
  final String idCarteiraConvenio;
  final String dtCarteiraConvenio;
  final String email;
  final String avatarUrl;

  const Paciente({
    this.id,
    @required this.nome,
    @required this.dataNascimento,
    @required this.cpf,
    @required this.telefone,
    @required this.convenio,
    @required this.idCarteiraConvenio,
    @required this.dtCarteiraConvenio,
    @required this.email,
    @required this.avatarUrl,
  });
}
