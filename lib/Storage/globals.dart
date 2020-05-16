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

// Colores para personalizar el tema del app
// String primary = "#F9F3B8";
// String secondary = "#F9F3B8";
// String tertiary = "#F9F3B8";
// String quaternary = "#F9F3B8";

// Paleta de colores
List<List<String>> colorPalette = [
  ["DEB5D5", "F9F3B8", "B5D590", "B8CCE1"],
  ["142850", "27496d", "00909e", "dae1e7"],
  ["ffcfdf", "fefdca", "e0f9b5", "a5dee5"],
  ["f4eeff", "dcd6f7", "a6b1e1", "424874"],
  ["beebe9", "f4dada", "ffb6b9", "f6eec7"],
  ["a8e6cf", "dcedc1", "ffd3b6", "ffaaa5"],
  ["ffb6b6", "fde2e2", "aacfcf", "679b9b"],
  ["204051", "3b6978", "84a9ac", "cae8d5"],
  ["4f3961", "ea728c", "fc9d9d", "f3d4d4"],
  ["f3d1f4", "f5fcc1", "bae5e5", "98d6ea"],
];

// Color elegido por el participante (index)
int userPalette = 0;
