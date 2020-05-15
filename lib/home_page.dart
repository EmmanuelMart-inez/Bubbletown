//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/catalogo_page.dart';
import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:bubbletown_v1/escanea_page.dart';
import 'package:bubbletown_v1/fbreactions.dart';
import 'package:bubbletown_v1/http_error_page.dart';
import 'package:bubbletown_v1/login.dart';
import 'package:bubbletown_v1/micuenta_page.dart';
import 'package:bubbletown_v1/models/movimientos_model.dart';
import 'package:bubbletown_v1/models/tarjetapuntos_model.dart';
import 'package:bubbletown_v1/movimientos_page.dart';
import 'package:bubbletown_v1/premios_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'Storage/user.dart';
import 'Storage/globals.dart';
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
  bool _isThereToken = false;
  @override
  void initState() {
    super.initState();
    asyncTokenValidation();
  }

  void asyncTokenValidation() async {
    final token = await readTokenData();
    if (token != null) {
      requestWelcome = fetchWelcome();
      setState(() {
        _isThereToken = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isThereToken == true) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              automaticallyImplyLeading: false, // Used for removing back buttoon "<". 
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 38.0, top: 5.0),
                      child: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
              flexibleSpace: Container(
                width: double.infinity,
                child: new DefaultHeaderWidget(),
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
                          numeroSellos: snapshot.data.numSellos,
                          totalSellos: snapshot.data.tarjetaSellos.numSellos,
                          iconoOff: snapshot.data.tarjetaSellos.iconoOff,
                          iconoOn: snapshot.data.tarjetaSellos.iconoOn,
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return CircularProgressIndicator();
                      }
                      // print(snapshot);
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
    } else {
      return ExpiredTokenWidget();
    }
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
              scale: 1.5,
            ),
            title: Text('Inicio',
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/bottombar/bar.png',
              scale: 1.5,
            ),
            title: Text('Tarjeta',
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/bottombar/catalogo.png',
              scale: 1.5,
            ),
            title: Text('Catálogo',
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/bottombar/premios.png',
              scale: 1.5,
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

class ExpiredTokenWidget extends StatelessWidget {
  const ExpiredTokenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDCCAC7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            automaticallyImplyLeading: false, // Used for removing back buttoon "<". 
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Opacity(opacity: 0.3, child: DefaultHeaderWidget()),
            ),
          ),
        ),
        body: Container(
          color: Color(0xFFDCCAC7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  title: Container(
                    color: Color(0xFFEC5D57),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sesión expirada'),
                        IconButton(
                          iconSize: 20,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.all(0),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  contentTextStyle:
                      TextStyle(fontSize: 10, color: Colors.black, height: 1.3),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.access_time,
                          color: Color(0xFFDD6F6B),
                          size: 25,
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Text('Tu sesión ha expirado'),
                            ),
                            Text(
                              'Serás redirigido a la pagina de inicio de sesión',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      color: Color(0xFFEC5D57),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Welcome>(
      future: requestWelcome,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  snapshot.data.participante.sexo == 'Masculino'
                      ? 'Bienvenido  '
                      : 'Bienvenida  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32)),
              Flexible(
                child: Text(
                  '${snapshot.data.participante.nombre}',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(fontSize: 32, color: Colors.blueGrey),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
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
                      SizedBox(height: 7),
                      Text(' Pagar', style: TextStyle(fontSize: 28)),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('saldo ',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.green[400])),
                          FutureBuilder<Welcome>(
                            future: requestWelcome,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    '${snapshot.data.numPuntos.round()}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.green[400]));
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return CircularProgressIndicator();
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Text('Bubblies', style: TextStyle(fontSize: 12)),
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
              'Ayuda',
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
        // Padding(
        //   padding: const EdgeInsets.only(right: 28.0),
        //   child: FlatButton(
        //     padding: EdgeInsets.symmetric(horizontal: 30),
        //     color: Colors.grey[300],
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Text(
        //       'FacebookReactions',
        //       style: TextStyle(fontSize: 14),
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => FacebookReactions()),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class BubbleCardSellosWidget extends StatefulWidget {
  BubbleCardSellosWidget(
      {this.numeroSellos, this.totalSellos, this.iconoOff, this.iconoOn});
  final numeroSellos;
  final totalSellos;
  final iconoOff;
  final iconoOn;
  @override
  _BubbleCardSellosWidgetState createState() => _BubbleCardSellosWidgetState();
}

class _BubbleCardSellosWidgetState extends State<BubbleCardSellosWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  bool isPreset = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text('Value: ${_controller.value}... status: ${_controller.status}'),
        RotationTransitionOnY(
            alignment: Alignment(0.15, -1),
            turns: Tween(begin: 0.0, end: -0.5).animate(

                _controller.drive(CurveTween(curve: Curves.slowMiddle))),
            child: Container(
              height: 150,
              width: 240,
              margin: EdgeInsets.only(left: 45.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: isPreset
                  ? Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: FractionalOffset.center,
                      child: TarjetaSellosBackWidget())
                  : _buildSellosAcumulados(widget.numeroSellos,
                      widget.totalSellos, widget.iconoOff, widget.iconoOn),
            )),
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
                // print("Value: ${_controller.value}... status: ${_controller.status}");
                isPreset ? _controller.forward() : _controller.reverse();
              });
            },
          ),
        ),
      ],
    );
  }

  List<Widget> getSello(int numsellos, int totalsellos, int row,
      String iconoOff, String iconoOn) {
    final children = <Widget>[];
    var i = 0;
    if (row == 2) i += 5;
    if (row == 1) if (totalsellos > 5) totalsellos = 5;
    for (i = i; i < totalsellos; i++) {
      if (numsellos > i)
        children.add(Expanded(child: SelloOnWidget(filename: iconoOn)));
      else
        children.add(Expanded(child: SelloOffWidget(filename: iconoOff)));
    }
    if (row == 1) row = 2;
    return children;
  }

  Padding _buildSellosAcumulados(nSellos, tSellos, iconoOff, iconoOn) {
    int numeroSellos = nSellos;
    int totalSellos = tSellos;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  getSello(numeroSellos, totalSellos, 1, iconoOff, iconoOn),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  getSello(numeroSellos, totalSellos, 2, iconoOff, iconoOn),
            ),
          ),
        ],
      ),
    );
  }
}

