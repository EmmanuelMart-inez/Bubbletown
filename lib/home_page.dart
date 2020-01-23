//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/catalogo_page.dart';
import 'package:bubbletown_v1/escanea_page.dart';
import 'package:bubbletown_v1/micuenta_page.dart';
import 'package:bubbletown_v1/premios_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:provider/provider.dart';

import 'ayuda_page.dart';
import 'models/welcome_model.dart';
import 'services/welcome_service.dart';
import 'notificaciones_page.dart';

Future<Welcome> requestWelcome;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    requestWelcome = fetchWelcome();
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
              child: new DefaultHeaderWidget(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new MiCuentaWidget(),
                    new NotificacionesWidget(),
                  ],
                ),
                //SizedBox(height: 25),
                new WelcomeWidget(),
                Image.asset('assets/bubbliehappy.png', scale: 1),
                FutureBuilder<Welcome>(
                  future: requestWelcome,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BubbleCardSellosWidget(
                          numeroSellos: snapshot
                              .data.participante.tarjetaSellos.numSellos,
                          totalSellos: 8);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                new DetallesWidget(),
                new PagarWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBarWidget(context),
      ),
    );
  }

  Container buildBottomNavigationBarWidget(BuildContext context) {
    return Container(
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
    );
  }
}

class DefaultHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 18, top: 10),
          child: Text('Bubble\nTown', style: TextStyle(fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 30.0),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<Welcome>(
            future: requestWelcome,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    Text(
                        snapshot.data.participante.sexo == 'Masculino'
                            ? 'Bienvenido '
                            : 'Bienvenida ',
                        style: TextStyle(fontSize: 32)),
                    Container(
                      width: 180,
                      child: Text(
                        '${snapshot.data.participante.nombre}',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(fontSize: 32, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

class PagarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 110,
          padding: const EdgeInsets.only(right: 28.0),
          child: FlatButton(
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(' Redimir puntos', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 8),
                      Text(' Pagar', style: TextStyle(fontSize: 28)),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('saldo',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.green[400])),
                          FutureBuilder<Welcome>(
                            future: requestWelcome,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    '${snapshot.data.participante.tarjetaPuntos.balance.round()}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.green[400]));
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Text('bubblies', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Image.asset('assets/credit-card.png', scale: 3.5)
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pago()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DetallesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Detalles',
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ayuda()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BubbleCardSellosWidget extends StatefulWidget {
  BubbleCardSellosWidget({this.numeroSellos, this.totalSellos});
  final numeroSellos;
  final totalSellos;

  @override
  _BubbleCardSellosWidgetState createState() => _BubbleCardSellosWidgetState();
}

class _BubbleCardSellosWidgetState extends State<BubbleCardSellosWidget> {
  bool isPreset = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 150,
            width: 240,
            margin: EdgeInsets.only(left: 45.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: isPreset
                ? TarjetaSellosBackWidget()
                : _buildSellosAcumulados(
                    widget.numeroSellos, widget.totalSellos)),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: FlatButton(
            child: Text('TOCA PARA GIRAR',
                style: TextStyle(color: Colors.white, fontSize: 9),
                textAlign: TextAlign.center),
            onPressed: () {
              setState(() {
                isPreset = !isPreset;
              });
            },
          ),
        ),
      ],
    );
  }

  List<Widget> getSello(int numsellos, int totalsellos, int row) {
    final children = <Widget>[];
    var i = 0;
    if (row == 2) i += 4;
    if (row == 1) if (totalsellos > 4) totalsellos = 4;
    for (i = i; i < totalsellos; i++) {
      if (numsellos > i)
        children.add(new SelloStarOnWidget());
      else
        children.add(new SelloStarOffWidget());
    }
    if (row == 1) row = 2;
    return children;
  }

  Padding _buildSellosAcumulados(nSellos, tSellos) {
    int numeroSellos = nSellos;
    int totalSellos = tSellos;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getSello(numeroSellos, totalSellos, 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getSello(numeroSellos, totalSellos, 2),
          ),
        ],
      ),
    );
  }
}

class SelloStarOffWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.stars, color: Colors.grey[800], size: 50);
  }
}

class SelloStarOnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey[600],
      child: Icon(
        Icons.star,
        color: Colors.yellow[700],
        size: 40,
      ),
    );
  }
}

class MiCuentaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.person),
          Text('Mi cuenta'),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MiCuenta()),
        );
      },
    );
  }
}

class NotificacionesWidget extends StatelessWidget {
  NotificacionesWidget({this.notifs});
  final notifs;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Stack(
        alignment: Alignment(-1.2, -1.6),
        children: [
          Row(
            children: <Widget>[
              Icon(Icons.notifications_active),
              Text('Notificaciones'),
            ],
          ),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: Colors.red[500],
              borderRadius: BorderRadius.circular(5),
            ),
            child: FutureBuilder<Welcome>(
              future: requestWelcome,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data.totalNotificaciones}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Notificaciones()),
        );
      },
    );
  }
}

class TarjetaSellosBackWidget extends StatelessWidget {
  final textCard =
      "Por cada 8 estrellas recibe una bebida gratis de nuestra seleción de bubbleTeas de temporada";
  final fecha_finCard = "Mayo 2020";
  final producto_card = "Bebida caliente";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 180,
                child: FutureBuilder<Welcome>(
                  future: requestWelcome,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data.participante.tarjetaSellos.descripcion}',
                        textAlign: TextAlign.center,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
          Text('Vigencia: $fecha_finCard'),
          Text('Premio: $producto_card'),
        ],
      ),
    );
  }
}
