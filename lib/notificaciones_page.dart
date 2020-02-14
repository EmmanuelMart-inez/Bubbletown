import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:bubbletown_v1/encuesta.dart';
import 'package:bubbletown_v1/services/notificaciones_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificacionesModel>(
      future: requestNotif,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children:
                List.generate(snapshot.data.notificaciones.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.network(
                              '${changeImageFormatToUpper(snapshot.data.notificaciones[index].imagenIcon)}',
                              scale: 1),
                          Text(
                            '${snapshot.data.notificaciones[index].titulo}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          ButtonTheme(
                            minWidth: 4,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                try {
                                  final response = await http.patch(
                                      'https://bubbletown.me/notificaciones/${snapshot.data.notificaciones[index].id}');
                                  if (response.statusCode == 200) {
                                    // If the call to the server was successful, parse the JSON.
                                    setState(() {
                                      snapshot.data.notificaciones
                                          .removeAt(index);
                                    });
                                    return NotificacionesModel.fromJson(
                                        json.decode(response.body));
                                  } else {
                                    // If that call was not successful, throw an error.
                                    throw Exception(
                                        'Error al eliminar, intente más tarde');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(
                          "${snapshot.data.notificaciones[index].mensaje}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 35),
                      Divider(height: 3, color: Colors.black),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Responder',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            FlatButton(
                                onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Encuesta(idEncuesta: snapshot.data.notificaciones[index].link, idNotificacion: snapshot.data.notificaciones[index].id)),
                                      )
                                    },
                                child: Image.asset('assets/notif/check.png',
                                    scale: 4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  String changeImageFormatToUpper(String st) {
    String start;
    String format;
    String newString;
    if (st.substring(st.length - 3).compareTo('PNG') > 0) {
      format = "PNG";
      start = st.substring(0, st.length - 3);
      newString = '$start$format';
      // print(newString);
      return newString;
    } else
      return st;
  }
}
