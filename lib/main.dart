import 'package:challenge_hmv/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:challenge_hmv/models/autenticacao.dart';

void main() {
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MyApp());
}

void initialization(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 0));
  await Future.delayed(const Duration(seconds: 0));
  await Future.delayed(const Duration(seconds: 0));
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    //Autenticacao autenticacao;
    //autenticacao.recuperarBancoDeDados();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Autenticacao(),
        )
      ],
      child: MaterialApp(
        //color: azulHmv,
        debugShowCheckedModeBanner: false,
        title: 'Login Design',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}