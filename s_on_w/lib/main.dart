import 'package:flutter/material.dart';
import 'package:s_on_w/telas/Home.dart';

import 'Rotas.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9673FF),
  accentColor: Color(0xff9673FF)
);

void main() => runApp(MaterialApp(
  title: "Uber",
  home: Home(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Rotas.gerarRotas,
  debugShowCheckedModeBanner: false,
));
