import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:bubbletown_v1/encuesta.dart';
import 'package:bubbletown_v1/services/notificaciones_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:image/image.dart' as Img;
import 'Storage/globals.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'models/notificaciones_model.dart';
import 'premios_page.dart';

Future<NotificacionesModel> requestNotif;

class Notificaciones extends StatefulWidget {
  @override
  const Notificaciones({Key key}) : super(key: key);
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  @override
  void initState() {
    super.initState();
    requestNotif = fetchNotificaciones();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false, // Used for removing back buttoon "<". 
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 10),
                    child: Text('Bubble\nTown', style: TextStyle(fontSize: 13)),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10, top: 10),
                  //   child: IconButton(
                  //     icon: Icon(Icons.menu, color: Colors.black, size: 30.0),
                  //     onPressed: () {},
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        endDrawer: DrawerHamburguerMenu(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.black),
                SizedBox(height: 5),
                Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 15),
                NotificacionesScrollList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 105,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 0.7, color: Colors.black),
          )),
          child: BottomNavigationBar(
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/inicio.png',
                  scale: 2,
                ),
                title: Text('Inicio',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/bar.png',
                  scale: 2,
                ),
                title: Text('Tarjeta',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/catalogo.png',
                  scale: 2,
                ),
                title: Text('Catálogo',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/premios.png',
                  scale: 2,
                ),
                title: Text('Premios',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
            ],
            onTap: (int index) {
              setState(() {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pago()),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Catalogo()),
                  );
                }
                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Premios()),
                  );
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

class NotificacionesScrollList extends StatefulWidget {
  @override
  _NotificacionesScrollListState createState() =>
      _NotificacionesScrollListState();
}

class _NotificacionesScrollListState extends State<NotificacionesScrollList> {
  void deleteItem(int indexCard, String id, List<Notificacione> n) async {
    print("index card $indexCard deleted");
    try {
      final response = await http.patch('$apiURL/notificaciones/${id}');
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        setState(() {
          n.removeAt(indexCard);
        });
        // return NotificacionesModel.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Error al eliminar, intente más tarde');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificacionesModel>(
      future: requestNotif,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.notificaciones.length);
          if (snapshot.data.notificaciones.length != null)
            return Column(
              children:
                  List.generate(snapshot.data.notificaciones.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: NotificacionCard(
                        listNotificaciones: snapshot.data.notificaciones,
                        index: index,
                        deleteItem: deleteItem,
                        id: snapshot.data.notificaciones[index].id,
                        // imageHeader:
                        // snapshot.data.notificaciones[index].imagenIcon,
                        imageHeader: changeImageFormatToUpper(snapshot.data
                            .notificaciones[index].idNotificacion.imagenIcon),
                        imagenDisplay: changeImageFormatToUpper(snapshot
                            .data
                            .notificaciones[index]
                            .idNotificacion
                            .imagenDisplay),
                        textHeader: snapshot
                            .data.notificaciones[index].idNotificacion.titulo,
                        body: snapshot
                            .data.notificaciones[index].idNotificacion.mensaje,
                        textAccion: snapshot
                            .data.notificaciones[index].idNotificacion.barText,
                        link: snapshot
                            .data.notificaciones[index].idNotificacion.link,
                        tipoNotificacion: snapshot.data.notificaciones[index]
                            .idNotificacion.tipoNotificacion),
                  ),
                );
              }),
            );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
    );
  }

  String changeImageFormatToUpper(String st) {
    String start;
    String format;
    String newString;

    // if (st.substring(st.length - 3).compareTo('PNG') > 0) {
    //   format = "PNG";
    //   start = st.substring(0, st.length - 3);
    //   newString = '$start$format';
    //   // print(newString);
    //   return newString;
    // } else
    //   return st;
    // print(st.substring(st.length - 4));
    if(st == null)
      return "$apiURL/download/transparent.png";
    if (st.substring(st.length - 4) == 'null' ) {
      return "$apiURL/download/transparent.png";
    } else
      return st;
  }
}

class NotificacionCard extends StatelessWidget {
  const NotificacionCard({
    Key key,
    this.index,
    this.id,
    this.imageHeader,
    this.imagenDisplay,
    this.textHeader,
    this.body,
    this.textAccion,
    this.link,
    this.tipoNotificacion,
    this.listNotificaciones,
    this.deleteItem,
  }) : super(key: key);

  final index;
  final id;
  final imageHeader;
  final imagenDisplay;
  final textHeader;
  final body;
  final textAccion;
  final link;
  final tipoNotificacion;
  final listNotificaciones;
  final deleteItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                // child: Container(
                //   height: 20,
                // width: 30,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  // child: Text('${this.imageHeader}'),
                  child: Image.network(
                    '${apiURLImages}/${this.imageHeader}',
                    height: 55.0,
                    width: 55.0,
                  ),
                ),
                // ),
              ),
              Container(
                width: 190,
                child: Text(
                  // 'Como estuvo tu bebida?',
                  '${this.textHeader}',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              IconButton(
                alignment: Alignment.topRight,
                icon: Icon(
                  Icons.close,
                  size: 24,
                ),
                onPressed: () => this
                    .deleteItem(this.index, this.id, this.listNotificaciones),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Text(
            // "Como estuvo tu bebida? Como estuvo tu bebida? Como estuvo tu bebida? Como estuvo tu bebida?",
            "${this.body}",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(fontSize: 14, height: 0.8),
          ),
        ),
        // SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(height: 3, color: Colors.black),
        ),
        OpcionalActionCardBar(
            textAccion: textAccion,
            link: link,
            id: id,
            tipoNotificacion: tipoNotificacion,
            imagenDisplay: imagenDisplay),
      ],
    );
  }
}

class OpcionalActionCardBar extends StatelessWidget {
  const OpcionalActionCardBar({
    Key key,
    @required this.textAccion,
    @required this.link,
    @required this.tipoNotificacion,
    @required this.id,
    @required this.imagenDisplay,
  }) : super(key: key);

  final textAccion;
  final link;
  final id;
  final tipoNotificacion;
  final imagenDisplay;

  @override
  Widget build(BuildContext context) {
    // TODO: Añadir aqui el la validación del ícono
    if (textAccion != null &&
        textAccion != "null" &&
        textAccion.toString().length > 0 && tipoNotificacion == 'encuesta')
      return FlatButton(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '${this.textAccion}',
                // '${this.textAccion}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/notif/check.png', scale: 4),
            ],
          ),
        ),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              // TODO: En un futuro agregar el imagen display en premios y notificaciones básicas
              if (tipoNotificacion == 'ninguna' || tipoNotificacion == 'premio')
                return Container(
                  child: AlertDialog(
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Image.network('$apiURLImages/${imagenDisplay}'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('SIGUIENTE'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              else
                return Encuesta(idEncuesta: this.link, idNotificacion: this.id);
            },
          ))
        },
      );
    else
      return SizedBox(
        height: 0.0,
      );
  }
}
