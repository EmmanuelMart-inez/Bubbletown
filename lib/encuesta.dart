import 'package:bubbletown_v1/models/encuesta_model.dart';
import 'package:bubbletown_v1/services/encuesta_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'notificaciones_page.dart';

Future<EncuestaModel> requestEncuesta;

class Encuesta extends StatefulWidget {
  final idEncuesta;
  final idNotificacion;

  @override
  const Encuesta(
      {Key key, @required this.idEncuesta, @required this.idNotificacion})
      : super(key: key);
  _EncuestaState createState() => _EncuestaState();
}

class _EncuestaState extends State<Encuesta> {
  int actualpage;
  int actualresp;
  String preguntabiertaResp;
  List<String> respuestas = [];
  final colorOn = '0xFF424242';
  final colorOff = '0xFF9E9E9E';
  var coloractual = '0xFF424242';

  // Valor del emoji seleccionado por el usuario
  String emojiselected;
  // Tamaño del emoji en animación para expander o no
  bool _bigger;

  @override
  void initState() {
    super.initState();
    coloractual = '0xFF424242';
    actualpage = 0;
    actualresp = -1;
    print(widget.idEncuesta);
    requestEncuesta = fetchEncuesta(widget.idEncuesta);
    respuestas = [];
    emojiselected = null;
    _bigger = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<EncuestaModel>(
      future: requestEncuesta,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                color: Color(0xFFDADADA),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xFFAAAAAA),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        if (actualpage == 0)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notificaciones()),
                          );
                        else
                          setState(() {
                            actualpage--;
                            respuestas.removeLast();
                          });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'anterior',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //FFDADADA
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: Text(
                          '${actualpage + 1} de ${snapshot.data.paginas.length}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Color(0xFFAAAAAA),
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        if (actualresp >= 0) {
                          if (actualpage + 1 < snapshot.data.paginas.length) {
                            // Si la pregunta es de tipo "abierta"
                            if (snapshot.data.paginas[actualpage].tipo ==
                                    'abierta' ||
                                snapshot.data.paginas[actualpage].tipo ==
                                    'emoji') {
                              print('Pregunta abierta');
                              setState(() {
                                actualpage++;
                                respuestas.add(preguntabiertaResp);
                                actualresp = -1;
                              });
                            }
                            // Si la respuesta es de opción múltiple
                            else {
                              setState(() {
                                actualpage++;
                                respuestas.add(snapshot.data.paginas[actualpage]
                                    .opciones[actualresp].calificacion);
                                actualresp = -1;
                              });
                            }
                          } else {
                            int resp;
                            // setState(() async {
                            // Si la respuesta es de opción múltiple pero no es la última
                            respuestas.add(snapshot.data.paginas[actualpage]
                                .opciones[actualresp].calificacion);
                            RespuestaEncuestaModel r = RespuestaEncuestaModel(
                                estado: "respondida", respuestas: respuestas);
                            String datajson = respuestaEncuestaModelToJson(r);

                            resp = await patchEncuesta(
                                datajson, '5e2f34a8db5584c6403a62df');

                            // });
                            if (resp == 200) {
                              //Eliminar de notificaciones la encuesta
                              try {
                                final response = await http.patch(
                                    'https://bubbletown.me/notificaciones/${widget.idNotificacion}');
                              } catch (e) {
                                print(e);
                              }
                              //
                              buildShowDialog(context, "Encuesta enviada",
                                  "Muchas gracias!", "Cerrar");
                            } else
                              buildShowDialog(
                                  context,
                                  "Ocurrio un error al procesar su solicitud",
                                  "Intente más tarde",
                                  "Ok");
                          }
                          ;
                        }
                        ;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'siguiente',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //FFDADADA
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('$respuestas'),
                    SizedBox(height: 45),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${snapshot.data.paginas[actualpage].titulo}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 45),
                    (() {
                      print('${snapshot.data.paginas[actualpage].tipo}');
                      switch ('${snapshot.data.paginas[actualpage].tipo}') {
                        case 'abierta':
                          {
                            return Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  color: Colors.white,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: 'Respuesta',
                                      alignLabelWithHint: true,
                                      icon: Icon(Icons.text_format),
                                    ),
                                    maxLines: 14,
                                    maxLength: 400,
                                    onChanged: (text) {
                                      setState(() {
                                        preguntabiertaResp = text;
                                        actualresp = 1;
                                      });
                                    },
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          }
                          break;
                        case 'opcion multiple':
                          {
                            return Column(
                              children: List.generate(
                                snapshot
                                    .data.paginas[actualpage].opciones.length,
                                (index) {
                                  return FlatButton(
                                    color: index == actualresp
                                        ? Color(int.parse('$colorOn'))
                                        : Color(int.parse('$colorOff')),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        actualresp = index;
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.centerLeft,
                                      height: 60,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35.0, right: 5),
                                            child: buildIconCheck(index),
                                          ),
                                          Text(
                                            '${snapshot.data.paginas[actualpage].opciones[index].calificacion}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          break;
                        case 'emoji':
                          {
                            return Column(
                              children: <Widget>[
                                // SizedBox(height: 40),
                                Row(
                                  children: <Widget>[
                                    emojiselected != null
                                        ? Expanded(
                                            child: AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              // onEnd: (){
                                              //   setState(() {
                                              //   _bigger = true;
                                              //   });
                                              // },
                                              height: _bigger ? 200 : 0,
                                              child: Image.network(
                                                '$emojiselected',
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 100,
                                          ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    snapshot.data.paginas[actualpage].opciones
                                        .length,
                                    (index) {
                                      return Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(8.0),
                                          iconSize: 100,
                                          onPressed: () {
                                            setState(() {
                                              emojiselected =
                                                  '${snapshot.data.paginas[actualpage].opciones[index].icon}';
                                              preguntabiertaResp =
                                                  '${snapshot.data.paginas[actualpage].opciones[index].calificacion}';
                                              actualresp = 1;
                                              _bigger = !_bigger;
                                            });
                                          },
                                          icon: Image.network(
                                            '${snapshot.data.paginas[actualpage].opciones[index].icon}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }

                          break;

                        default:
                          {
                            return SizedBox(
                              height: 1,
                            );
                          }
                          break;
                      }
                    }()),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 105,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/notif/background_encuesta.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            // heightFactor: 50,
            child: CircularProgressIndicator());
      },
    ));
  }

  Future buildShowDialog(BuildContext context, String titulo, String contenido,
      String textButton) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$titulo"),
          content: new Text("$contenido"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("$textButton"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notificaciones()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Icon buildIconCheck(index) {
    if (index == actualresp)
      return Icon(Icons.check, color: Colors.white, size: 30);
  }
}