class SelloOffWidget extends StatelessWidget {
  SelloOffWidget({this.filename});
  final filename;

  @override
  Widget build(BuildContext context) {
    if (filename != null && filename != "null") {
      return Image.network("$apiURLImages/$filename");
    } else
      return Icon(Icons.stars, color: Colors.grey[800], size: 50);
  }
}

// 10821686
class SelloStarOffWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.stars, color: Colors.grey[800], size: 50);
  }
}

class SelloOnWidget extends StatelessWidget {
  SelloOnWidget({this.filename});
  final filename;

  @override
  Widget build(BuildContext context) {
    if (filename != null && filename != "null") {
      return Image.network("$apiURLImages/$filename");
    } else
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
            // TODO: Alargar horizontalmente el widget de acuerdo a el numero de cifras de notificaciones
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
                        '${snapshot.data.tarjetaSellos.descripcion}',
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

/// Animates the rotation of a widget.
///
/// Here's an illustration of the [RotationTransition] widget, with it's [turns]
/// animated by a [CurvedAnimation] set to [Curves.elasticOut]:
/// {@animation 300 378 https://flutter.github.io/assets-for-api-docs/assets/widgets/rotation_transition.mp4}
/// See also:
///
///  * [ScaleTransition], a widget that animates the scale of a transformed
///    widget.
///  * [SizeTransition], a widget that animates its own size and clips and
///    aligns its child.
class RotationTransitionOnY extends AnimatedWidget {
  /// Creates a rotation transition.
  ///
  /// The [turns] argument must not be null.
  const RotationTransitionOnY({
    Key key,
    @required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(turns != null),
        super(key: key, listenable: turns);

  /// The animation that controls the rotation of the child.
  ///
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  Animation<double> get turns => listenable;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to top right corner, use
  /// an alignment of (1.0, -1.0) or use [Alignment.topRight]
  final Alignment alignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.rotationY(turnsValue * math.pi * 2.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
