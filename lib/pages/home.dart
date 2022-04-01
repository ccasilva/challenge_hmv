import 'package:challenge_hmv/models/usuario.dart';
import 'package:challenge_hmv/pages/cadastrar_paciente.dart';
import 'package:challenge_hmv/pages/solicita_atendimento_emergencia.dart';
import 'package:challenge_hmv/utils/color.dart';
import 'package:flutter/material.dart';
import 'bottombar.dart';
import 'hexacolorcode.dart';

class Home extends StatefulWidget {
  final Usuario usuario;

  const Home({Key key, @required Usuario this.usuario}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConvert('edf0f3'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            informativoPaciente(context, this.widget.usuario),
            opcoesDoPaciente(context, this.widget.usuario),
            textoInformativo(context)
          ],
        ),
      ),
      bottomNavigationBar: bottombar(),
    );
  }
}

Widget informativoPaciente(BuildContext context, Usuario usuario) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
          bottom: MediaQuery.of(context).size.height * 0.020,
          left: MediaQuery.of(context).size.width * 0.050,
          right: MediaQuery.of(context).size.width * 0.050,
        ),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.060,
          left: MediaQuery.of(context).size.width * 0.040,
          bottom: MediaQuery.of(context).size.height * 0.030,
          right: MediaQuery.of(context).size.width * 0.020,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bom dia!",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12.0),
              child: Text(usuario.nome,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold)),
            ),
            const Text(
              "Você ainda não realizou nenhuma consulta.",
              style: TextStyle(
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
      const Positioned(
        left: 262,
        top: 50,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              "https://voxnews.com.br/wp-content/uploads/2017/04/unnamed.png"),
        ),
      )
    ],
  );
}

Widget textoInformativo(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.020,
      bottom: MediaQuery.of(context).size.height * 0.050,
      left: MediaQuery.of(context).size.width * 0.050,
      right: MediaQuery.of(context).size.width * 0.050,
    ),
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.030,
      left: MediaQuery.of(context).size.width * 0.040,
      bottom: MediaQuery.of(context).size.height * 0.090,
      right: MediaQuery.of(context).size.width * 0.020,
    ),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 0, color: Colors.white),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text("Atenção",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ),
        Text(
          "Seu cadastro ainda não foi finalizado. Sem ele não é possivel iniciar um atendimento.",
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

Widget doctoroptions(BuildContext context, Color colors, String img, text) {
  return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors,
        border: Border.all(width: 0, color: Colors.white),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.050,
      ),
      width: 120,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image(image: AssetImage(img)),
          Row(
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          )
        ],
      ),);
}

Widget opcoesDoPaciente(BuildContext context, Usuario usuario) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cadastrarPaciente(usuario: usuario)),
            );
          },
          child: doctoroptions(context, colorConvert('#e03468'),
              "assets/images/icon/Hospital_Icon1.png", "CADASTRO"),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => solicitaAtendimentoEmergencia(usuario: usuario)),
            );
          },
          child: doctoroptions(
              context, azulHmv, "assets/images/icon/icon1.png", " SOLICITAR \n ATENDIMENTO"),
        ),
        doctoroptions(context, colorConvert('#eb7a31'),
            "assets/images/icon/icon3.png", "MENSAGENS"),
        doctoroptions(context, colorConvert('#ee492a'),
            "assets/images/icon/icon4.png", " ACOMPANHAR \n FILA"),
      ],
    ),
  );
}
