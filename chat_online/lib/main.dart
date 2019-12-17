import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{

  //-------------------consultando conteudo do firebase com nomes

  /*DocumentSnapshot snapshot = await Firestore.instance.collection("Usuarios").document("Cassio123").get();
  print(snapshot.data);
}*/


  //-------------------print em contedois da tabela do banco

  /*QuerySnapshot snapshot = await Firestore.instance.collection("Usuarios").getDocuments();

  for (DocumentSnapshot doc in snapshot.documents){

    //printando documentos id
    print(doc.documentID);

    //priontando os dados
    print(doc.data);
  }*/

  Firestore.instance.collection("mensagens").snapshots().listen((snapshot){

    for(DocumentSnapshot doc in snapshot.documents){
     print(doc.data);
    }
  });



  runApp(MyApp());

}






class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Container();

  }
}