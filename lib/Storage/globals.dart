import 'package:flutter/material.dart';

//  Este es el identificador de usuario que se guarda como variable
//  global en el caso en el que no se tenga la funcionalidad de 
//  guardar en caché o preferencias el _id de participante
  String obid = "null";

  // Direccion del API
  // URL para ejecucion local:  https://github.com/hillelcoren/flutter-redux-starter/issues/16
  //            If you run AVD(Client)/spring boot, flask o whatever(Server), in same computer， 
  //            you have to set the apiUrl to "10.0.2.2:port/api" not  "localhost" or "127.0.0.0"
  // String apiURL = "http://10.0.2.2:5001";

  // Deployment server 
  String apiURL = "https://www.bubbletown.me";
  
  // Direccion del servidor de archivos para descargar imágenes
  String apiURLImages = "$apiURL/download"; 