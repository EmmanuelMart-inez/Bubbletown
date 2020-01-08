import 'package:bubbletown_v1/encuesta.dart';
import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'premios_page.dart';

class Notificaciones extends StatefulWidget {
  @override
  const Notificaciones({ Key key }) : super(key: key);
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  
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
                SizedBox(height: 5),
                Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                     decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset('assets/notif/like.png', scale: 4),
                            Text(
                              'Cómo estuvo tu bebida?', 
                              style: TextStyle(
                                fontSize: 17, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 4,
                              child: FlatButton(
                              
                              padding: EdgeInsets.all(0),
                                onPressed: () => {},
                                child: Icon(Icons.close, size: 20,),
                              ),
                            ),
                            
                            ],
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child:Text(
                            "Queremos brindarte un mejor servicio por lo cual tu satisfacción es nuestro objetivo",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 35),
                        Divider(height: 3, color: Colors.black),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Responder', style: TextStyle(fontWeight: FontWeight.bold),),
                              FlatButton(
                                onPressed: () => {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Encuesta()),
                                  )
                                },
                                child: Image.asset('assets/notif/check.png', scale: 4)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),  
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                     decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset('assets/notif/question.png', scale: 4),
                            Text(
                              'Cómo estuvo tu bebida?', 
                              style: TextStyle(
                                fontSize: 17, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(Icons.close, size: 23),
                            ],
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child:Text(
                            "Queremos brindarte un mejor servicio por lo cual tu satisfacción es nuestro objetivo",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 35),
                        Divider(height: 3, color: Colors.black),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Recordar más tarde', style: TextStyle(fontWeight: FontWeight.bold),),
                              Image.asset('assets/notif/check.png', scale: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Container(
                     decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset('assets/notif/like.png', scale: 4),
                            Text(
                              'Cómo estuvo tu bebida?', 
                              style: TextStyle(
                                fontSize: 17, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(Icons.close, size: 23),
                            ],
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child:Text(
                            "Queremos brindarte un mejor servicio por lo cual tu satisfacción es nuestro objetivo",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 35),
                        Divider(height: 3, color: Colors.black),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Recordar más tarde', style: TextStyle(fontWeight: FontWeight.bold),),
                              Image.asset('assets/notif/check.png', scale: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
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