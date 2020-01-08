import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'home_page.dart';
import 'premios_page.dart';
import 'package:bubbletown_v1/services/welcome_service.dart';
import 'package:bubbletown_v1/models/welcome_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen/screen.dart';

Future<Welcome> requestTarjeta;

class Pago extends StatefulWidget {
  @override
  _PagoState createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  
  @override
  void initState() {
    super.initState();
    requestTarjeta = fetchWelcome();
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.black, size: 30.0),
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
                /*new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("Screen is kept on ? "),
                      new Checkbox(value: _isKeptOn, onChanged: (bool b){
                        Screen.keepOn(b);
                        setState((){_isKeptOn = b; });
                      })
                    ]
                  ),
                  new Text("Brightness :"),
                  new Slider(value : _brightness, onChanged : (double b){
                    setState((){_brightness = b;});
                    Screen.setBrightness(b);
                  }),
                  */
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 35),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  'Escanea ahora!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 25),
                Stack(
                  alignment: Alignment(0, -0.5),
                  children: <Widget>[
                    Container(
                      height: 270,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 10, color: Colors.black),
                      ),
                      child: Text(
                        'Bubblecard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 10, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder<Welcome>(
                            future: requestTarjeta,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data.participante.id.toUpperCase()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
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
                    ),
                    Positioned(
                      bottom: 25,
                      child: FutureBuilder<Welcome>(
                        future: requestWelcome,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return QrImage(
                              data: '${snapshot.data.participante.id}',
                              version: QrVersions.auto,
                              size: 120,
                              gapless: true,
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Text(
                    'La iluminación de tu pantalla podría cambiar momentaneamente para leer el código',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                /*Stack(
                  alignment: Alignment(0, 0.3),
                  children: <Widget>[
                    Stack(
                      alignment: Alignment(0, -0.55),
                      children: <Widget>[
                        Image.asset(
                          'assets/credit-card2.png',
                          scale: 1.5,
                        ),
                        Text(
                          'Bubblecard',
                          style:  TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/qr-code.png',
                       scale: 4,
                    ),
                  ],
                ),*/
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
