import 'package:agendadecontatos/helpers/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();


    //cadastrar

   Contact c = Contact();
    c.name = "pedro silva ";
    c.email = "pedro@gmail.com";
    c.phone = "(11)9.6666 - 666666";
    c.img = " imgtest2";

    helper.saveContact(c);



    //consultar os cadastros e apresentar no console
    helper.getAllContatcts().then((list){
      print(list);


    });

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
