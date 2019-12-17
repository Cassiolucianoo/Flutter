import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  final _adiconarcontroler = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic> _removeIntem;
  int _removeIntemPos;

  void _adicionar() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = _adiconarcontroler.text;
      _adiconarcontroler.text = "";
      newTodo["Certo"] = false;
      _toDoList.add(newTodo);
      _saveDate();
    });
  }

  Future<Null> _atualizar() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a["Certo"] && !b["Certo"])
          return 1;
        else if (!a["Certo"] && b["Certo"])
          return -1;
        else
          return 0;
      });
      _saveDate();
    });
    return null;
  }

  @override
  void initState() {
    super.initState();

    _readDate().then((date) {
      setState(() {
        _toDoList = json.decode(date);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista De Compras"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 17.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _adiconarcontroler,
                    decoration: InputDecoration(
                        labelText: "Nova Compra",
                        labelStyle: TextStyle(color: Colors.orangeAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text("Incluir produto"),
                  textColor: Colors.white,
                  onPressed: _adicionar,
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _atualizar,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  // ignore: missing_return
                  itemBuilder: buildProdutos),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProdutos(BuildContext context, int index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.amberAccent,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          title: Text(_toDoList[index]["title"]),
          value: _toDoList[index]["Certo"],
          secondary: CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Icon(
              _toDoList[index]["Certo"] ? Icons.check : Icons.error,
              color: Colors.red,
            ),
          ),
          onChanged: (c) {
            setState(() {
              _toDoList[index]["Certo"] = c;
              _saveDate();
            });
          },
        ),
        onDismissed: (direction) {
          setState(() {
            _removeIntem = Map.from(_toDoList[index]);
            _removeIntemPos = index;
            _toDoList.removeAt(index);

            _saveDate();

            final snack = SnackBar(
              content: Text("Produto \"${_removeIntem["title"]} \" Excluido. "),
              action: SnackBarAction(
                  label: " Não Excluir",
                  onPressed: () {
                    setState(() {
                      _toDoList.insert(_removeIntemPos, _removeIntem);
                      _saveDate();
                    });
                  }),
              duration: Duration(seconds: 2),
            );
            Scaffold.of(context).removeCurrentSnackBar();    // ADICIONE ESTE COMANDO
            Scaffold.of(context).showSnackBar(snack);
          });
        });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveDate() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readDate() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
