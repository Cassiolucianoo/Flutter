import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _inforTexto = "Informe seus dados";

  void _limparCampos() {
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      _inforTexto = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        _inforTexto = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _inforTexto = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _inforTexto = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _inforTexto = "Obsidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _inforTexto = "Obsidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _inforTexto = "Obsidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _limparCampos();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.purple),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe seu Altura(cm)!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcularImc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.purple,
                  ),
                ),
              ),
              Text(
                _inforTexto,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}




