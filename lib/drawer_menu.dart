import 'package:bubbletown_v1/ayuda_page.dart';
import 'package:bubbletown_v1/catalogo_page.dart';
import 'package:bubbletown_v1/escanea_page.dart';
import 'package:bubbletown_v1/login.dart';
import 'package:bubbletown_v1/micuenta_page.dart';
import 'package:bubbletown_v1/movimientos_page.dart';
import 'package:bubbletown_v1/notificaciones_page.dart';
import 'package:bubbletown_v1/premios_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerHamburguerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets
            .zero, // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        children: <Widget>[
          Image.asset(
            'assets/logobubbletown.jpg',
            scale: 6,
          ),
          // Divider(thickness: 2, color: Colors.black, height: 2,),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Mi cuenta'),
            onTap: () {
              // Then close the drawer
              Navigator.pop(context);
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MiCuenta()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('Mi tarjeta'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pago()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Premios'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Premios()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Notificaciones'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notificaciones()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Catálogo'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Catalogo()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.find_in_page),
            title: Text('Movimientos'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Movimientos()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Acerca de'),
            onTap: () {
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ayuda()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Cerrar Sesión'),
            onTap: () {
              // Delete token from local storage
              loggoutUserPreferences();
              // Update the state of the app
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              // ...
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void loggoutUserPreferences() async {
    final prefs = await SharedPreferences.getInstance()
        .catchError((onError) => print("$onError"));
    try {
      final result = await prefs.remove('bubbletownToken');
      if (result)
        print("Se logró eliminar el token de acceso (_id) participante");
    } catch (e) {
      print(e);
    }
  }
}
