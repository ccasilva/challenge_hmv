import 'dart:convert';

import 'package:challenge_hmv/models/erro_tratado.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Autenticacao with ChangeNotifier {
  static const _url = "http://127.0.0.1:8081/api/pacientes/";
  static const _urlConsulta =
      "http://127.0.0.1:8081/api/pacientes/035df5cb-c542-43ba-9249-7ead0381c0e8";

  Future<void> consultaRegistro() async {
    try {
      print(
          '################### Inicio da consulta registro ###########################');

      final response = await http.get(
        Uri.parse(_urlConsulta),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
      );
      print('Consulta:');
      print(jsonDecode(response.body));
    } catch (e) {
      print('Erro ao conectar - $e');
    } finally {
      print(
          '################### Fim da consulta registro ###########################');
    }
  }

  Future<void> registrar(
      String nome, String cpf, String email, String senha) async {
      print(
          '################### Inicio do cadastro registro ###########################');

      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode({
          "primeiro_nome": nome,
          "data_nascimento": "2022-03-20T23:02:40.17",
          "cpf": cpf,
          "email": email,
          "senha": senha,
        }),
      );
      final body = jsonDecode(response.body);

      print(body);

      if (body['id_paciente'] == null) {
        throw ErroTratado('ERRO_CADASTRO');
      }else{
        print('Id criado => ${body['id_paciente']}');
      }

      print(
          '################### Fim do cadastro registro ###########################');
  }

  Future<void> registrarPaciente(
      String nome, String cpf, String email, String senha) async {
    return registrar(nome, cpf, email, senha);
  }

  Future<void> consultaPaciente() async {
    return consultaRegistro();
  }
}
