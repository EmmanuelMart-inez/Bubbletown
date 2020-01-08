//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'premios_page.dart';

class Ayuda extends StatefulWidget {
  @override
  _AyudaState createState() => _AyudaState();
}

class _AyudaState extends State<Ayuda> {
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
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 35),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Ayuda', style: TextStyle(fontSize: 28)),
                          SizedBox(height: 5),
                          Text('\"Preguntas frecuentes\"', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Color(0xFFDADADA),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/ayuda/pago.png', scale: 4.5,),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Como recibir premios',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,  
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/ayuda/give.png', scale: 4.5,),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Programa de lealtad',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,  
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Color(0xFFDADADA),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/ayuda/escaneo.png', scale: 4.5,),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Como escaneo mi tarjeta',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,  
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/ayuda/bell.png', scale: 2,),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Notificaciones',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,  
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Color(0xFFDADADA),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/ayuda/cerdito.png', scale: 2,),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Qué son los bubblies?',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,  
                              ),
                            ),
                          ],
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
