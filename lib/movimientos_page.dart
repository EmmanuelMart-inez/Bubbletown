//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/services/movimientos_service.dart';
import 'package:flutter/material.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'models/movimientos_model.dart';
import 'premios_page.dart';

Future<MovimientosModel> requestMovimientos;

class Movimientos extends StatefulWidget {
  @override
  _MovimientosState createState() => _MovimientosState();
}

class _MovimientosState extends State<Movimientos> {
  @override
  void initState() {
    super.initState();
    requestMovimientos = fetchMovimientos();
  }

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
                      Text('Movimientos', style: TextStyle(fontSize: 28)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Color(0xFFDADADA),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 2),
                        Image.asset('assets/movimientos/gift.png', scale: 1.8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Canjeo de bebida',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,  
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Breve descripción',
                              style: TextStyle(
                                fontSize: 16,  
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('-', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFE33E3E)),),
                                Text('\$25', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF000000)),),
                              ],
                            ),
                             Text('bubblies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF000000)),),
                          ],
                        ),
                        FlatButton(
                          onPressed: (){},
                          child: Image.asset('assets/movimientos/basura.png', scale: 1.7,)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: Color(0xFFDADADA),
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black),
                        top: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //SizedBox(width: 1),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Image.asset('assets/movimientos/descuento.png', scale: 1.8,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Premio',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,  
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'fecha',
                              style: TextStyle(
                                fontSize: 16,  
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('+', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF27E923)),),
                                Text('\$25', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF000000)),),
                              ],
                            ),
                             Text('bubblies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF000000)),),
                          ],
                        ),
                        Container(
                          child: FlatButton(
                            //padding: EdgeInsets.all(0),
                            onPressed: (){},
                            child: Image.asset('assets/movimientos/basura.png', scale: 1.7,)
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
