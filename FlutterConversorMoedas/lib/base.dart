import 'package:flutter/material.dart';

//biblioteca que permite as requisições
import 'package:http/http.dart' as http;
//requisição sem espera
import 'dart:async';
//converter os dados em json
import 'dart:convert';

//url da requisição do servidor
const request = "https://api.hgbrasil.com/finance?format=json-cors&key=ff5b8457";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.green,
        primaryColor: Colors.white
    ),
  ));
}

Future<Map> getData() async {

  //solicitando  resposta do servidor     //aguardar  resposta do servidor
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //controladores para obter os textos dos filds
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  //declarar as variaveis para receber os valores
  double dolar;
  double euro;

  //limpar todos os campos
  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text){
    if(text.isEmpty) {//se texto estiver em branco ele chama o metodo limpar
      _clearAll();
      return;
    }
    double real = double.parse(text);//pegando texto e transformando em double
    dolarController.text = (real/dolar).toStringAsFixed(2);  // tosString retorna apenas 2 campos
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty) {//se texto estiver em branco ele chama o metodo limpar
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);//pegando os valores das this.variavel e
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty) {//se texto estiver em branco ele chama o metodo limpar
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//item que permite incluir a barra no top e +
        backgroundColor: Colors.black,//fundo
        appBar: AppBar(//barra do aplicativo
          title: Text(" Converter Grana "), // titulo da barra se colocar "\$" use  \

          backgroundColor: Colors.green,//cor da barra
          centerTitle: true,//alinha texto no meio
        ),
        body: FutureBuilder<Map>(//retorna um dado do futuro
            future: getData(), //definição qual futuro ele construa get Data
            builder: (context, snapshot) {
              switch(snapshot.connectionState){//status da conexão
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregar Conteudo.... Aguarde",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 25.0),
                        textAlign: TextAlign.center,)  //alinhamento de texto
                  );
                default:
                  if(snapshot.hasError){//se o servidor não apresentarnada erro
                    return Center(
                        child: Text("Erro ! Algo Deu Errado",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 25.0),
                          textAlign: TextAlign.center,)
                    );
                  } else {//caso não tenha nenhum erro ele apresenta os dados api json
                    dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(//para a tela ficar com scroll
                      padding: EdgeInsets.all(10.0),//
                      child: Column(//colocando tudo em colunas
                        crossAxisAlignment: CrossAxisAlignment.stretch,//ocupar a linha toda cada objeto
                        children: <Widget>[
                          Icon(Icons.monetization_on, size: 150.0, color: Colors.green),
                          buildTextField("Reais", "R\$", realController, _realChanged),
                          Divider(),
                          buildTextField("Dólares", "US\$", dolarController, _dolarChanged),
                          Divider(),
                          buildTextField("Euros", "€", euroController, _euroChanged),
                        ],
                      ),
                    );
                  }
              }
            })
    );
  }
}
//evitar repetir codigo de campos iguais dentro da função
Widget buildTextField(String label, String prefix, TextEditingController c, Function f){
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),//cor do texto das label
        border: OutlineInputBorder(),//bordas entre as linhas
        prefixText: prefix
    ),
    style: TextStyle(
        color: Colors.green, fontSize: 25.0
    ),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),//só aceita numeros dentro dos campos
  );
}







