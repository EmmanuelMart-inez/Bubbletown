import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';

class Premios extends StatefulWidget {
  @override
  const Premios({ Key key }) : super(key: key);
  _PremiosState createState() => _PremiosState();
}

class _PremiosState extends State<Premios> with SingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
    Tab(text: '3'),
  ];
  
  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10),
                      child: Icon(Icons.arrow_back_ios, size: 35),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  'Premios',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 130),
                  width: 200,
                  height: 40,

                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
                        CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
                        CircleAvatar(radius: 10.0, backgroundColor: Colors.grey[350]),
                      ]),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 800,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.red[100],
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Image.asset('assets/premiosimagen.png', scale: 1.45),
                                            Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                            SizedBox(height: 11),
                                            Image.asset('assets/premios_codbarras.png', scale: 1.3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.topCenter,
                                      children: <Widget>[
                                        Image.asset('assets/premiosbackground.png', scale: 1.4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                        ),
                      ),
                      Container(
                        child: Column(
                        ),
                      ),
                    ],
                  ),
                ),                 
              ],
            ),
          ),
        ),
        bottomNavigationBar:  Container(
          height: 105,
          decoration: BoxDecoration(
            border: Border(
            top: BorderSide(width: 0.7, color: Colors.black),)
          ),
          child: BottomNavigationBar(
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/bottombar/inicio.png', scale: 2,),
                title: Text('Inicio', style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/bottombar/bar.png', scale: 2,),
                title: Text('Tarjeta', style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/bottombar/catalogo.png', scale: 2,),
                title: Text('Catálogo', style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/bottombar/premios.png', scale: 2,),
                title: Text('Premios', style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
            ],
            onTap: (int index){
              setState((){
                if(index == 0){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
                if(index == 1){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pago()),
                  );
                }
                if(index == 2){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Catalogo()),
                  );
                }
                if(index == 3){
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