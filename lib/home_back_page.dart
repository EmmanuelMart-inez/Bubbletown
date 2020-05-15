//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'ayuda_page.dart';
import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'micuenta_page.dart';
import 'notificaciones_page.dart';
import 'premios_page.dart';

class Home_back extends StatefulWidget {
  @override
  _Home_backState createState() => _Home_backState();
}

class _Home_backState extends State<Home_back> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
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
            child: Column(
              children: <Widget>[
                Divider(color: Colors.black),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Text('Mi cuenta'),
                          ],
                        ),
                         onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MiCuenta()),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: Stack(
                          alignment: Alignment(-1.2,-1.6),
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(Icons.notifications_active),
                                Container(
                                  child: Text('Notificaciones')
                                ),
                              ],
                            ),

                            Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                color: Colors.red[500],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ], 
                        ),
                        onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Notificaciones()),
                        );
                      },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Bienvenido ', style: TextStyle(fontSize: 32)),
                    Text(
                      'Emmanuel',
                      style: TextStyle(fontSize: 32, color: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Image.asset('assets/bubbliehappy.png', scale: 1),
                TarjetaSellosBackWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Detalles',
                          style: TextStyle(fontSize: 13),
                        ),
                        onPressed: (){
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ayuda()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 85,
                      //margin: EdgeInsets.symmetric(vertical: 30),
                      padding: const EdgeInsets.only(right: 20.0),
                      child: FlatButton(
                        //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        color: Colors.grey[350],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(' Redimir puntos', style: TextStyle(fontSize: 10)),
                                  SizedBox(height: 2),
                                  Text(' Pagar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                                  //SizedBox(height: 2),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('saldo', style: TextStyle(fontSize: 16, color: Colors.green[400])),
                                      Text('120', style: TextStyle(fontSize: 18, color: Colors.green[400])),
                                    ],
                                  ),
                                  Text('bubblies', style: TextStyle(fontSize: 11)),
                                ],
                              ),
                            ),
                            Image.asset('assets/credit-card.png', scale: 4.1)
                          ],
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Pago()),
                          );
                        },
                      ),
                    ),
                  ],
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

class TarjetaSellosBackWidget extends StatelessWidget {
  const TarjetaSellosBackWidget({
    Key key,
  }) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    child: Text('Por cada 8 estrellas recibe una bebida gratis de nuestra seleción de bubbleTeas de temporada', textAlign: TextAlign.center,
                    ),
                  ),
                ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: FlatButton(
            child: Text('TOCA PARA GIRAR', style: TextStyle(color: Colors.white, fontSize: 9), textAlign: TextAlign.center),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
