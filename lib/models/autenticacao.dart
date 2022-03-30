import 'dart:convert';
import 'dart:io';
import 'package:challenge_hmv/end_point/end_point.dart';
import 'package:challenge_hmv/models/paciente.dart';
import 'package:challenge_hmv/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:challenge_hmv/models/erro_tratado.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Autenticacao with ChangeNotifier {
  static const _url = URL_HMV + "/api/pacientes";
  static const _urlConsulta = "";

  salvaPrefs(
      String id, String nome, String email, String senha, String cpf) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ID", id);
    await prefs.setString("NOME", nome);
    await prefs.setString("EMAIL", email);
    await prefs.setString("SENHA", senha);
    await prefs.setString("CPF", cpf);

    print("Valores salvos na preferencia.:{$id} - {$nome} - {$email}");
  }

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

    print("URL => {$_url}");

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
    } else {
      print('Id criado => ${body['id_paciente']}');
      salvaPrefs(body['id_paciente'], nome, email, senha, cpf);
    }

    print(
        '################### Fim do cadastro registro ###########################');
  }

  Future<void> cadastroPacienteCompleto(
    Paciente paciente,
    Usuario usuario,
    String token,
  ) async {

    print(
        '################### Inicio do cadastro paciente ###########################');

    String _urlCadastroPaciente = URL_HMV + "/api/pacientes/" + usuario.id;

    print("URL => $_urlCadastroPaciente");


    final response = await http.patch(
      Uri.parse(_urlCadastroPaciente),
      headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $token"},
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode({
        "nome_completo": paciente.nome,
        "email": paciente.email,
        "nome_completo_mae": paciente.nomeMae,
        "nome_completo_pai": paciente.nomePai,
        "endereco": {
          "descricao": paciente.enderecoDescricao,
          "logradouro": paciente.logradouro,
          "numero": paciente.numero,
          "complemento": paciente.complemento,
          "cidade": paciente.cidade,
          "uf": paciente.uf,
          "cep": paciente.cep,
          "codigo_endereco": "d14fa628-a1cd-4c55-b7d2-b5c4995e94ae"
        },
        "telefone": {
          "codigo_pais": paciente.codPais,
          "codigo_area": paciente.codArea,
          "numero": paciente.telefone,
          "descricao": "celular"
        },
        "convenio": {
          "codigo": paciente.codConvenio,
          "descricao": paciente.desConvenio,
          "numero_carteira": paciente.numCartConvenio,
          "data_validade": "2024-01-01"
        }
      }),
    );
    final body = jsonDecode(response.body);

    print(body);

    // if (body['id_paciente'] == null) {
    //   throw ErroTratado('ERRO_CADASTRO');
    // } else {
    //   print('Id criado => ${body['id_paciente']}');
    //   salvaPrefs(body['id_paciente'], nome, email, senha, cpf);
    // }

    print(
        '################### Fim do cadastro paciente ###########################');
  }

  Future<void> autenticarUsuario(Usuario usuario) async {
    print(
        '################### Inicio da autenticacao ###########################');

    String _urlAutUsuario = URL_HMV + "/oauth/token";

    print("URL => {$_urlAutUsuario}");

    String username = USERNAME;
    String password = PASSWORD;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print(basicAuth);

    final response = await http.post(
      Uri.parse(_urlAutUsuario),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'authorization': basicAuth
      },
      body: ({
        "username": usuario.email,
        "password": usuario.senha,
        "grant_type": "password",
      }),
    );

    final body = jsonDecode(response.body);

    print(body);

    if (body['access_token'] == null) {
      throw ErroTratado('ERRO_AUTENTICAR');
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("TOKEN", body['access_token']);
    }

    print(
        '################### Fim da autenticacao ###########################');
  }

  Future<void> gerarToken(Usuario usuario) async {
    return autenticarUsuario(usuario);
  }

  Future<void> registrarPaciente(
      String nome, String cpf, String email, String senha) async {
    return registrar(nome, cpf, email, senha);
  }

  Future<void> registrarCadPacienteCompleto(
      Paciente paciente, Usuario usuario, String token) async {
    return cadastroPacienteCompleto(paciente, usuario, token);
  }

  Future<void> consultaPaciente() async {
    return consultaRegistro();
  }
}
