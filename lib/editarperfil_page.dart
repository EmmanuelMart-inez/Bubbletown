//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/services/participante_service.dart';
import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'models/participante_model.dart';
import 'premios_page.dart';

Future<ParticipanteModel> requestParticipante;

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  @override
  void initState() {
    super.initState();
    requestParticipante = fetchParticipante('5e141e35bca2e7cee96804e7');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 5),
                    child: Text('Bubble\nTown', style: TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.black, size: 25.0),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.black),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 35),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFDADADA),
                        ),
                        child: FlatButton(
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Editar perfil', style: TextStyle(fontSize: 28)),
                  ],
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEBEBEB),
                      ),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder<ParticipanteModel>(
                                  future: requestParticipante,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                          height: 120,
                                          width: 120,
                                          child: Image.network(
                                              '${snapshot.data.foto}'));
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                                Text(
                                  'FOTO DE PERFIL',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          //TODO: Implementar funcion para subir imagenes
                        },
                      ),
                    ),
                    Positioned(
                      child: FlatButton(
                        child: Image.asset(
                          'assets/editarperfil/editarperfil.png',
                          scale: 3.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Color(0xFFDADADA),
                    border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.black),
                    ),
                  ),
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'NOMBRE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              FutureBuilder<ParticipanteModel>(
                                future: requestParticipante,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data.nombre}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios, size: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Color(0xFFDADADA),
                    border: Border(
                      bottom: BorderSide(width: 0.8, color: Colors.black),
                    ),
                  ),
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'CORREO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              FutureBuilder<ParticipanteModel>(
                                future: requestParticipante,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data.email}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios, size: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Color(0xFFDADADA),
                    border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.black),
                    ),
                  ),
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Contraseña',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                '*******',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios, size: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
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
