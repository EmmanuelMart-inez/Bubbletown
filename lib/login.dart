import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/Storage/user.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// To read data, use the appropriate getter method provided by the SharedPreferences class.
// For each setter there is a corresponding getter.
// For example, you can use the getInt, getBool, and getString methods.

class LoginPage extends StatefulWidget {
  @override
  //static String tag = 'login-page';
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    readTokenData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150.0),
            Text(
              'Bubbletown',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.0,
              ),
            ),
            SizedBox(height: 35.0),
            Image.asset('assets/bubblies.png'),
            SizedBox(height: 45.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[600],
                border: Border.all(width: 3.0, color: Colors.grey[600]),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: MaterialButton(
                minWidth: 240.0,
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: MaterialButton(
                minWidth: 240.0,
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginForm()),
                  );
                },
                child: Text(
                  'Ya tengo una cuenta',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: crosAxisAlignment.start,
              children: <Widget>[
                Row(
                  //Icon(Icons.my_location, color: Colors.grey[500]),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.my_location, color: Colors.grey[500]),
                    Text(' Calle Marsella 14, Juárez, \n'
                        '06600 Col Juárez, CDMX')
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  //Icon(Icons.my_location, color: Colors.grey[500]),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer, color: Colors.grey[500]),
                    Text('Abierto')
                  ],
                ),
                Row(
                  //Icon(Icons.my_location, color: Colors.grey[500]),
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('10:00am - 11:00 pm')],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
