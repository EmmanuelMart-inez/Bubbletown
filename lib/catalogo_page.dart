import 'package:bubbletown_v1/services/catalogo_service.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/drawer_menu.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'models/catalogo_model.dart';
import 'premios_page.dart';
import 'Storage/globals.dart';

Future<Catalogomodel> requestCatalogoBebidas;
Future<Catalogomodel> requestCatalogoAlimentos;

class Catalogo extends StatefulWidget {
  @override
  const Catalogo({Key key}) : super(key: key);
  _CatalogoState createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ALIMENTOS'),
    Tab(text: 'BEBIDAS'),
  ];

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    requestCatalogoBebidas = fetchCatalogo('Bebidas');
    requestCatalogoAlimentos = fetchCatalogo('Alimentos');
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        body: Container(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.arrow_back_ios, size: 35),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  'Catálogo',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1.2)),
                  child: Container(
                    margin: EdgeInsets.only(right: 4),
                    child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.red,
                        indicator: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        tabs: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              //border: Border.all(color: Colors.black, width: 1)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Bebidas'),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Alimentos'),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    //height: 900,
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    //color: Colors.red[100],
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BebidasScrollCatalogo(),
                        AlimentosScrollCatalogo(),

                        // GridView.count(
                        //   primary: false,
                        //   padding: const EdgeInsets.all(10),
                        //   childAspectRatio: 0.85,
                        //   crossAxisSpacing: 10,
                        //   mainAxisSpacing: 10,
                        //   crossAxisCount: 2,
                        //   children: <Widget>[

                        //   ],
                        // )
                      ],
                    ),
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

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}

class BebidasScrollCatalogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Catalogomodel>(
      future: requestCatalogoBebidas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: List.generate(snapshot.data.catalogo.length, (index) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                          '${apiURLImages}/${this.changeImageFormatToUpper(snapshot.data.catalogo[index].imagen)}',
                          scale: 1),
                    ),
                    SizedBox(height: 10),
                    Text('${snapshot.data.catalogo[index].titulo}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(height: 3),
                    Container(
                      width: 120,
                      child: Text(
                        '${snapshot.data.catalogo[index].descripcion}',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return CircularProgressIndicator();
        }
        return FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: CircularProgressIndicator(),
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

  Catalogomodel getCategoriaByTipo(Catalogomodel cat) {
    Catalogomodel newcat;
    for (var item in cat.catalogo) {
      if (item.tipo == 'Alimentos') {
        newcat.catalogo.add(item);
      } else if (item.tipo == 'Bebidas') {
        newcat.catalogo.add(item);
      }
    }
    return newcat;
  }
}

class AlimentosScrollCatalogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Catalogomodel>(
      future: requestCatalogoAlimentos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: List.generate(snapshot.data.catalogo.length, (index) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                          '${apiURLImages}/${this.changeImageFormatToUpper(snapshot.data.catalogo[index].imagen)}',
                          scale: 1),
                    ),
                    SizedBox(height: 10),
                    Text('${snapshot.data.catalogo[index].titulo}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(height: 3),
                    Container(
                      width: 120,
                      child: Text(
                        '${snapshot.data.catalogo[index].descripcion}',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
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
        return FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: CircularProgressIndicator(),
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

  Catalogomodel getCategoriaByTipo(Catalogomodel cat) {
    Catalogomodel newcat;
    for (var item in cat.catalogo) {
      if (item.tipo == 'Alimentos') {
        newcat.catalogo.add(item);
      } else if (item.tipo == 'Bebidas') {
        newcat.catalogo.add(item);
      }
    }
    return newcat;
  }
}
