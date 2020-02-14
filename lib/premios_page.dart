import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:bubbletown_v1/models/premios_model.dart';
import 'package:bubbletown_v1/services/premios_service.dart';
import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';

Future<PremiosModel> requestPremios;

class Premios extends StatefulWidget {
  @override
  const Premios({Key key}) : super(key: key);
  _PremiosState createState() => _PremiosState();
}

class _PremiosState extends State<Premios> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
    Tab(text: '3'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(vsync: this, length: myTabs.length);
    requestPremios = fetchPremios();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 10),
                        child: Text('Bubble\nTown',
                            style: TextStyle(fontSize: 13)),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 10, top: 10),
                      //   child: IconButton(
                      //     icon:
                      //         Icon(Icons.menu, color: Colors.black, size: 30.0),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Divider(color: Colors.black),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 45,
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios, size: 35),
                                    onPressed: () =>
                                        Navigator.of(context).pop()),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Premios',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        endDrawer: DrawerHamburguerMenu(),
        body: PremiosScrollView(),
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

class TabRoundedBodyContent extends StatelessWidget {
  const TabRoundedBodyContent({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 800,
      padding: EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.red[100],
      child: TabBarView(
        controller: _tabController,
        children: [
          Text('hola'),
          Text('hola'),
          Text('hola'),
        ],
      ),
    );
  }
}

class TabRoundedTopBar extends StatelessWidget {
  const TabRoundedTopBar({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 130),
      width: 200,
      height: 40,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TabBar(controller: _tabController, tabs: [
          CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
          CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
          CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
        ]),
      ),
    );
  }
}

class PremiosScrollView extends StatefulWidget {
  // PremiosScrollView({this.st});
  // final String st;

  @override
  _PremiosScrollViewState createState() => _PremiosScrollViewState();
}

class _PremiosScrollViewState extends State<PremiosScrollView> {
  _PremiosScrollViewState({this.st});
  final String st;

  Future<void> _neverSatisfied(String st) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text('Código listo para ser escaneado!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  BarCodeImage(
                    params: EAN13BarCodeParams(
                      '${st.toUpperCase()}',
                      //'1235',
                      lineWidth:
                          2, // width for a single black/white bar (default: 2.0)
                      barHeight:
                          100.0, // height for the entire widget (default: 100.0)
                      withText:
                          false, // Render with text label or not (default: false)
                    ),
                    onError: (error) {
                      // Error handler
                      print('error = $error');
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 240,
                    width: 240,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QrImage(
                        data: '${st.toUpperCase()}',
                        version: QrVersions.auto,
                        size: 220.0,
                      ),
                      // Image.network('http://2.bp.blogspot.com/-fUGggfrgxS8/Tk7rgOaqP_I/AAAAAAAABCI/sbE8ddlPOsQ/s1600/achoshare+QR+code.png', scale: 1.5,),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PremiosModel>(
      future: requestPremios,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            children: List.generate(snapshot.data.premios.length, (index) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _neverSatisfied(snapshot
                            .data.premios[index].codigoBarras
                            .toString());
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Image.asset('assets/premiosbackground.png',
                                  scale: 1.4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(
                                        '${changeImageFormatToUpper(snapshot.data.premios[index].imagenIcon)}',
                                        scale: 1.2),
                                  ),
                                  Text('${snapshot.data.premios[index].nombre}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  SizedBox(height: 11),
                                  BarCodeImage(
                                    params: Code39BarCodeParams(
                                      '${snapshot.data.premios[index].codigoBarras.toString()}',
                                      // '1235',
                                      lineWidth:
                                          0.30, // width for a single black/white bar (default: 2.0)
                                      barHeight:
                                          15.0, // height for the entire widget (default: 100.0)
                                      withText:
                                          false, // Render with text label or not (default: false)
                                    ),
                                    onError: (error) {
                                      // Error handler
                                      print('error = $error');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
        ));
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
