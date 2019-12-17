import 'package:flutter/material.dart';
import 'package:s_on_w/telas/Cadastro.dart';
import 'package:s_on_w/telas/Home.dart';
import 'package:s_on_w/telas/PainelMotorista.dart';
import 'package:s_on_w/telas/PainelPassageiro.dart';

class Rotas {

  static Route<dynamic> gerarRotas(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      case "/painel-motorista" :
        return MaterialPageRoute(
            builder: (_) => PainelMotorista()
        );
      case "/painel-passageiro" :
        return MaterialPageRoute(
            builder: (_) => PainelPassageiro()
        );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );

  }

}