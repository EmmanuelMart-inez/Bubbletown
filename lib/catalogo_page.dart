import 'package:flutter/material.dart';

import 'escanea_page.dart';
import 'home_page.dart';
import 'premios_page.dart';

class Catalogo extends StatefulWidget {
  @override
  const Catalogo({ Key key }) : super(key: key);
  _CatalogoState createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> with SingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ALIMENTOS'),
    Tab(text: 'BEBIDAS'),
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
                          border: Border.all(color: Colors.black, width: 1.2)
                        ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Sweet chocolate macadamia nut syrup, rich expreso and steamed half and half',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Acai Smoothie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Smooth, refreshing and great source of antioxidants',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Sweet chocolate macadamia nut syrup, rich expreso and steamed half and half',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Acai Smoothie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Smooth, refreshing and great source of antioxidants',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Sweet chocolate macadamia nut syrup, rich expreso and steamed half and half',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Acai Smoothie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Smooth, refreshing and great source of antioxidants',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Tea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Sweet chocolate macadamia nut syrup, rich expreso and steamed half and half',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bebida.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Acai Smoothie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Smooth, refreshing and great source of antioxidants',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
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
                          children: <Widget>[
                            SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bolipan.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('Bolipán', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Sweet chocolate macadamia nut syrup, rich expreso and steamed half and half',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/bolipanes.png', scale: 3),
                                    SizedBox(height: 10),
                                    Text('2Pack Bolipán', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    SizedBox(height: 3),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        'Smooth, refreshing and great source of antioxidants',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
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