//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:bubbletown_v1/editarperfil_page.dart';
import 'package:bubbletown_v1/models/participante_model.dart';
import 'package:bubbletown_v1/models/welcome_model.dart';
import 'package:bubbletown_v1/movimientos_page.dart';
import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/services/welcome_service.dart';
import 'package:bubbletown_v1/terminosycondiciones_page.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:bubbletown_v1/Storage/user.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'ayuda_page.dart';
import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'premios_page.dart';

Future<Welcome> requestParticipante;

class MiCuenta extends StatefulWidget {
  @override
  _MiCuentaState createState() => _MiCuentaState();
}

class _MiCuentaState extends State<MiCuenta> {
  int colorPaletteIndex = 0;
  final controller = PageController(viewportFraction: 0.5, initialPage: 0
      // initialPage: 4
      );

  @override
  void initState() {
    getColorPalette();
    requestParticipante = fetchWelcome();
    super.initState();
  }

  // Get current color palette
  void getColorPalette() async {
    final pIndex = await readTheme('indexPallete');
    if (pIndex == '-1')
      setState(() {
        colorPaletteIndex = 0;
      });
    else
      setState(() {
        colorPaletteIndex = int.parse(pIndex);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            automaticallyImplyLeading:
                false, // Used for removing back buttoon "<".
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
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10, top: 5),
                  //   child: IconButton(
                  //     icon: Icon(Icons.menu, color: Colors.black, size: 25.0),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: <Widget>[
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Mi cuenta ', style: TextStyle(fontSize: 38)),
                    ],
                  ),
                  SizedBox(height: 45),
                  Container(
                    //color: Color(0xFFDADADA),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset('assets/micuenta/profile.png',
                                scale: 2.9),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              FutureBuilder<Welcome>(
                                future: requestParticipante,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Container(
                                              width: 130,
                                              child: Text(
                                                '${snapshot.data.participante.nombre}',
                                                style: TextStyle(fontSize: 16),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            'Puntos: ${snapshot.data.numPuntos.toString()}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            'Sellos: ${snapshot.data.numSellos.toString()}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        // // Padding(
                                        // //   padding:const  EdgeInsets.symmetric(vertical: 8.0),
                                        // //   child: Row(
                                        // //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        // //     children: <Widget>[
                                        // //       Text('04/Mayo/2021  ', style: TextStyle(fontSize: 14),),
                                        // //       Text('7:30 am', style: TextStyle(fontSize: 14),),
                                        // //     ],
                                        // //   ),
                                        // // ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return CircularProgressIndicator();
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFDADADA),
                    ),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/micuenta/edit.png', scale: 3),
                          SizedBox(width: 10),
                          Text(
                            'Editar Perfil',
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarPerfil()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFDADADA),
                    ),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/micuenta/movimientos.png',
                              scale: 3),
                          SizedBox(width: 10),
                          Text(
                            'Movimientos',
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Movimientos()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFDADADA),
                    ),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/micuenta/ayuda.png', scale: 3),
                          SizedBox(width: 10),
                          Text(
                            'Ayuda',
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ayuda()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFDADADA),
                    ),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Terminos de uso y políticas de privacidad',
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TerminosCondicionesPage()));
                      },
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 36,
                            ),
                            // Text(page.toString()),
                            SizedBox(
                              height: 30,
                              child: PageView(
                                  reverse: false,
                                  onPageChanged: (int currentPage) => {
                                        setState(() {
                                          colorPaletteIndex = currentPage;
                                          // page = currentPage;
                                          setPreference('indexPallete',
                                              currentPage.toString());
                                        })
                                      },
                                  controller: controller,
                                  children: List.generate(
                                      colorPalette.length,
                                      (int index) => Card(
                                            key: PageStorageKey<String>(
                                                index.toString()),
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         BorderRadius.circular(16)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      color: Color(int.parse(
                                                          "0xFF${colorPalette[index][0]}")),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      color: Color(int.parse(
                                                          "0xFF${colorPalette[index][1]}")),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      color: Color(int.parse(
                                                          "0xFF${colorPalette[index][2]}")),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      color: Color(int.parse(
                                                          "0xFF${colorPalette[index][3]}")),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              child: SmoothPageIndicator(
                                controller: controller,
                                count: colorPalette.length,
                                effect: WormEffect(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
