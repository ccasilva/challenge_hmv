import 'package:flutter/material.dart';

class Paciente {
  final String nome;
  final String email;
  final String nomeMae;
  final String nomePai;
  final String enderecoDescricao;
  final String logradouro;
  final String numero;
  final String complemento;
  final String cidade;
  final String uf;
  final String cep;
  final String codPais;
  final String codArea;
  final String telefone;
  final String desTelefone;
  final String codConvenio;
  final String desConvenio;
  final String numCartConvenio;
  final String datValidade;

  const Paciente({
    this.nome,
    this.email,
    this.nomeMae,
    this.nomePai,
    this.enderecoDescricao,
    this.logradouro,
    this.numero,
    this.complemento,
    this.cidade,
    this.uf,
    this.cep,
    this.codPais,
    this.codArea,
    this.telefone,
    this.desTelefone,
    this.codConvenio,
    this.desConvenio,
    this.numCartConvenio,
    this.datValidade,
  });
}
