//import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/editarperfil_page.dart';
import 'package:bubbletown_v1/encuesta.dart';
import 'package:bubbletown_v1/escanea_page.dart';
import 'package:bubbletown_v1/home_back_page.dart';
import 'package:bubbletown_v1/home_page.dart';
import 'package:bubbletown_v1/login.dart';
import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/micuenta_page.dart';
import 'package:bubbletown_v1/movimientos_page.dart';
import 'package:bubbletown_v1/notificaciones_page.dart';
import 'package:bubbletown_v1/premios_page.dart';
import 'package:bubbletown_v1/signup_page.dart';
import 'package:bubbletown_v1/slideSwitch.dart';
//import 'package:bubbletown_v1/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'catalogo_page.dart';
import 'encuestaopen_page.dart';
//import 'login.dart';
//import 'loginform_page.dart';
//import 'signup_page.dart';
import 'home_page.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
 } 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BubbleApp',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: 'Nunito',
        ),
        home: HomePage());
  }
}
